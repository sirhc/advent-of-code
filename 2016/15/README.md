# Day 15: Timing is Everything

https://adventofcode.com/2016/day/15

## Part One

All right, this isn't terribly difficult. We just need to increment the starting time until we can determine when every disc will be at position 0 as the capsule reaches
it. The math is fairly straightforward.

```
❯ perl timing.pl < example | tail -3
time=5
time=6 disc1=0
time=7 disc2=0

❯ perl timing.pl < input | tail -7
time=400589
time=400590 disc1=0
time=400591 disc2=0
time=400592 disc3=0
time=400593 disc4=0
time=400594 disc5=0
time=400595 disc6=0
```

## Part Two

Oh, complexity my old friend...

There's probably a formula for this, but here we are. Though I do like when I don't have to update my code to solve part two.

```
❯ perl timing.pl < input2 | tail -8
time=3045959
time=3045960 disc1=0
time=3045961 disc2=0
time=3045962 disc3=0
time=3045963 disc4=0
time=3045964 disc5=0
time=3045965 disc6=0
time=3045966 disc7=0
perl timing.pl < input2  6.61s user 0.16s system 75% cpu 9.015 total 3824k max rss
```
