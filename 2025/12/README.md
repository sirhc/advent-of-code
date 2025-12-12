# Day 12: Christmas Tree Farm

https://adventofcode.com/2025/day/12

## Part One

Last night when I read the puzzle before bed, my first thought was, "How am I going to write code that can check every permutation of shape placements and have it finish
before the heat death of the universe?" Then, as I've recently learned the hard way to do, I took a look at my puzzle input. My next thought was, "Wow, that looks like a
lot of presents for the given region's area."

Today, as I sat down to work on the puzzle, I learned about [square packing](https://en.wikipedia.org/wiki/Square_packing). The part that jumped out at me was,

> Packing squares into other shapes can have high computational complexity: testing whether a given number of axis-parallel unit squares can fit into a given polygon is
> NP-complete.

That brought me back to my heat-death thought. Since Reddit pushes [r/adventofcode](https://www.reddit.com/r/adventofcode/) memes at me, I returned to my region area
thought and did a quick calculation to see if each region had enough room for the requisite number of presents.  If the region's area is smaller than the total area of
each present, no amount of rotation or flipping is going to make them fit.

```
❯ perl presents.pl < input | head
42x48: area: 2016 (41*7 + 40*7 + 43*6 + 35*7 + 37*7 + 27*5 = 1464) => good
48x50: area: 2400 (67*7 + 56*7 + 56*6 + 55*7 + 63*7 + 76*5 = 2403) => bad
43x43: area: 1849 (36*7 + 33*7 + 24*6 + 37*7 + 34*7 + 31*5 = 1279) => good
39x41: area: 1599 (31*7 + 29*7 + 29*6 + 35*7 + 24*7 + 21*5 = 1112) => good
40x47: area: 1880 (45*7 + 48*7 + 49*6 + 42*7 + 56*7 + 50*5 = 1881) => bad
40x49: area: 1960 (50*7 + 56*7 + 50*6 + 43*7 + 50*7 + 54*5 = 1963) => bad
44x44: area: 1936 (28*7 + 32*7 + 29*6 + 33*7 + 42*7 + 31*5 = 1274) => good
39x37: area: 1443 (18*7 + 25*7 + 22*6 + 37*7 + 27*7 + 26*5 = 1011) => good
36x35: area: 1260 (18*7 + 19*7 + 21*6 + 36*7 + 20*7 + 18*5 = 867) => good
42x37: area: 1554 (32*7 + 31*7 + 26*6 + 23*7 + 27*7 + 28*5 = 1087) => good
```

Getting back to the NP-complete bit, I figured, why not just stop here?

```
❯ perl presents.pl < input | awk '$NF == "good"' | wc -l
     512
```

Huzzah!

Honestly, my favorite part of Advent of Code is writing parsers for the input and working out the best way to represent the data.

## Part Two

```
```
