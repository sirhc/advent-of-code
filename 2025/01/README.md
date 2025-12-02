# Day 1: Secret Entrance

https://adventofcode.com/2025/day/1

## Part One

I don't think I care about the specific number, so long as every time it's multiple of 100, we consider the dial on zero.

```
❯ zsh pass.zsh < example1
  50 L68 ->  -18
 -18 L30 ->  -48
 -48 R48 ->    0
   0 L5  ->   -5
  -5 R60 ->   55
  55 L55 ->    0
   0 L1  ->   -1
  -1 L99 -> -100
-100 R14 ->  -86
 -86 L82 -> -168

Password: 3
```

## Part Two

Part one was fairly straightforward in that I only needed to determine if the final position was a multiple of 100. However, now I need to determine how many times I
pass zero.

The magnitude of the turn will tell us how many times we pass zero. For every 100 clicks, we return to the starting position, which means we either passed zero or
started and ended at zero. So, a turn of 150 clicks will pass zero at least once. Additionally, depending on the starting position, we may pass zero again or potentially
end at zero.

My shortcut in part one isn't going to work here. To use it, I would need to determine how many multiples of 100 lie between the start and end positions, which would
necessitate a loop to account for crossing actual zero. And there would still be a special case for ending on a multiple of 100.

Ugh. Finally, I gave up on figuring out all the edge cases to deal with the math and wrote something that looped through each click of the turn, counting how many times
we hit zero. It ran longer, but still finished in a couple of seconds. I left my math code in, just in case I want to revisit it later.

```
❯ zsh pass.zsh 2 < input | tail
21 + L40  -> 81 (6636)
81 + L1   -> 80 (6636)
80 + R18  -> 98 (6636)
98 + R7   ->  5 (6637)
 5 + R2   ->  7 (6637)
 7 + R48  -> 55 (6637)
55 + R31  -> 86 (6637)
86 + R25  -> 11 (6638)

Password for Part Two: 6638
```
