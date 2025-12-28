# Day 11: Hex Ed

https://adventofcode.com/2017/day/11

## Part One

This seemed to be a matter of combining pairs of directions until there are no more pairs available. I'm actually a little surprised I got this right on my first try.

```
❯ perl hex.pl <<< 'ne,ne,ne'
3

❯ perl hex.pl <<< 'ne,ne,sw,sw'
0

❯ perl hex.pl <<< 'ne,ne,s,s'
2

❯ perl hex.pl <<< 'se,sw,se,sw,sw'
3

❯ perl hex.pl < input
705
```

## Part Two

```
```
