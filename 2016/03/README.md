# Day 3: Squares With Three Sides

https://adventofcode.com/2016/day/3

## Part One

In your puzzle input, how many of the listed triangles are possible?

I don't know that there's a clever way to do this. There are three sides to a triangle (e.g., a, b, and c), which gives
us the Triangle Inequality Theorem.

```
(a + b) > c
(a + c) > b
(b + c) > a
```

I'm not aware of any shortcuts to determine if a triangle is valid, so I'll just check each one. Obviously, I can
short-circuit if any of the inequalities fail.

## Part Two

Back in part one, I was overthinking what the challenge would be in part two. The math remains simple, with brute force
the only option. It's how we interpret the input that changes. Fortunately, this was also straightforward.
