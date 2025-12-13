# Day 1: Inverse Captcha

https://adventofcode.com/2017/day/1

## Part One

All right, starting out easy. I'm circling back to years I missed after wrapping up 2025 and 2016, so it's refreshing.

```
❯ perl captcha.pl < example
3
4
0
9

❯ perl captcha.pl < input
1175
```

## Part Two

Fortunately, the modulus doesn't change, just the offset we use. I assume this was done to catch people who used a condition to check if they were at the end instead of using modulus arithmetic.

```
❯ PART=2 perl captcha.pl < example2
6
0
4
12
4
```
