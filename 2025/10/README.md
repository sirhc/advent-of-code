# Day 10: Factory

https://adventofcode.com/2025/day/10

## Part One

> Because none of the machines are running, the joltage requirements are irrelevant and can be safely ignored.

At least, until part two. But that's a problem for after I've solved part one.

This immediately feels like an application of a breadth-first search. It's interesting that the example given uses different buttons, but maybe that's just because
it's obvious from looking at the pattern.

```
❯ perl lights.pl < example
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7} : 2
  (1,3)                 → [.#.#]
  (2,3)                 → [.##.]
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2} : 3
  (0,4)                 → [#...#]
  (0,1,2)               → [.##.#]
  (1,2,3,4)             → [...#.]
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5} : 2
  (0,3,4)               → [#..##.]
  (0,1,2,4,5)           → [.###.#]

❯ perl lights.pl < example | grep : | awk '{ print $NF }' | paste -sd+ - | bc
7
```

I initially didn't prune visited states, so several machines in my input took a few seconds with at least one potentially looping forever. Oops.

```
❯ perl lights.pl < input | head
[.##.#..##.] (3,6) (0,1,2,3,4,5,7,9) (0,1,5,6,7,8,9) (1,9) (0,1,3,4,5,6,7) (0,1,2,3,4,5) (1,2,3,4,5,6,7,8) (2,3,5,7,8) (2,3,5,7,9) (0,1,2,3,4,6,9) (4,5,6,7,8) (3,6,7,8,9) {52,67,66,109,49,65,70,66,33,72} : 4
  (3,6)                 → [...#..#...]
  (0,1,5,6,7,8,9)       → [##.#.#.###]
  (1,9)                 → [#..#.#.##.]
  (0,1,2,3,4,5)         → [.##.#..##.]
[..##.] (2,4) (0,4) (1,3,4) (0,2,3,4) (2,3) {16,2,22,13,29} : 1
  (2,3)                 → [..##.]
[..#.##..] (1,2,3,4,5,6) (0,2,7) (1,2,3) (0,4) (0,1,4,5,6,7) (0,4,5,7) (0,1,2,3,5,7) {35,30,34,20,20,18,10,32} : 2
  (0,2,7)               → [#.#....#]
  (0,4,5,7)             → [..#.##..]

❯ perl lights.pl < input | grep : | awk '{ print $NF }' | paste -sd+ - | bc
449
```

That was easy enough. However, having seen a few posts on Reddit this morning, I expect part two to be particularly challenging. I haven't looked at the solutions post
yet, only the people lamenting their choices.

## Part Two

```
```
