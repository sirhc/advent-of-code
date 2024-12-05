set dotenv-load
set shell := ["zsh", "-uc"]

_default:
  @cd {{ invocation_directory() }} && just --choose

# .../github.com/sirhc/advent-of-code/2024/05 -> https://adventofcode.com/2024/day/5/input

# Print today's puzzle input
input:
  #!/usr/bin/env zsh
  cd {{ invocation_directory() }}
  read -r year day <<<"$( <<< "$PWD" awk -F / '{ print $(NF - 1), +$NF }' )"
  curl -fsSL --cookie "session=$session" https://adventofcode.com/$year/day/$day/input

# ❯ curl -fsSL https://adventofcode.com/2015/day/14 | pup 'h2 text{}' | sed -e 's/ *--- *//g'
# Day 14: Reindeer Olympics

# Generate README.md for today's puzzle
readme:
  #!/usr/bin/env zsh
  cd {{ invocation_directory() }}
  read -r year day <<<"$( <<< "$PWD" awk -F / '{ print $(NF - 1), +$NF }' )"
  echo -n '# '
  curl -fsSL --cookie "session=$session" https://adventofcode.com/$year/day/$day | pup 'h2 text{}' | sed -e 's/ *--- *//g'
  echo
  echo '## Part One'
  echo
  echo '```'
  echo '```'
  echo
  echo '## Part Two'
  echo
  echo '```'
  echo '```'

# Set up README.md and input for today's puzzle
[no-cd]
setup:
  [[ -e README.md ]] || just readme > README.md
  [[ -e input ]] || just input > input
