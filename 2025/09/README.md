# Day 9: Movie Theater

https://adventofcode.com/2025/day/9

## Part One

A naïve approach would be to calculate the area of every combination of tiles and select the largest. There may be a way to be selective about the tiles chosen. For example, start at the corners
and select two tiles as close to the corner as possible. Continue working inward until the area starts to decrease consistently. It seems more like a heuristic, but it could work. In any case,
now that I've written code to do exactly that, it performs reasonably well. We'll see how I fare in part two.

```
❯ perl area.pl < example | sort -nr | head | column -t
50  11,7  2,3
50  11,1  2,5
40  9,7   2,3
35  11,7  7,1
30  7,1   2,5
30  11,7  2,5
30  11,1  2,3
25  11,7  7,3
24  9,7   2,5
24  2,3   9,5

❯ perl area.pl < input | sort -nr | head | column -t
4758598740  83899,85263  16133,15044
4753034373  83899,85263  13517,17733
4749217110  83254,85798  16133,15044
4746786708  83254,85798  13517,17733
4739812692  83899,85263  12984,18427
4738495824  86595,82291  16133,15044
4738049904  83899,85263  17036,14403
4737796932  83899,85263  15634,15862
4734757536  82084,86784  13517,17733
4734297812  83254,85798  12984,18427
```

## Part Two

```
```
