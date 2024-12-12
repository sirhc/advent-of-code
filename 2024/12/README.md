# Day 12: Garden Groups

https://adventofcode.com/2024/day/12

## Part One

The calculations here are straight forward, but it makes little sense to double the fencing between plots sharing a
boundary. I'm guessing that will be the optimization introduced in part two. So how can I set myself up for success if
that's the case?

If I'm right, the best approach is likely to keep track of the edges between the plots in addition to the plots
themselves. Fencing would only be needed at transitions between plots.

For now, I won't get too far ahead of myself.

```
❯ perl fence.pl input | tail
- A region of S plants with price 2 * 6 = 12.
- A region of M plants with price 1 * 4 = 4.
- A region of R plants with price 4 * 8 = 32.
- A region of M plants with price 2 * 6 = 12.
- A region of O plants with price 1 * 4 = 4.
- A region of E plants with price 7 * 12 = 84.
- A region of C plants with price 1 * 4 = 4.
- A region of G plants with price 1 * 4 = 4.

1402544
```

## Part Two

```
```
