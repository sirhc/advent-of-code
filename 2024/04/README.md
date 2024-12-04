# Day 4: Ceres Search

https://adventofcode.com/2024/day/4

## Part One

This took me too long, because I missed the bit where the words could overlap and calculated rows and columns
incorrectly.

```
❯ perl search.pl input
rows = 140
cols = 140
count after rows: 443
count after cols: 880
count after down right: 1715
count after down left: 2521
```

## Part Two

This was quicker, because I had already done the work to figure out diagonals in Part One.

```
❯ perl search2.pl input
rows = 140
cols = 140
count: 1912
```
