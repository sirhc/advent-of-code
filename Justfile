set dotenv-load
set shell := ["zsh", "-c"]

all:

# .../github.com/sirhc/advent-of-code/2024/05 -> https://adventofcode.com/2024/day/5/input
[no-cd]
input year=replace_regex(replace_regex(invocation_directory(), "/[^/]*$", ""), ".*/", "") day=replace_regex(replace_regex(invocation_directory(), ".*/", ""), "^0", ""):
  @curl --cookie "session=$session" https://adventofcode.com/{{ year }}/day/{{ day }}/input
