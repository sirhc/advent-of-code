# Day 24: Air Duct Spelunking

https://adventofcode.com/2016/day/24

## Part One

Oh boy, the [traveling salesman problem](https://en.wikipedia.org/wiki/Travelling_salesman_problem), but with a twist. We're in a maze and, according to the example,
we're allowed to revisit locations. That last bit makes me wonder if I'll be able to benefit from trimming paths.

My breadth-first search works well enough for the example. Unsurprisingly, not coming up with a way to prune paths caused my breadth-first search to run my laptop out of memory. Then I realized
that there is a way to keep track of visited locations. A location can be considered visited if we've been there before _and_ we've visited the same set of HVAC points. Doing that dropped my run
time to under 3 seconds.

That was a little too easy. Now I'm concerned about part two.

```
❯ perl hvac.pl < example
14

❯ perl hvac.pl < input
490
```

## Part Two

Oh, that wasn't as bad as I thought. All I had to do was add a second goal condition. This time it took a bit under 5 seconds to find the solution.

```
❯ PART=2 perl hvac.pl < input
744
```
