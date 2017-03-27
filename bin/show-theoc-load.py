#!/usr/bin/env python
import subprocess
import re
import argparse
try:
  from termcolor import colored
except ImportError:
  print 'No colors until you install termcolor'
  colored = lambda string, color: string

# Parse command line options
parser = argparse.ArgumentParser(
    description='Show theoc load and potentially produce host_file',
    formatter_class=argparse.ArgumentDefaultsHelpFormatter)

# optional tasks that will be performed
parser.add_argument("-f", '--host_file', action='store_true',
    help='Create host_file')

# options how to behave
parser.add_argument("-s", '--safety', default=0, type=int,
    help='Number of cores to leave at least free')
parser.add_argument("-m", '--min_cores', default=1, type=int,
    help='Only use machines that can allocate at least MIN_CORES')
parser.add_argument("-n", '--num_cores', default=300, type=int,
    help='Try to use NUM_CORES if available and respecting SAFETY and MIN_CORES')

args = parser.parse_args()


def get_users(lines):
  users = []
  for line in lines[:-40]:
    users += [line.split(' ')[0]]
  if len(users) > 0:
    users_strg = ','.join(set(users))
  else:
    users_strg = '[]'
  return users_strg


def get_color(load5, real_cores):
  if load5 / real_cores > 0.5:
    color = 'red'
  elif load5 / real_cores < 0.05:
    color = 'green'
  else:
    color = 'yellow'
  return color


def add_to_usage_dict(top_usage, user, usage):
  tmp = {user: usage}
  try:
    top_usage[user] += usage
  except KeyError:
    top_usage.update(tmp)
  return top_usage


def compute_top_usage(top_processes):
  top_usage = {}
  for line in top_processes:
    usage = float(line.split(' ')[0])
    user = line.split(' ')[1]
    top_usage = add_to_usage_dict(top_usage, user, usage)
  usage_strg = ''
  for user in top_usage:
    usage_strg += user + ':%3.1f' % (top_usage[user] / 100) + ' '
  return usage_strg, top_usage


def checkout_machine(f, machine, total_cores, total_load, total_use_cores,
                     total_usage_dict):
  ret = subprocess.check_output(
      ["ssh", machine, "uptime &&", "who &&",
       "ps -eo pcpu,user | sed -e 's/^[[:space:]]*//' | " +
       "sort -k1 -r | head -41 |tail -40 &&",
       "grep '^core id' /proc/cpuinfo | sort -u | wc -l &&",
       "echo $(($(grep \"^physical id\" /proc/cpuinfo | " +
       "awk \'{print $4}\' | sort -un | tail -1)+1))"])
  lines = ret.split('\n')
  if lines.pop() != '':
    print "show-theoc-load.py: ALERT THIS SHOULD HAVE BEEN EMPTY"
  real_cores = int(lines.pop()) * int(lines.pop())
  total_cores += real_cores
  load5 = float(re_l.search(lines.pop(0)).group(1))
  total_load += min(load5, real_cores)
  users_strg = get_users(lines)
  color = get_color(load5, real_cores)
  top_processes = filter(lambda line: float(line.split(' ')[0]) > 5, lines[-40:])
  usage_strg, usage_dict = compute_top_usage(top_processes)
  for user, usage in usage_dict.iteritems():
    total_usage_dict = add_to_usage_dict(total_usage_dict, user, usage)
  use_cores = max(int(round(real_cores - load5 - args.safety)), 0)
  if machine == "theoc01":
      use_cores = max(use_cores - 3, 0)
  not_too_many = total_use_cores < args.num_cores
  if use_cores > args.min_cores and not_too_many:
    f.write(machine + ':' + str(use_cores) + '\n')
    total_use_cores += use_cores
  else:
    use_cores = 0
  string = machine + " load5: %4.1f" % load5 + '  cores: %2i' % real_cores + \
      "  would-use: %2i" % use_cores + \
      '  usage: ' + usage_strg + "  loggedin:%10s" % users_strg
  print colored(string, color)
  return total_cores, total_load, total_use_cores, total_usage_dict


re_l = re.compile("([0-9]+\.[0-9]+), ([0-9]+\.[0-9]+)$")
total_cores = 0
total_use_cores = 0
total_load = 0.0
total_usage_dict = {}
with open('host_file', 'w') as f:
  for i in range(1, 36):
    if not i == 13:
        machine = "theoc%02d" % (i)
        try:
            total_cores, total_load, total_use_cores, total_usage_dict = \
                checkout_machine(f, machine, total_cores, total_load,
                                 total_use_cores, total_usage_dict)
        except subprocess.CalledProcessError:
            print 'Could not connect to ' + machine
print "=" * 90
print "total number of cores: " + str(total_cores) + "  loaded with " + \
    str(total_load) + " (%4.1f" % (total_load / total_cores * 100) + " %)  " + \
    "free cores: " + str(total_cores - total_load)
sortedvalues = sorted(total_usage_dict, key=total_usage_dict.get, reverse=True)
sortedList = [(k, total_usage_dict[k]) for k in sortedvalues]
print "total-usage:", ' '.join([user + ':%3.1f' % (usage / 100) for
                                user, usage in sortedList if usage > 200])
print "I could use " + str(total_use_cores) + " cores"
