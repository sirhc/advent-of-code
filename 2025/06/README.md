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

```
```
