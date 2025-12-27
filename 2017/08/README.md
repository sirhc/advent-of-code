# Day 8: I Heard You Like Registers

https://adventofcode.com/2017/day/8

## Part One

This is straightforward to implement, and Perl's autovivification means I don't have to determine ahead of time which registers exist.

```
❯ perl registers.pl < example
c     -10
a       1

❯ perl registers.pl < input | tail
u     830
db   1219
aw   1257
xdp  1903
w    3021
icd  3150
zmq  3156
esh  3549
y    4808
jt   5075
```

## Part Two

This is a simple adjustment to my code to keep track of the highest value seen so far. Fortunately, I wrote my code such that the value of the updated register was being returned as a side-effect
and I was just ignoring it before.

```
❯ perl registers.pl < example
10
c     -10
a       1

❯ perl registers.pl < input | head
7310
aj  -6415
cc  -3611
qvk -3590
uol -3112
zz  -2459
z   -2311
tft -2294
zsx -2116
ykm -1590
```
