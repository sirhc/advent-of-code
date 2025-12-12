# Day 22: Grid Computing

https://adventofcode.com/2016/day/22

## Part One

Assuming my code is correct, it appears that there is only one node with enough disk space available to hold any of the data from other nodes. If the grid had been much
larger, noting this would have been a useful optimization to avoid so many loops over the entire grid.

```
❯ perl pairs.pl < input | head
node-x0-y0 (92) -> node-x11-y22 (92)
node-x1-y0 (86) -> node-x11-y22 (92)
node-x2-y0 (92) -> node-x11-y22 (92)
node-x3-y0 (94) -> node-x11-y22 (92)
node-x4-y0 (92) -> node-x11-y22 (92)
node-x5-y0 (85) -> node-x11-y22 (92)
node-x6-y0 (88) -> node-x11-y22 (92)
node-x7-y0 (88) -> node-x11-y22 (92)
node-x8-y0 (91) -> node-x11-y22 (92)
node-x9-y0 (90) -> node-x11-y22 (92)

❯ perl pairs.pl < input | wc -l
     937
```

## Part Two

Now I see why only one node satisfied the requirements in part one. It leaves us with only a single point to start. Before getting busy on a search algorithm, I took
some time to analyze the data. My first observation is that all nodes have a size adequate to store the goal node's data. My second observation is that there is a "wall"
of nodes between my empty node and the goal node which are using too much space to fit on the empty node. In theory, every time we move data to the empty node, this set
of nodes would change. In practice, after experimenting with a handful of nodes, the location of the "wall" remains static.

```
❯ perl grid.pl < input
 A  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  G 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  # 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  _  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
```

At this point, I don't really need to write any code to determine the path. The example shows us that, if the empty node is to the goal's immediate right, it requires 5
steps to move the empty node to the goal's immediate left and move the goal's data. That leaves us with,

- The number of steps to move the empty node to the goal's immediate left.
- One step to move the goal data into the empty node.
- Five times 28 steps to move the goal data to the node we can access.

That just leaves us with determining how many steps are required to move the empty node to the goal's immediate left. I could write a search algorithm for this, or I
could look at the grid. Since we can't move data diagonally, the shortest path from one node to another is to traverse the border of the rectangle formed by the start
and end points.

This results in 7 steps to reach the wall, 4 steps to clear the left side of the wall, 15 steps to reach the top row, and 21 steps to reach the goal's immediate left
(though it feels silly to traverse the same path we're about to retrace).

Finally, we can just run the numbers:

```
❯ echo '7 + 4 + 15 + 21 + 1 + (5 * 28)' | bc
188
```
