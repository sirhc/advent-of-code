# Day 10: Hoof It

https://adventofcode.com/2024/day/10

## Part One

```
❯ for f in example* input; do printf '%-9s %d\n' $f $( perl trailhead.pl $f ); done
example1  2
example2  4
example3  3
example4  36
input     638
```

## Part Two

Oh that's funny. I had actually written my program the first time to perform every combination of paths from 0 to 9
before optimizing it to cut off whenever I reached a visited path.

```
❯ for f in example* input; do printf '%-9s %d\n' $f $( perl trailhead2.pl $f ); done
example1  2
example2  13
example3  3
example4  81
input     1289
```
