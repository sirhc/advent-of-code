# Day 7: Recursive Circus

https://adventofcode.com/2017/day/7

## Part One

There's no need to write any code to solve this part. The root program is the only one with an arrow that does not appear on the right side of an arrow.

```
❯ grep -- '->' example | cut -d ' ' -f 1 | while read -r p; do grep -qP -- "->.*\b$p\b" example || print $p; done
tknk

❯ grep -- '->' input | cut -d ' ' -f 1 | while read -r p; do grep -qP -- "->.*\b$p\b" input || print $p; done
hlhomy
```

## Part Two

```
```
