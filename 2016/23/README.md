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

```
```
