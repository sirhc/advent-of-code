# Day 7: Bridge Repair

https://adventofcode.com/2024/day/7

## Part One

```
❯ perl operators.pl input | head
NO 456255051: 518 367 3 35 39 7 8
OK 1358: 592 80 529 74 83
OK 1464: 241 1 2 1 6
NO 46217848: 17 3 4 9 2 9 74 4 46 2 7 3
NO 19284295257: 8 5 4 8 94 3 5 8 6 8 41 8
NO 2864344343820: 2 864 344 34 3 820
NO 10332050008487: 7 4 738 100 50 84 85
OK 2385120: 9 7 7 4 53 593 98 6 88
NO 160267179632: 2 2 707 6 6 8 2 9 4 98
OK 248910: 2 4 62 9 6 613 3 779 3

❯ perl operators.pl input | awk '($1 == "OK") { gsub(":", ""); sum += $2 } END { print sum }'
5837374519342
perl operators.pl input  13.82s user 0.01s system 99% cpu 13.889 total 13k max rss
```

## Part Two

```
```
