# Day 6: Guard Gallivant

https://adventofcode.com/2024/day/6

## Part One

```
❯ perl path.pl input | tail
..............................#.........#..X.............................#XXXXXXXXXXXXXXXXXX..........#...............X...........
........#....#.............................X..................................X..##......X.#..........................X...........
..................................#........X..........#...................#.#.X.....#....X........#...................X..........#
.....................................#...##XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX...#.......
......................#.......#.............#.......................#..#.....#XXXXXXXXXXXX..........#.................#...........
.....##...........#.......#................#.................................#...##......#......#...............#.......#.#.......
.....#...#...............#......................#........#..........#..##...#...#........#..........#.............................
#...........#.............#...............................#..............................#...#.#........#.........................

5101
```

## Part Two

A bit of an optimization. Use the output from part one as the input to part two. We only need to place obstacles in the
original path. This dramatically reduces the search space.

```
❯ perl path.pl input | sed -e '/^$/,$d' > input2

❯ for row in {0..129}; do for col in {0..129}; do print -n "$row $col "; perl loop.pl 43 72 $row $col input2; done; done > output.txt

❯ shuf output.txt | head
41 1 Attempt to place obstacle in pointless location
83 88 Loop detected
17 82 Loop detected
94 12 Attempt to place obstacle in pointless location
90 55 Guard has left the lab
74 5 Attempt to place obstacle in pointless location
86 114 Guard has left the lab
14 92 Attempt to place obstacle in pointless location
115 25 Attempt to place obstacle in pointless location
117 80 Attempt to place obstacle in pointless location

❯ cut -d ' ' -f 3- output.txt | sort | uniq -c | sort -n
      1 Attempt to place obstacle on guard
    110 Loop detected - probably, too many iterations
    828 Attempt to place obstacle on obstacle
   1841 Loop detected
   3149 Guard has left the lab
  10971 Attempt to place obstacle in pointless location

❯ grep -c 'Loop detected' output.txt
1951
```
