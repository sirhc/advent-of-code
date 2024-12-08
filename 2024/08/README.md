# Day 8: Resonant Collinearity

https://adventofcode.com/2024/day/8

## Part One

Since it's been a long, long time since I have done any actual algebra, let's use a slightly expanded version of the
first example to work the problem from first principles.

```
.......... (0, 0), ... (0, 9)
...#..#...   (1, 3), (1, 6)
..........
....ab....   (3, 4), (3, 5)
..........
....ba....   (5, 4), (5, 5)
..........
...#..#...   (7, 3), (7, 6)
..........
.......... (9, 0), ... (9, 9)
```

In all cases, antinodes will be "above" and "below" the nodes, shifted to the "left" or "right". When working with
combinations of nodes, we will encounter them in an arbitrary order. The following a and b combinations are equivalent.

```
a1 = (3, 4), (5, 5)
a2 = (5, 5), (3, 4)
```

Calculating the row and column distances between the nodes, we get the following. For rows, we are always going to use
the absolute value to move "up" or "down". However, for columns, we interpret the sign as the "slope" of the line
between the nodes.

```
d1 = (3 - 5, 4 - 5) = (-2, -1)
d2 = (5 - 3, 5 - 4) = ( 2,  1)
```

Let's work out the antinodes for each set and see if we get the same result.

```
n1 = (3 - 2, 4 - 1), (5 + 2, 5 + 1) = (1, 3), (7, 6)
n2 = (5 + 2, 5 + 1), (3 - 2, 4 - 1) = (7, 6), (1, 3)
```

Let's try the same for b.

```
b1 = (3, 5), (5, 4)
b2 = (5, 4), (3, 5)

d1 = (3 - 5, 5 - 4) = (-2,  1)
d2 = (5 - 3, 4 - 5) = ( 2, -1)

n1 = (3 - 2, 5 + 1), (5 + 2, 4 - 1) = (1, 6), (7, 3)
n2 = (5 + 2, 4 - 1), (3 - 2, 5 + 1) = (7, 3), (1, 6)
```

This leads to the general formula for antinodes.

```
n = (r1 + dr, c1 + dc), (r2 - dr, c2 - dc)
```

Oh hey, it worked.

```
❯ perl antinode.pl input | tail
##.............#..l#......#.#F...u#.#O............
..#.l............T.t.6.#.F..#.....#S..s........V..
.....#..........#....#.t4...........#...##......#.
.....#...z....#.#..........#....#....CV#..#s......
..z......#..I##......W....p.....#..##...u.....#...
......##...........#.l.......#...##....###......#.
.....#.#T.............#.........s.#...............
..........##......#..#...##.........##............

367
```

## Part Two

So this should be simple enough. We already calculated the row and column distance, so we just need to mark every
location from the first node to the end of the map.

```
❯ perl antinode2.pl input | tail
##.#.#.....###.#..##...##.######.##.##.##.###..###
..####.##........#.#####.####.##..##..###.#.####..
#..#.##.........##...#.###..#.#.#...#.#.##.#.#.##.
..#.##..##..#.#.####.......####.##...####.##..#...
.##.#....#..#####....#..#.#...###.####.##.....##..
#....###.#.......#.#.#..##..####.###.#.###.....##.
#...##.##....###......##..#...#.#.#.#..##.#.#.#..#
.#..##..####..##.##.##...###..#..#..###...#####.#.

1285
```
