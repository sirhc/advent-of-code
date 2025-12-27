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

```
```
