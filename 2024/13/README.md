# Day 13: Claw Contraption

https://adventofcode.com/2024/day/13

## Part One

The constraint that each button would need to be pressed no more than 100 times means that we can readily brute force
the solution. I'm not great at guessing where part two is going, aside from making it computationally infeasible to use
a previous brute force solution. So maybe I'll just brute force the solution in part one so I can see where I need to go
with it.

Given the first example.

```
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400
```

We need to find all combinations of `A` and `B` such that `A * 94 + B * 22 = 8400` and `A * 34 + B * 67 = 5400`. Why
all combinations? Because we're not trying to minimize the button presses per se, but the cost of pressing those
buttons.

It turns out, after I wrote a quick brute force solution constrained to 100 button presses each, there's never more than
one combination of buttons that can reach the prize. But I went to the trouble of writing the code, so I'm keeping it.

However, in this next example, we have a prize that does not fall along any of the lines drawn by any combination of `A`
and `B`. It would be nice to be able to mathematically exclude these immediately. I may need to look up some math.

```
Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176
```

Anyway, the brute force solution was easy enough.

```
❯ perl play.pl input | tail -1
{ tokens => 28753 }
```

## Part Two

Yup, there it is. Fine, I'll do the math. Going back to the first example, we have two equations. We will arbitrarily
solve for `A` in the second equation and substitute the result into the first to obtain `B`.

```
A * 94 + B * 22 = 8400
A * 34 + B * 67 = 5400

A * 34 + B * 67 = 5400
         A * 34 = 5400 - B * 67
              A = ( 5400 - B * 67 ) / 34

                      A * 94 + B * 22 = 8400
 ( 5400 - B * 67 ) / 34 * 94 + B * 22 = 8400
 ( 5400 - B * 67 ) * 94 + B * 22 * 34 = 8400 * 34
5400 * 94 - B * 67 * 94 + B * 22 * 34 = 8400 * 34
          - B * 67 * 94 + B * 22 * 34 = 8400 * 34 - 5400 * 94
       B * ( -1 * 67 * 94 + 22 * 34 ) = 8400 * 34 - 5400 * 94
                                    B = ( 8400 * 34 - 5400 * 94 ) / ( -1 * 67 * 94 + 22 * 34 )

A = ( 5400 - B * 67 ) / 34
A = ( 5400 - ( ( 8400 * 34 - 5400 * 94 ) / ( -1 * 67 * 94 + 22 * 34 ) ) * 67 ) / 34

A = ( yP - ( ( xP * yA - yP * xA ) / ( -1 * yB * xA + xB * yA ) ) * yB ) / yA
B = ( xP * yA - yP * xA ) / ( -1 * yB * xA + xB * yA )
```
