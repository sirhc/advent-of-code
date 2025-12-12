# Day 23: Safe Cracking

https://adventofcode.com/2016/day/23

## Part One

Self-modifying code!

I'm pleased that I have an opportunity to improve the program I wrote for [day 12](https://adventofcode.com/2016/day/12).

```
❯ perl assembunny.pl < example
Before:
(
  [
    ["cpy", 2, "a"],
    ["tgl", "a"],
    ["tgl", "a"],
    ["tgl", "a"],
    ["cpy", 1, "a"],
    ["dec", "a"],
    ["dec", "a"],
  ],
  { a => 7, b => 0, c => 0, d => 0 },
)

After:
(
  [
    ["cpy", 2, "a"],
    ["tgl", "a"],
    ["tgl", "a"],
    ["inc", "a"],
    ["jnz", 1, "a"],
    ["dec", "a"],
    ["dec", "a"],
  ],
  { a => 3, b => 0, c => 0, d => 0 },
)

❯ perl assembunny.pl < input | tail
    ["cpy", 77, "c"],
    ["cpy", 87, "d"],
    ["inc", "a"],
    ["dec", "d"],
    ["jnz", "d", -2],
    ["dec", "c"],
    ["jnz", "c", -5],
  ],
  { a => 11739, b => 1, c => 0, d => 0 },
)
```

## Part Two

> Don't bunnies usually multiply?

At first I wasn't sure how to interpret this. Initially I thought it was some clever way of suggesting that `inc` should add to itself based on its current count (i.e.,
10 bunnies beget 5 offspring resulting in 15 bunnies). A quick test told me I was wrong.

As I've learned recently, inspecting the puzzle input can often lead to insights.

```
inc a
dec c
jnz c -2
dec d
jnz d -5
```

That looks suspiciously like a nested for loop. Since the pattern appears twice in my input, I hard-coded an optimization that treats it as multiplication (`a + c * d`)
and jumps ahead.

```
❯ perl assembunny.pl 12 < input | tail
    ["cpy", 77, "c"],
    ["cpy", 87, "d"],
    ["inc", "a"],
    ["dec", "d"],
    ["jnz", "d", -2],
    ["dec", "c"],
    ["jnz", "c", -5],
  ],
  { a => 479008299, b => 1, c => 0, d => 0 },
)
```

After reading the [solutions thread](https://www.reddit.com/r/adventofcode/comments/5jvbzt/comment/dbjbldd/), it looks like someone figured out the algorithm that our
assumbunny code implemented. Clever.

```
❯ echo "factorial(7) + $( grep -E '^(cpy|jnz) \d\d' input | cut -d' ' -f2 | paste -sd\* - )"
factorial(7) + 77*87

❯ echo "factorial(7) + $( grep -E '^(cpy|jnz) \d\d' input | cut -d' ' -f2 | paste -sd\* - )" | bc
11739

❯ echo "factorial(12) + $( grep -E '^(cpy|jnz) \d\d' input | cut -d' ' -f2 | paste -sd\* - )" | bc
479008299
```
