# Day 25: Clock Signal

https://adventofcode.com/2016/day/25

## Part One

Oh fun, another assembunny problem! Looking at my input, at least I can drop support for the `tgl` instruction and my ugly optimization. Before I attempt to brute force this puzzle, I looked at
the input, since I've learned from [day 23](../23). Sure enough, there are a couple of oddly specific values in my input.

```
❯ head -3 input
cpy a d
cpy 15 c
cpy 170 b

❯ echo '15 * 170' | bc
2550
```

Since we're looking for an infinite series, it follows that the program must have a period. After dropping some print statements into the `out` instruction, the period became immediately
obvious. Starting with `a + 15 * 170`, repeatedly halve `a` until we reach zero. Each time the value is halved, output `0` or `1` depending on some property of the initial input, and start over.

```
❯ A=0 perl assembunny.pl < input | mlr --c2p --hi label a,b,c,d
a    b c d
1275 0 0 2550
637  1 0 2550
318  1 0 2550
159  0 0 2550
79   1 0 2550
39   1 0 2550
19   1 0 2550
9    1 0 2550
4    1 0 2550
2    0 0 2550
1    0 0 2550
0    1 0 2550

❯ A=1000 perl assembunny.pl < input | mlr --c2p --hi label a,b,c,d | head -2
a    b c d
1775 0 0 3550
```

The halving pattern was immediately curious. So I decided to look at the binary representation of `a` each time.

```
❯ A=0 perl assembunny.pl < input | mlr --c2p --hi label bin,a,b,c,d
bin         a    b c d
10011111011 1275 0 0 2550
1001111101  637  1 0 2550
100111110   318  1 0 2550
10011111    159  0 0 2550
1001111     79   1 0 2550
100111      39   1 0 2550
10011       19   1 0 2550
1001        9    1 0 2550
100         4    1 0 2550
10          2    0 0 2550
1           1    0 0 2550
0           0    1 0 2550
```

Huh. The `b` column (the output) is the same as the first binary representation of `a` (offset by one, for reasons). So, I suppose I just need to find the first value >= 2550 in which the binary
representation is an alternating sequence of `1`s and `0`s.

```
❯ i=0; while :; do print -n "$i "; perl -e 'printf "%b\n", shift' $(( 2550 + i++ )); done | awk '($2 ~ /11/ || $2 ~ /00/) { print $0; next } { print $0, "<-- here"; exit }' | tail
171 101010100001
172 101010100010
173 101010100011
174 101010100100
175 101010100101
176 101010100110
177 101010100111
178 101010101000
179 101010101001
180 101010101010 <-- here

❯ A=180 perl assembunny.pl < input | mlr --c2p --hi label bin,a,b,c,d
bin         a    b c d
10101010101 1365 0 0 2730
1010101010  682  1 0 2730
101010101   341  0 0 2730
10101010    170  1 0 2730
1010101     85   0 0 2730
101010      42   1 0 2730
10101       21   0 0 2730
1010        10   1 0 2730
101         5    0 0 2730
10          2    1 0 2730
1           1    0 0 2730
0           0    1 0 2730
```

Looks like we have a winner!

Amusingly, given such a low answer, I probably could have used brute force to find the solution faster than my analysis took me. I actually used 0–100 initially to find the period. I was so
close!

## Part Two

```
```
