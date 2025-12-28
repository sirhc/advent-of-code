# Day 10: Knot Hash

https://adventofcode.com/2017/day/10

## Part One

The hardest part of this puzzle is keeping track of the potential off-by-one errors when dealing with the end of the list.

```
❯ perl knot.pl 256 < input
253 * 246 = 62238
```

The changes in this part are too significant to modify my previous code to handle both parts.

## Part Two

```
❯ perl knot2.pl <<< ''
a2582a3a0e66e6e86e3812dcb672a272

❯ perl knot2.pl <<< 'AoC 2017'
33efeb34ea91902bb2f59c9920caa6cd

❯ perl knot2.pl <<< '1,2,3'
3efbe78a8d82f29979031a4aa0b16a9d

❯ perl knot2.pl <<< '1,2,4'
63960835bcdc130f0b66d7ff4f6a5a8e

❯ perl knot2.pl < input
2b0c9cc0449507a0db3babd57ad9e8d8
```
