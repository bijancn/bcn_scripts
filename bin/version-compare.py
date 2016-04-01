#!/usr/bin/python

def string_to_tpl_list(strg):
  versions = [v.strip() for v in (strg.strip()).split(' ', 1)]
  numbers = [v.split('.') for v in versions]
  return zip(numbers[0], numbers[1])

def who_is_bigger(strg):
  tpl_lst = string_to_tpl_list(strg)
  a_bigger = None
  for a, b in tpl_lst:
    try:
      if int(a) > int(b):
        a_bigger = True
        break
      if int(a) < int(b):
        a_bigger = False
        break
    except ValueError:
      a_bigger = False
      break
  if a_bigger is None:
    return 'equal'
  elif a_bigger:
    return 'first'
  else:
    return 'second'

def test_who_is_bigger():
  from nose.tools import eq_
  versions = '  1.2.3   3.2.1  '
  eq_ (who_is_bigger(versions), 'second')
  versions = '  1.2.3   1.2.4  '
  eq_ (who_is_bigger(versions), 'second')
  versions = '  1.4.3   1.2.4  '
  eq_ (who_is_bigger(versions), 'first')
  versions = '  1.4.3   1.4.3  '
  eq_ (who_is_bigger(versions), 'equal')
  versions = '  11.4.3   9.4.3  '
  eq_ (who_is_bigger(versions), 'first')
  versions = '  8.4   8.21  '
  eq_ (who_is_bigger(versions), 'second')
  versions = '  abc   8.21  '
  eq_ (who_is_bigger(versions), 'second')

if __name__ == "__main__":
  import sys
  print who_is_bigger(' '.join(sys.argv[1:]))
