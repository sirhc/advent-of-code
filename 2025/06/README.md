# Day 6: Trash Compactor

https://adventofcode.com/2025/day/6

## Part One

```
❯ perl math.pl < example
* 123 45 6
= 33210
+ 328 64 98
= 490
* 51 387 215
= 4243455
+ 64 23 314
= 401

❯ perl math.pl < example | awk '$1 == "=" { print $2 }' | paste -sd+ - | bc
4277556

❯ perl math.pl < input | head
* 95 41 1 4
= 15580
* 92 29 4 3
= 32016
* 45 61 22 68
= 4106520
+ 63 65 9416 8629
= 18173
+ 1 99 987 4961
= 6048

❯ perl math.pl < input | awk '$1 == "=" { print $2 }' | paste -sd+ - | bc
4878670269096
```

## Part Two

I knew when I read "the left/right alignment of numbers within each problem can be ignored" in part one that we would, in fact, need to consider it in part two.

```
❯ perl math2.pl < example
+ 4 431 623
= 1058
* 175 581 32
= 3253600
+ 8 248 369
= 625
* 356 24 1
= 8544

❯ perl math2.pl < example | awk '$1 == "=" { print $2 }' | paste -sd+ - | bc
3263827

❯ perl math2.pl < input | head
+ 64 879 5212
= 6155
* 3852 754 59
= 171360072
* 9765 244 7
= 16678620
* 63 8653
= 545139
+ 5253 88
= 5341

❯ perl math2.pl < input | awk '$1 == "=" { print $2 }' | paste -sd+ - | bc
8674740488592
```
