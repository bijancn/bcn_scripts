#!/usr/bin/env python3
import subprocess
import argparse

parser = argparse.ArgumentParser(description='Move the mouse',
    formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("direction", help='horizontal or vertical')
parser.add_argument("-c", '--click', action='store_true',
    help='Click after moving')
args = parser.parse_args()

get_output = lambda cmd: subprocess.check_output(cmd).decode("utf-8")
current_mouse_pos = [int(n) for n in [it.split(":")[1] for it in
  get_output(["xdotool", "getmouselocation"]).split()[:2]]]
screendata = [(s.split("x")[0], s.split("x")[1].split("+")[0]) for s in
    get_output(["xrandr"]).split() if "+0+0" in s ][0]
screendata = [int(n) for n in screendata]
if args.direction == 'horizontal':
  if current_mouse_pos[0] < screendata[0]:
      command = ["xdotool", "mousemove", "--sync",
          str(current_mouse_pos[0]+screendata[0]), str(current_mouse_pos[1])]
  else:
      command = ["xdotool", "mousemove", "--sync",
          str(current_mouse_pos[0]-screendata[0]), str(current_mouse_pos[1])]
elif args.direction == 'vertical':
  if current_mouse_pos[1] < screendata[1]:
      command = ["xdotool", "mousemove", "--sync",
          str(current_mouse_pos[0]), str(current_mouse_pos[1]+screendata[1])]
  else:
      command = ["xdotool", "mousemove", "--sync",
          str(current_mouse_pos[0]), str(current_mouse_pos[1]-screendata[1])]
else:
  raise Exception("Invalid argument!")

subprocess.Popen(command)
if args.click:
  subprocess.Popen(["xdotool", "click", "1"])
