# Day 12: Garden Groups

https://adventofcode.com/2024/day/12

## Part One

The calculations here are straight forward, but it makes little sense to double the fencing between plots sharing a
boundary. I'm guessing that will be the optimization introduced in part two. So how can I set myself up for success if
that's the case?

If I'm right, the best approach is likely to keep track of the edges between the plots in addition to the plots
themselves. Fencing would only be needed at transitions between plots.

For now, I won't get too far ahead of myself.

```
❯ perl fence.pl input | tail
- A region of S plants with price 2 * 6 = 12.
- A region of M plants with price 1 * 4 = 4.
- A region of R plants with price 4 * 8 = 32.
- A region of M plants with price 2 * 6 = 12.
- A region of O plants with price 1 * 4 = 4.
- A region of E plants with price 7 * 12 = 84.
- A region of C plants with price 1 * 4 = 4.
- A region of G plants with price 1 * 4 = 4.

1402544
```

## Part Two

Boy was I wrong. My guess was way too easy a problem.

This would have been a lot easier had I kept track of the actual edges in part one. Probably simpler for me to calculate
the number of unique vertices. I'm already doing a neighbor check, so it's trivial to add in the diagonal.

The problem with this method is that some vertices may be counted twice. For example, in C below, the first C will count
the vertex on its lower right, and the second C will count the same vertex as its upper right. Since our coordinate
plane is made up of the plots, there's no convenient way of determining if these two vertices are the same.

We can compensate for this by assigning coordinates to the vertices. For a given plot, the upper left corner will be
given the same coordinates as the plot itself. In this way, the upper left corner of the plot below will have the same
coordinates as the lower left corner of the current plot. Now we can count the corners twice and simply count the unique
vertices. This is illustrated below.

```
+---------+
| A A A A |
+---------+

+-----+
| B B |
|     |
| B B |
+-----+

+---+        +-----+
| C |        | 0,0 |
|   +---+    |     +-----+
| C   C | => | 1,0   1,1 |
+---+   |    +-----+     |
    | C |          | 2,1 |
    +---+          +-----+

       +---+  0,0  0,1
0,0 => | C |
       |   +  1,0  1,1

       |   +  1,0  1,1
1,0 => | C
       +---+  2,0  2,1

       +---+  1,1  1,2
1,1 =>   C |
       +   |  2,1  2,2

       +   |  2,1  2,2
2,1 => | C |
       +---+  3,1  3,2
```

But there's a corner (heh) case. If a region meets up with itself diagonally, we need to count that vertex twice.

```
+-------------+
| A A A A A A |
|      +---+  |
| A A A|B B|A |
|      |   |  |
| A A A|B B|A |
|  +---+---+  | <-- need to count that middle one twice
| A|B B|A A A |
|  |   |      |
| A|B B|A A A |
|  +---+      |
| A A A A A A |
+-------------+
```

Finally, after poking at this on and off for a couple of days, I came up with a relatively simple addition to my vertex
counting code that let me count the diagonal twice.

```
❯ perl fence2.pl input | tail
- A region of S plants with price 2 * 4 = 8.
- A region of M plants with price 1 * 4 = 4.
- A region of R plants with price 4 * 4 = 16.
- A region of M plants with price 2 * 4 = 8.
- A region of O plants with price 1 * 4 = 4.
- A region of E plants with price 7 * 6 = 42.
- A region of C plants with price 1 * 4 = 4.
- A region of G plants with price 1 * 4 = 4.

862486
```
