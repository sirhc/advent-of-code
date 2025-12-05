# Day 5: Cafeteria

https://adventofcode.com/2025/day/5

## Part One

Looking at the input, obviously I can't just do numerical comparisons. However, since I typically use Perl to solve these problems, I can reach for the
[Math::BigInt](https://metacpan.org/pod/Math::BigInt) module.

```
❯ perl cafeteria-bigint.pl < example
1: spoiled
5: fresh [3–5]
8: spoiled
11: fresh [10–14]
17: fresh [16–20] [12–18]
32: spoiled

❯ perl cafeteria-bigint.pl < example | awk '$2 == "fresh"' | wc -l
       3

❯ perl cafeteria-bigint.pl < input | head
494255644786078: spoiled
449057832931172: fresh [446821240016892–449557896962705] [446821240016892–449557896962705]
462093948220262: spoiled
371538443741204: spoiled
403689388994355: spoiled
241853376184252: spoiled
312103000091678: spoiled
522500570382050: spoiled
338814040509917: fresh [332425552532979–339796783027409]
559503327234468: fresh [553747923986102–560123885472494]

❯ perl cafeteria-bigint.pl < input | awk '$2 == "fresh"' | wc -l
     505
```

While I would 100% use the Math::BigInt module in the course of a job, that hardly seems sporting for solving a puzzle for fun. So I made another attempt at solving part
one without using the module.

```
❯ perl cafeteria.pl < input | awk '$2 == "fresh"' | wc -l
     505
```

Which one I'll use for part two depends heavily on what twist it includes.

## Part Two

```
```
