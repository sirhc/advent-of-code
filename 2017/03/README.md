# Day 3: Spiral Memory

https://adventofcode.com/2017/day/3

## Part One

Today I learned about the [Ulam spiral](https://en.wikipedia.org/wiki/Ulam_spiral) and, after some searching, a [formula](https://math.stackexchange.com/a/4201810) for determining the value of a
given set of coordinates.

I asked Gemini to construct the code to find the coordinates for a given value. Once I had that function, it was as simple as calculating the Manhattan distance from the origin.

```
❯ perl ulam.pl < input

### get_ulam_coords($input): -151,
###                          -279

❯ bc <<< 151+279
430
```

## Part Two

This part was easier for me than part one. Conceptually, the spiral was easy to grok. Since this was just a matter of recursively determining the value of each square, it was just a matter of
picking out the valid neighbors and summing their values. There may have been a simpler way to do this, but it worked.

```
❯ perl value.pl < input | tail
(4, -1) => 103128
(4, 0) => 109476
(4, 1) => 116247
(4, 2) => 123363
(4, 3) => 128204
(4, 4) => 130654
(3, 4) => 266330
(2, 4) => 279138
(1, 4) => 295229
(0, 4) => 312453
```
