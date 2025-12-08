# Day 22: Grid Computing

https://adventofcode.com/2016/day/22

## Part One

Assuming my code is correct, it appears that there is only one node with enough disk space available to hold any of the data from other nodes. If the grid had been much
larger, noting this would have been a useful optimization to avoid so many loops over the entire grid.

```
❯ perl grid.pl < input | head
node-x0-y0 (92) -> node-x11-y22 (92)
node-x1-y0 (86) -> node-x11-y22 (92)
node-x2-y0 (92) -> node-x11-y22 (92)
node-x3-y0 (94) -> node-x11-y22 (92)
node-x4-y0 (92) -> node-x11-y22 (92)
node-x5-y0 (85) -> node-x11-y22 (92)
node-x6-y0 (88) -> node-x11-y22 (92)
node-x7-y0 (88) -> node-x11-y22 (92)
node-x8-y0 (91) -> node-x11-y22 (92)
node-x9-y0 (90) -> node-x11-y22 (92)

❯ perl grid.pl < input | wc -l
     937
```

## Part Two

```
```
