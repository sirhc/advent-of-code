# Day 21: Scrambled Letters and Hash

https://adventofcode.com/2016/day/21

## Part One

This is one of those times I'm really glad I'm using Perl. Though one of these days, once I know my answers, I may circle back through and try to solve the puzzles in
different languages, just for the challenge of it.

```
❯ perl scramble.pl abcde < example
start                                => abcde
swap position 4 with position 0      => ebcda
swap letter d with letter b          => edcba
reverse positions 0 through 4        => abcde
rotate left 1 step                   => bcdea
move position 1 to position 4        => bdeac
move position 3 to position 0        => abdec
rotate based on position of letter b => ecabd
rotate based on position of letter d => decab

❯ perl scramble.pl abcdefgh < input | tail
swap letter h with letter g          => ehgfadcb
reverse positions 0 through 4        => afghedcb
rotate right 4 steps                 => edcbafgh
move position 6 to position 4        => edcbgafh
rotate based on position of letter c => afhedcbg
swap position 2 with position 6      => afbedchg
swap position 7 with position 2      => afgedchb
rotate right 1 step                  => bafgedch
swap position 3 with position 1      => bgfaedch
swap position 4 with position 6      => bgfacdeh
```

## Part Two

```
```
