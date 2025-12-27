# Day 6: Memory Reallocation

https://adventofcode.com/2017/day/6

## Part One

This isn't a terribly difficult problem. There are probably some off-by-one errors to watch out for.

```
❯ perl loop.pl < example
0: 0 2 7 0
1: 2 4 1 2
2: 3 1 2 3
3: 0 2 3 4
4: 1 3 4 1
5: 2 4 1 2

❯ perl loop.pl < input | tail
14020: 8 9 6 6 5 4 3 1 1 0 15 14 13 11 10 12
14021: 9 10 7 7 6 5 4 2 2 1 0 15 14 12 11 13
14022: 10 11 8 8 7 6 5 3 3 2 1 0 15 13 12 14
14023: 11 12 9 9 8 7 6 4 4 3 2 1 0 14 13 15
14024: 12 13 10 10 9 8 7 5 5 4 3 2 1 15 14 0
14025: 13 14 11 11 10 9 8 6 6 5 4 3 2 0 15 1
14026: 14 15 12 12 11 10 9 7 7 6 5 4 3 1 0 2
14027: 15 0 13 13 12 11 10 8 8 7 6 5 4 2 1 3
14028: 0 1 14 14 13 12 11 9 9 8 7 6 5 3 2 4
14029: 1 1 0 15 14 13 12 10 10 9 8 7 6 4 3 5
```

## Part Two

It seems my penchant for printing information as I go solved this problem for me.

```
❯ perl loop.pl < input | grep '1 1 0 15 14 13 12 10 10 9 8 7 6 4 3 5'
11264: 1 1 0 15 14 13 12 10 10 9 8 7 6 4 3 5
14029: 1 1 0 15 14 13 12 10 10 9 8 7 6 4 3 5

❯ bc <<< 14029-11264
2765
```
