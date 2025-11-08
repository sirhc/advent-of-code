# Day 6: Signals and Noise

https://adventofcode.com/2016/day/6

## Part One

This looks like I can reuse the code I wrote for the triangle solution in
[part two of day 3](https://adventofcode.com/2016/day/3#part2) and the letter frequency solution from
[day 4](https://adventofcode.com/2016/day/4).

```
❯ perl message.pl example1
easter

❯ perl message.pl input
qtbjqiuq
```

I thought I had gotten something wrong, since I've seen edge cases that appear in the input but not in the example. But
my code was sound and I submitted my solution anyway. Turns out it was correct. Which means part two should be
interesting.

## Part Two

Okay, so not so bad. I'm already computing what I need and throwing it away. I just need to keep it.

```
❯ perl message.pl example1
[
  ["e", "a"],
  ["a", "d"],
  ["s", "v"],
  ["t", "e"],
  ["e", "n"],
  ["r", "t"],
]
```

My first pass, while correct for the example, does not look right for the input.

```
❯ perl message.pl input
[
  ["q", "a"],
  ["t", "k"],
  ["b", "o"],
  ["j", "t"],
  ["q", "h"],
  ["i", "q"],
  ["u", "l"],
  ["q", "i"],
]
```

After part one, I did a quick validation of my frequency code and, seeing that it looks suspiciously correct, I went
ahead and submitted this. It, as before, turns out to be the correct answer.

```
# Frequencies for the first column:

{
  a => 22,
  b => 23,
  c => 23,
  d => 23,
  e => 23,
  f => 23,
  g => 23,
  h => 23,
  i => 23,
  j => 23,
  k => 23,
  l => 23,
  m => 23,
  n => 23,
  o => 23,
  p => 23,
  q => 24,
  r => 23,
  s => 23,
  t => 23,
  u => 23,
  v => 23,
  w => 23,
  x => 23,
  y => 23,
  z => 23,
}
```
