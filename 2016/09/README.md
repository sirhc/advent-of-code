# Day 9: Explosives in Cyberspace

https://adventofcode.com/2016/day/9

## Part One

I decided to try writing a quick test this time.

```
❯ bats example1.bats
example1.bats
 ✓ ADVENT
 ✓ A(1x5)BC
 ✓ (3x3)XYZ
 ✓ A(2x2)BCD(2x2)EFG
 ✓ (6x1)(1x3)A
 ✓ X(8x2)(3x3)ABCY

6 tests, 0 failures

❯ perl uncompress1.pl input | tr -d '\n' | wc -c
107035
```

## Part Two

Oh, so all the manipulation I did with the position tracking is getting thrown out.

Okay, that was shortsighted. The string very quickly gets too big to manage in a reasonable time. I would probably
exhaust the memory on my computer if I attempted to wait for it.

Reading the solution thread on Reddit, from people much smarter than I am, I got the idea to simply calculate the
resulting length of the string without actually computing the string itself.

```
❯ bats example2.bats
example2.bats
 ✓ (3x3)XYZ
 ✓ X(8x2)(3x3)ABCY
 ✓ (27x12)(20x12)(13x14)(7x10)(1x12)A
 ✓ (25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN

4 tests, 0 failures

❯ perl uncompress2.pl input
11451628995
```

Yeah, an 11 billion character string would have been a problem for me.
