# Day 9: Stream Processing

https://adventofcode.com/2017/day/9

## Part One

This is a relatively simple stream parser. For part one at least I only need to keep track of the current depth and add that to the total score when a group is closed. I don't think the commas
matter for this approach, so I can ignore them.

```
❯ perl stream.pl < example
1
6
5
16
1
9
9
3

❯ perl stream.pl < input
12396
```

## Part Two

```
```
