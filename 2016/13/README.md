# Day 13: A Maze of Twisty Little Cubicles

https://adventofcode.com/2016/day/13

## Part One

I spent a bunch of time reading up on the [A* search algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm). With
the help of the pseudocode in the Wikipedia article, I was able to put together a passable implementation.

```
❯ perl grid.pl input
96
```

## Part Two

For part two, I just needed to remove the goal condition from the A* implementation so I could visit every square. Since
the algorithm keeps track of the distance to each square, I just printed it and used some shell commands to determine
the number of unique squares with a distance of 50 or less.

```
❯ perl grid.pl input | awk '( $1 < 51 ) { print $2 }' | sort -u | wc -l
141
```
