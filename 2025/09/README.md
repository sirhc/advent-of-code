# Day 9: Movie Theater

https://adventofcode.com/2025/day/9

## Part One

A naïve approach would be to calculate the area of every combination of tiles and select the largest. There may be a way to be selective about the tiles chosen. For
example, start at the corners and select two tiles as close to the corner as possible. Continue working inward until the area starts to decrease consistently. It seems
more like a heuristic, but it could work. In any case, now that I've written code to do exactly that, it performs reasonably well. We'll see how I fare in part two.

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

Now I want to limit the search to only those areas that include red or green tiles. The example makes it feel like the best approach would be to determine the colors of
the tiles first, then check each rectangle against this grid. That feels computationally expensive. Given that the space is enclosed, I wonder if it would be enough to
check the corner tiles. For example, to confirm that the upper left tile is valid, a red tile must exist somewhere below and to the left of the lower left tile,
including the lower left tile itself. Similarly, for the lower right tile to be valid, a red tile must exist somewhere above and to the right of the upper right tile,
including the upper right tile itself.

My working theory holds up for the example at least. I really hope it holds for the input as well, because I don't know if I'm clever enough to come up with anything
else.

```
❯ perl area.pl 2 < example | sort -nr | head | column -t
24  9,5   2,3
21  11,1  9,7
18  2,5   7,3
15  7,1   9,5
15  11,1  9,5
15  11,1  7,3
9   9,5   7,3
9   9,5   11,7
8   9,5   2,5
7   11,1  11,7

❯ perl area.pl 2 < input | sort -nr | head | column -t
4670137716  16545,84914  83438,15101
4624402842  15981,83748  84254,16016
4614146888  17347,84914  83438,15101
4608929706  16545,84914  83438,16016
4597738950  14745,83245  84254,17101
4594598968  16545,84914  82356,15101
4592139312  16545,83748  83438,15101
4590061020  15981,83245  84254,16016
4590005364  17347,85852  81648,14471
4586201430  16545,83748  84254,16016
perl area.pl 2 < input  12.25s user 0.07s system 99% cpu 12.329 total 32112k max rss
```

No such luck.
