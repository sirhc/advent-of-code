# Day 7: Internet Protocol Version 7

https://adventofcode.com/2016/day/7

## Part One

This seems straightforward enough since I'm using Perl for these puzzles. If I were to challenge myself and do this in a
language I'm less familiar with, it would probably be much more difficult.

```
❯ perl tls.pl example1
abba[mnop]qrst
ioxxoj[asdfgh]zxcvbn

❯ perl tls.pl input | wc -l
115
```

## Part Two

In my first attempt, I misunderstood the puzzle and assumed we were further filtering IPs with TLS support that *also*
included SSL support.

```
❯ perl tls.pl input | perl ssl.pl | wc -l
13
```

The number did seem low, but I submitted it anyway. It was wrong. So I tried it on the full input, which was correct.

```
❯ perl ssl.pl input | wc -l
231
```
