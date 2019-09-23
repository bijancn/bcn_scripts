#!/usr/bin/python
import sys
import datetime
import calendar

def year_and_month():
  if len(sys.argv) < 2:
    return [now.year, now.month]
  else:
    without_ending = sys.argv[1].rsplit(".", 1)[0]
    without_start = without_ending.split("monthly_")[1]
    return without_start.split("-")

# Expecting filename in monthly-MM.foo format
now = datetime.datetime.now()
year, month_number = year_and_month()
first_day, month_range = calendar.monthrange(int(year), int(month_number))
month_name = calendar.month_name[int(month_number)]
week_days = ["M", "T", "W", "T", "F", "S", "S"]

template = """# Monthly Log - {month_name} {year}

"""

days = ""
for i in range(month_range):
  days += "- {:02d} {:s}\n".format(i + 1, week_days[(first_day + i) % 7])

print(template.format(month_name=month_name, year=year) + days)
