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

```
```
