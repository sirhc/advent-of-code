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

Huh, that doesn't seem so bad. It feels like a simplified version of [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).
Maybe I can use my visualization code without changing it.

When I run it on my input, it looks really cool. I'll need to find something to make an animation from it.

```
❯ zsh remove.zsh example1 >> README.md
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.

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

Removed: 13

[...]

..........
..........
..x@@.....
..@@@@....
...@@@@...
...@@@@@..
...@.@.@@.
...@@.@@@.
...@@@@@x.
....@@@...

[...]

Removed: 2

..........
..........
..........
....@@....
...@@@@...
...@@@@@..
...@.@.@@.
...@@.@@@.
...@@@@@..
....@@@...

Removed: 0

❯ zsh remove.zsh example1 | awk '$1 == "Removed:" { print $2 }' | paste -sd+ - | bc
43

❯ zsh remove.zsh input | awk '$1 == "Removed:" { print $2 }' | paste -sd+ - | bc
8758
```
