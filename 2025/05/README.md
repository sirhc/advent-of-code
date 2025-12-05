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

Oh fun, now we get to also implement subtraction from first principles. However, that's not the hard part. We need to deal with overlapping ranges. For example, the
ranges [16, 20] and [12, 18] overlap. A naïve approach would count the numbers 16, 17, and 18 twice, resulting in 12 values. The appropriate range is [12, 20], which is
only 9 values.

I did perform a quick check to ensure all the ranges were valid (i.e., the left is less than or equal to the right), because you never know when a wrench is going to be
thrown at your assumptions.

To keep things simple, I tackled this problem in two stages. First, I wrote a program to merge the ranges, which prints the new ranges. Second, I wrote a program to
consume this list and do the math. I was too lazy by this point to write a subtraction algorithm, so I just went with Math::BigInt. After some struggles with getting my
range merge algorithm correct (I had the low-end logic correct, but neglected the high-end), I finally got the right answer.

```
❯ perl merge-bigint.pl < example
3-5
10-20

❯ perl merge-bigint.pl < example | perl count-bigint.pl
3-5 -> 3
10-20 -> 11

Total -> 14

❯ perl merge-bigint.pl < input | perl count-bigint.pl | tail
515752861706117-517240983163832 -> 1488121457716
518403209093753-520309798449606 -> 1906589355854
521809155835321-522375822931678 -> 566667096358
523251556997713-528465263347348 -> 5213706349636
528465263347349-528465263347349 -> 1
534734110721133-538440891280125 -> 3706780558993
544025462998588-550837866031455 -> 6812403032868
553747923986102-560123885472494 -> 6375961486393

Total -> 344423158480189
```
