# Day 7: Recursive Circus

https://adventofcode.com/2017/day/7

## Part One

There's no need to write any code to solve this part. The root program is the only one with an arrow that does not appear on the right side of an arrow.

```
❯ grep -- '->' example | cut -d ' ' -f 1 | while read -r p; do grep -qP -- "->.*\b$p\b" example || print $p; done
tknk

❯ grep -- '->' input | cut -d ' ' -f 1 | while read -r p; do grep -qP -- "->.*\b$p\b" input || print $p; done
hlhomy
```

## Part Two

Looking at the depth of the input, I'm going to keep my program simple and do a bit of manual work to review the weights at each level.

```
❯ perl weight.pl tknk < example
ugml: 251
padx: 243
fwft: 243

❯ perl weight.pl ugml < example
gyxo: 61
ebii: 61
jptl: 61

❯ bc <<< 251-243
8

❯ perl weight.pl hlhomy < input | sort -nk2
ahayh   111630
dxxty   111630
hvtvcpz 111630
lqirhg  111630
razvskj 111630
teyrfjn 111630
oylgfzb 111638

❯ perl weight.pl oylgfzb < input | sort -nk2
bmqiwai 22313
gwznzk  22313
hbgyu   22313
rlnii   22313
rugzyaj 22321

❯ perl weight.pl rugzyaj < input | sort -nk2
hblcbb  1571
jngcap  1571
wrtyhxg 1571
apjxafk 1579

❯ perl weight.pl apjxafk < input | sort -nk2
oamrbi  33
rznyr   33

❯ bc <<< 1579-1571
8
```

> That's not the right answer. If you're stuck, make sure you're using the full input data; there are also some general tips on the about page, or you can ask for hints on the subreddit. Please
> wait one minute before trying again. (You guessed 8.) [Return to Day 7]

I didn't guess. I just can't read.

> Given that exactly one program is the wrong weight, what would its weight need to be to balance the entire tower?

```
❯ grep '^apjxafk' input
apjxafk (1513) -> rznyr, oamrbi

❯ bc <<< 1513-8
1505
```
