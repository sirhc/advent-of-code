# Day 17: Two Steps Forward

https://adventofcode.com/2016/day/17

## Part One

Great, an A* search, but we can't exclude visited states. At least the grid is only 4x4.

```
❯ perl vault.pl `cat input`
DUDRDLRRRD
```

Whew. It worked the first try, so I don't have a lot of debugging to do.

## Part Two

Well, like I said, at least the grid is small. After modifying my code to save all paths:

```
❯ perl vault.pl `cat input`
DUDRDLRRRD
502
```
