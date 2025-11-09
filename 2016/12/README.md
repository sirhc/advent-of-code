# Day 12: Leonardo&#39;s Monorail

https://adventofcode.com/2016/day/12

## Part One

I do enjoy simulating assembly code.

```
❯ perl assembunny.pl input
{ register => { a => 318009, b => 196418, c => 0, d => 0 } }
```

## Part Two

It takes just a bit longer now.

```
❯ time perl assembunny.pl input
{ register => { a => 318009, b => 196418, c => 0, d => 0 } }
perl assembunny.pl input  0.69s user 0.00s system 99% cpu 0.697 total 15k max rss

❯ time perl assembunny.pl input
{ register => { a => 9227663, b => 5702887, c => 0, d => 0 } }
perl assembunny.pl input  21.83s user 0.00s system 99% cpu 21.939 total 15k max rss
```
