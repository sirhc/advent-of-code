# Day 20: Infinite Elves and Infinite Houses

https://adventofcode.com/2015/day/20

This is really just finding all the factors of the given house. Individually, this isn't a big deal. However, when
trying to find the factors for _all_ of the houses for our input, it becomes computationally expensive.

However, there's probably some math we could do to determine which house we could start on, limiting our search space.

Fortunately, people much smarter than I am have already created libraries to factor numbers.

## Part One

```
❯ input=$( cat input ); for d in 10000 1000 100 10 1; do print "$input / $d -> House $(( input / d ))"; ; time perl presents.pl $(( input / d )); print; done
34000000 / 10000 -> House 3400
House 120 got 3600 presents.
perl presents.pl $(( input / d ))  0.01s user 0.01s system 94% cpu 0.019 total 7488k max rss

34000000 / 1000 -> House 34000
House 1080 got 36000 presents.
perl presents.pl $(( input / d ))  0.01s user 0.00s system 93% cpu 0.016 total 6848k max rss

34000000 / 100 -> House 340000
House 9240 got 345600 presents.
perl presents.pl $(( input / d ))  0.02s user 0.00s system 95% cpu 0.021 total 7008k max rss

34000000 / 10 -> House 3400000
House 83160 got 3456000 presents.
perl presents.pl $(( input / d ))  0.08s user 0.00s system 98% cpu 0.083 total 7280k max rss

34000000 / 1 -> House 34000000
House 786240 got 34137600 presents.
perl presents.pl $(( input / d ))  0.77s user 0.01s system 99% cpu 0.777 total 7328k max rss
```

## Part Two

```
```
