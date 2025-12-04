# Day 4: Printing Department

https://adventofcode.com/2025/day/4

## Part One

I have not been overly successful at guessing what twists part two might throw at me, so I didn't overthink part one too much. I just wrote some code to mark the
accessible rolls. Mostly because I enjoy visualizing my results in the same way the problem describes the examples.

```
❯ perl printing-department.pl < example1
..xx.xx@x.
x@@.@.@.@@
@@@@@.x.@@
@.@@@@..@.
x@.@@@@.@x
.@@@@@@@.@
.@.@.@.@@@
x.@@@.@@@@
.@@@@@@@@.
x.x.@@@.x.

❯ perl printing-department.pl < example1 | grep -o . | sort | uniq -c
  29 .
  58 @
  13 x

❯ perl printing-department.pl < input | grep -o . | sort | uniq -c
6445 .
10654 @
1397 x
```

## Part Two

```
```
