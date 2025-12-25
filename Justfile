set dotenv-load
set shell := [ 'zsh', '-cu', '-o', 'pipefail' ]

htmlq := require('htmlq')
https := require('https')

# .../github.com/sirhc/advent-of-code/2024/05 -> https://adventofcode.com/2024/day/5/input
year  := file_name(parent_directory(invocation_directory()))
day   := trim_start_match(file_name(invocation_directory()), '0')

_default:
  # https://adventofcode.com/{{ year }}/day/{{ day }}

get-input:
  {{ https }} adventofcode.com/{{ year }}/day/{{ day }}/input "Cookie:session=$session"

make-readme:
  #!/usr/bin/env -S zsh
  print -n '# '
  {{ https }} adventofcode.com/{{ year }}/day/{{ day }} "Cookie:session=$session" | {{ htmlq }} -t 'h2' | sed -e 's/ *--- *//g' | head -1
  print
  print 'https://adventofcode.com/{{ year }}/day/{{ trim_start_match(day, '0') }}'
  print
  print '## Part One'
  print
  print '```'
  print '```'
  print
  print '## Part Two'
  print
  print '```'
  print '```'

easter-egg:
  {{ https }} adventofcode.com/{{ year }}/day/{{ day }} "Cookie:session=$session" | {{ htmlq }} 'span[title]'

store-session:
  sed -e '/^session=/d' -i .env
  printf 'session=%s\n' \
    "$( sqlite3 -batch -noheader -csv "file:${profile}/cookies.sqlite?immutable=1" "SELECT value FROM moz_cookies WHERE name = 'session' AND host = '.adventofcode.com'" )" \
    >> .env
