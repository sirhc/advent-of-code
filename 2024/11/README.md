# Day 11: Plutonian Pebbles

https://adventofcode.com/2024/day/11

## Part One

This felt too straight-forward. However, if I were working in a lower-level language, I'm sure it would have been much
more of a pain to update the list of stones.

```
Initial arrangement:
3 386358 86195 85 1267 3752457 0 741

(1, 11)
(2, 15)
(3, 22)
(4, 30)
(5, 45)
(6, 78)
(7, 111)
(8, 156)
(9, 232)
(10, 360)
(11, 528)
(12, 811)
(13, 1267)
(14, 1833)
(15, 2820)
(16, 4292)
(17, 6521)
(18, 9952)
(19, 14716)
(20, 22720)
(21, 34798)
(22, 52146)
(23, 79803)
(24, 120306)
(25, 183248)
```

## Part Two

Yeah, that worked great for 25 stones and the ability to print out the list of stones at each step. I did get a hint
from Reddit about how to think about the problem. Obvious in retrospect.

Also, memoization is amazing.

```
❯ perl stones2.pl 25 input
183248

❯ perl stones2.pl 75 input
218811774248729
```
