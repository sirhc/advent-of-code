# Day 11: Radioisotope Thermoelectric Generators

https://adventofcode.com/2016/day/11

## Part One

This puzzle gave me a hard time, because I wasn't thinking about it correctly. I kept looking at it as a logic puzzle. How could I write code to determine the next move the way a human would
look at it?

After reading through the Reddit discussion, I realized I was looking at it all wrong. I could solve this by implementing a breadth-first search, typical of game design.

```
❯ perl rtg.pl < example1
F4  .   .   .   .   .  
F3  .   .   .   LiG .  
F2  .   HG  .   .   .  
F1  E   .   HM  .   LiM

Iteration: 346 Depth: 11
Minimum number of moves: 11

❯ perl rtg.pl < input
F4  .   .   .   .   .   .   .   .   .   .   .  
F3  .   PmG PmM .   .   RuG RuM .   .   .   .  
F2  .   .   .   .   PuM .   .   .   SrM .   .  
F1  E   .   .   PuG .   .   .   SrG .   TmG TmM

Iteration: 158156 Depth: 31
Minimum number of moves: 31
perl rtg.pl < input  27.63s user 0.12s system 99% cpu 27.902 total 154k max rss
```

## Part Two

I suppose I should have seen this coming. How do you mess with people who wrote a breadth-first search? Throw extra states at them. Of course, the additional isotopes
aren't real elements, so my fancy rendering function needed additional data.

As I prepared for running part two, I ran part one on a MacBook Pro M1, instead of my Linux Intel(R) Core(TM) i7-8565U CPU @ 1.80GHz:

```
perl rtg.pl < input  15.67s user 0.15s system 98% cpu 16.029 total 150272k max rss
```

It turned out that the amount of time part two was taking frustrated me. I looked over the Reddit discussion to see where I could optimize my code, looking for ways I
could more aggressively prune the search space. I didn't have much luck until I ran across this comment:

> Any complete pairs on floor 1 add 12 steps to the solution
> Complete pairs on floor 2 add 8 steps
> Complete pairs on floor 3 add 4 steps
>
> https://www.reddit.com/r/adventofcode/comments/5hoia9/comment/db1v3ar/

Based on my initial thoughts about the problem, knowing there are formulae that can be used to determine the number of moves for problems like the Towers of Hanoi or the
jealous husbands problem, I realized this made sense and gave it a shot.

```
❯ perl rtg.pl < input2
Initial state:

F4  .   .   .   .   .   .   .   .   .   .   .   .   .   .   .
F3  .   .   .   .   .   PmG PmM .   .   RuG RuM .   .   .   .
F2  .   .   .   .   .   .   .   .   PuM .   .   .   SrM .   .
F1  E   DiG DiM ElG ElM .   .   PuG .   .   .   SrG .   TmG TmM

Known moves: 44

F4  .   .   .   .   .   .   .   .   .   .   .   .   .   .   .
F3  .   .   .   .   .   .   .   .   .   .   .   .   .   .   .
F2  .   .   .   .   .   .   .   .   PuM .   .   .   SrM .   .
F1  E   .   .   .   .   .   .   PuG .   .   .   SrG .   .   .

Iteration:     355 : Depth:  11 : Queue:  44

Minimum number of moves: 55
```

Of course, I think I spent more time modifying and debugging the way I maintained state than it would have taken to just let my original breadth-first search run its
course.

¯\_(ツ)_/¯
