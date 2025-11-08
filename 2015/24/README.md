# Day 24: It Hangs in the Balance

https://adventofcode.com/2015/day/24

## Part One

The first thing I noticed about my puzzle input is that all of the numbers are prime (well, except for 1, but that's a special case).

If we work our way up from a group of one package, we will eventually find a combination of packages that meets the weight goal. Since Santa wants legroom, we don't need
to continue calculating values.

```
❯ perl check.pl input | sort -n | head
11266889531 (1, 83, 103, 107, 109, 113)
11377594727 (1, 89, 97, 107, 109, 113)
11403903839 (1, 89, 101, 103, 109, 113)
33144344931 (3, 83, 101, 107, 109, 113)
33583973691 (3, 89, 101, 103, 107, 113)
53619534515 (5, 79, 103, 107, 109, 113)
54761320415 (5, 89, 97, 103, 109, 113)
109003762571 (11, 73, 103, 107, 109, 113)
111091346267 (11, 79, 97, 107, 109, 113)
111348229619 (11, 79, 101, 103, 109, 113)
```

## Part Two

Well that's easy. Just recalculate the target weight and run the same code.
