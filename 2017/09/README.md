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

Fortunately, the design of my parser made it easy to add a line to keep track of the number of garbage characters.

```
❯ perl stream.pl < example2
0, 0
0, 17
0, 3
0, 2
0, 0
0, 0
0, 10

❯ perl stream.pl < input
12396, 6346
```
