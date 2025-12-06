# Day 20: Firewall Rules

https://adventofcode.com/2016/day/20

## Part One

As luck would have it, today is [2025 Day 5](https://adventofcode.com/2025/day/5) and I just wrote a script to merge ranges this morning.

```
❯ perl merge.pl < example
0-2
4-8

❯ perl merge.pl < input | head
0-574651
574652-1770165
1770166-12016953
12016954-23923782 <-- 23923783 is available!
23923784-56528831
56528833-64047545
64047546-86026817
86026819-113504562
113504564-148746047
148746049-149287452
```

## Part Two

Since I already have the ranges merged and sorted, I can just sum the gaps.

```
❯ perl merge.pl < example | perl count.pl 9
2

❯ perl merge.pl < input | perl count.pl
125
```
