# Day 17: No Such Thing as Too Much

https://adventofcode.com/2015/day/17

## Part One

```
❯ perl eggnog.pl input
654
```

## Part Two

```
❯ perl eggnog2.pl input | head
3 -> 50 + 49 + 44 + 7 = 150
3 -> 50 + 49 + 40 + 11 = 150
3 -> 50 + 49 + 40 + 11 = 150
4 -> 50 + 49 + 26 + 18 + 7 = 150
4 -> 50 + 49 + 26 + 18 + 7 = 150
4 -> 50 + 49 + 22 + 18 + 11 = 150
4 -> 50 + 49 + 22 + 18 + 11 = 150
3 -> 50 + 47 + 46 + 7 = 150
3 -> 50 + 47 + 43 + 10 = 150
3 -> 50 + 47 + 42 + 11 = 150

❯ perl eggnog2.pl input | awk '{ print $1 }' | sort -n | uniq -c | sort -nk2
     57 3
    231 4
    262 5
     97 6
      7 7
```
