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

Upon first reading the puzzle, it feels like a tweak to the breadth-first search to manipulate joltages instead of lights. However, given the number of button presses in
the example and the lamentations on Reddit, I'm guessing it won't be that simple, even if it works fine for the example.

```
❯ perl joltages.pl < example | grep :
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7} : 10
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2} : 12
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5} : 11

❯ perl joltages.pl < example | grep : | awk '{ print $NF }' | paste -sd+ - | bc
33
```

Sure enough, on my very first input record, my code hangs (or at least took longer than 10 seconds before I killed it). The second input record solves immediately. I had
to go out, so I went ahead and let it run. Based on some of the comments I saw on Reddit and the look of the search space, I got what I expected.

```
❯ perl joltages.pl < input | tee out
zsh: killed     perl joltages.pl < input |
zsh: done       tee out
perl joltages.pl < input  648.83s user 203.79s system 55% cpu 25:42.15 total 13884048k max rss
tee out  0.00s user 0.00s system 0% cpu 25:42.15 total 1136k max rss
```

I had already started to think this was going to be a mathematical exercise before my failed attempt. It turns out that the joltages can be represented by multiplying a
vector (the number button presses) by a matrix (the buttons).

```
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7} : 10

[3 5 4 7] = [a b c d e f] * ⌈0 0 0 1⌉
                            |0 1 0 1|
                            |0 0 1 0|
                            |0 0 1 1|
                            |1 0 1 0|
                            ⌊1 1 0 0⌋

3 = a * 0 + b * 0 + c * 0 + d * 0 + e * 1 + f * 1
5 = a * 0 + b * 1 + c * 0 + d * 0 + e * 0 + f * 1
4 = a * 0 + b * 0 + c * 1 + d * 1 + e * 1 + f * 0
7 = a * 1 + b * 1 + c * 0 + d * 1 + e * 0 + f * 0
```

The task now becomes minimizing the value of `a + b + c + d + e +f`. Fortunately, there are tools to do this.

```
❯ cat | lp_solve
min: x0 + x1 + x2 + x3 + x4 + x5;
0 x0 + 0 x1 + 0 x2 + 0 x3 + 1 x4 + 1 x5 = 3;
0 x0 + 1 x1 + 0 x2 + 0 x3 + 0 x4 + 1 x5 = 5;
0 x0 + 0 x1 + 1 x2 + 1 x3 + 1 x4 + 0 x5 = 4;
1 x0 + 1 x1 + 0 x2 + 1 x3 + 0 x4 + 0 x5 = 7;
int x0;
int x1;
int x2;
int x3;
int x4;
int x5;
^D
Value of objective function: 10.00000000

Actual values of the variables:
x0                              1
x1                              5
x2                              0
x3                              1
x4                              3
x5                              0
```

So this becomes an exercise in converting my input into [lp files](https://lp-solve.github.io/lp-format.htm).

```
❯ perl joltages.pl < example
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7} : 10
  (3)                   → 1
  (1,3)                 → 5
  (2)                   → 0
  (2,3)                 → 1
  (0,2)                 → 3
  (0,1)                 → 0
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2} : 12
  (0,2,3,4)             → 2
  (2,3)                 → 5
  (0,4)                 → 0
  (0,1,2)               → 5
  (1,2,3,4)             → 0
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5} : 11
  (0,1,2,3,4)           → 5
  (0,3,4)               → 0
  (0,1,2,4,5)           → 5
  (1,2)                 → 1

❯ perl joltages.pl < example | grep : | awk '{ print $NF }' | paste -sd+ - | bc
33

❯ head -1 input | perl joltages.pl
[.##.#..##.] (3,6) (0,1,2,3,4,5,7,9) (0,1,5,6,7,8,9) (1,9) (0,1,3,4,5,6,7) (0,1,2,3,4,5) (1,2,3,4,5,6,7,8) (2,3,5,7,8) (2,3,5,7,9) (0,1,2,3,4,6,9) (4,5,6,7,8) (3,6,7,8,9) {52,67,66,109,49,65,70,66,33,72} : 127
  (3,6)                 → 18
  (0,1,2,3,4,5,7,9)     → 4
  (0,1,5,6,7,8,9)       → 6
  (1,9)                 → 12
  (0,1,3,4,5,6,7)       → 11
  (0,1,2,3,4,5)         → 13
  (1,2,3,4,5,6,7,8)     → 3
  (2,3,5,7,8)           → 10
  (2,3,5,7,9)           → 18
  (0,1,2,3,4,6,9)       → 18
  (4,5,6,7,8)           → 0
  (3,6,7,8,9)           → 14

❯ time perl joltages.pl < input | grep : | awk '{ print $NF }' | paste -sd+ - | bc
17848
perl joltages.pl < input  0.25s user 0.26s system 95% cpu 0.532 total 13232k max rss
```
