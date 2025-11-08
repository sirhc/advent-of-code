set dotenv-load
set shell := [ 'zsh', '-cu', '-o', 'pipefail' ]

https := 'https --check-status --ignore-stdin --timeout=30'

_default:

# .../github.com/sirhc/advent-of-code/2024/05 -> https://adventofcode.com/2024/day/5/input

[no-cd]
get-input year=file_name(parent_directory(invocation_directory())) day=file_name(invocation_directory()):
  {{ https }} adventofcode.com/{{ year }}/day/{{ trim_start_match(day, '0') }}/input "Cookie:session=$session"

[no-cd]
make-readme year=file_name(parent_directory(invocation_directory())) day=file_name(invocation_directory()):
  #!/usr/bin/env -S zsh
  printf '# '
  {{ https }} adventofcode.com/{{ year }}/day/{{ trim_start_match(day, '0') }} "Cookie:session=$session" | pup 'h2 text{}' | sed -e 's/ *--- *//g' | head -1
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
