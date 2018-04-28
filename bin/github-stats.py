#!/usr/bin/env python
import calendar
import datetime
import urllib2
import json
import argparse
def colored_mock(string, color, attrs=[]):
  return string
try:
  from termcolor import colored
  multiplier = 15
except ImportError:
  print('No colors until you install termcolor (pip install termcolor)')
  colored = colored_mock
  multiplier = 6

GITHUB_API = "https://srv-git-01-hh1.alinghi.tipp24.net/api/v3"
OWNER = "hpo"
ORG_SELECTOR = "org:" + OWNER + "+"

# Parse command line options
parser = argparse.ArgumentParser(description='Get PR statistics',
    formatter_class=argparse.ArgumentDefaultsHelpFormatter)

parser.add_argument('user', help='The git user(s) you are interested in. Can be one user like foo or multiple ones, separated by commas, like foo,bar,baz')
parser.add_argument('month', help='The month(s) you are interested in. You can give a range like 8-11 or only one like 12.')
parser.add_argument('-y', '--year', help='The year you are interested in.  Defaults to the current year.', default=datetime.datetime.now().year)
parser.add_argument('-s', '--summary', help='Only show the summed numbers and not the individual PRs.', action='store_true')
parser.add_argument('-n', '--no_color', help='Disable colors.', action='store_true')
parser.add_argument('-v', '--verbose', help='Show URLs used', action='store_true')
args = parser.parse_args()
if args.no_color:
  colored = colored_mock
  multiplier = 6

def getPullRequestUrl(repo, number):
  return GITHUB_API + "/repos/" + OWNER + "/" + repo + "/pulls/" + str(number)

def getPullRequest(repo, number):
  url = getPullRequestUrl(repo, number)
  return urllib2.urlopen(url)

def getList(pageNumber, user, yearMonthDay):
  url = (GITHUB_API + "/search/issues?q=" + ORG_SELECTOR +
       "author:" + user + "+is:pr+created:<=" + yearMonthDay)
  paginated_url = url + '&page=' + str(pageNumber) + '&per_page=100'
  if args.verbose:
    print 'url = ', paginated_url
  r = urllib2.urlopen(paginated_url)
  data = json.load(r)
  return data['items']

def main(user, month):
  yearMonthDay = str(datetime.date(args.year, month, calendar.monthrange(args.year, month)[1]))
  beginningOfMonth = datetime.datetime(args.year, month, 1)
  pageNum = 1
  items = getList(pageNum, user, yearMonthDay)
  #  while len(items) % 100 == 0:
  #    pageNum += 1
  #    items += getList(pageNum, user, yearMonthDay)
  colored_columns = '%' + str(multiplier + 5) + "s " + \
    ' '.join(['%' + str(multiplier) + 's'] * 3)
  formatter = '%25s '+ colored_columns + ' %10s %s'
  total_prs = 0
  total_adds = 0
  total_dels = 0
  total_summed = 0
  if not args.summary:
    print formatter % ("Repo", colored("PR", "cyan", attrs=["bold"]),
                       colored("Add", 'green'), colored("Del", 'red'),
                       colored("Sum", 'blue'), "Created", "Title")
  for item in items:
    title = item['title']
    pullRequestNumber = item['number']
    repoUrl = item['repository_url']
    repo = repoUrl.split('/')[-1]
    detail_json = json.load(getPullRequest(repo, pullRequestNumber))
    adds = detail_json['additions']
    total_adds += adds
    dels = detail_json['deletions']
    total_dels += dels
    summed = min(adds + dels, 1000)
    total_summed += summed
    total_prs += 1
    created = detail_json['created_at'][:10]
    if datetime.datetime.strptime(created, '%Y-%m-%d') < beginningOfMonth:
      break
    if not args.summary:
      pr_str = colored(pullRequestNumber, 'cyan', attrs=['bold'])
      add_str = colored('+' + str(adds), 'green')
      del_str = colored('-' + str(dels), 'red')
      tot_str = colored(str(summed), 'blue')
      print formatter % (repo, pr_str, add_str, del_str, tot_str,
                         created, title)
  total_adds_str = colored('+' + str(total_adds), 'green')
  total_dels_str = colored('-' + str(total_dels), 'red')
  total_tots_str = colored(str(total_summed), 'blue')
  total_prs_str = colored(str(total_prs), 'cyan', attrs=['bold'])
  if not args.summary:
    print '=' * 100
    print formatter % ('total', total_prs_str, total_adds_str, total_dels_str,
                       total_tots_str, '', '')
  else:
    formatter = '%20s ' + colored_columns
    print formatter % (user, total_prs_str, total_adds_str, total_dels_str,
                       total_tots_str)
  return (user, total_adds, total_dels, total_summed, total_prs)

def add_to_dict(result_dict, user, number):
  tmp = {user: number}
  try:
    result_dict[user] += number
  except KeyError:
    result_dict.update(tmp)
  return result_dict

summed_dict = {}
prs_dict = {}
months = map(int, args.month.split('-'))
if len(months) > 1:
  monthRange = range(months[0], months[1] + 1)
else:
  monthRange = months
for month in monthRange:
  print args.year, calendar.month_name[month]
  if args.user == "all":
    for user in ['bijan-chokoufe', 'denis-borisenko', 'kai-hoffmann',
                 'nenad-nikolic', 'rastislav-vojtko', 'sebastian-naefe']:
      (user, adds, dels, summed, prs) = main(user, month)
      add_to_dict(summed_dict, user, summed)
      add_to_dict(prs_dict, user, prs)
  else:
    main(args.user, month)

for (key, value) in summed_dict.iteritems():
  print key, value, prs_dict[key], value / prs_dict[key]
