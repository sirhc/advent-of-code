# Day 2: Corruption Checksum

https://adventofcode.com/2017/day/2

## Part One

I could just process each line as I read it, but something tells me I may want this in a data structure for part two.

Huh, that's interesting, the input is tab-delimited.

```
❯ perl checksum.pl < example
18

❯ perl checksum.pl < input
32121
```

## Part Two

Some proper loops would have made this easy enough, but I always have to use functional-style programming...

```
❯ perl checksum2.pl < example2
9

❯ perl checksum2.pl < input
197
```
