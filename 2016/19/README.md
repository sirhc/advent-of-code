# Day 19: An Elephant Named Joseph

https://adventofcode.com/2016/day/19

## Part One

I knew simulating this would be futile, so I started working this out step by step on paper and eventually noticed a pattern. Once I had the pattern, I asked Gemini to identify it. Gemini noted
the pattern is the Josephus Problem with `k=2`. Gemini further explained that in *Concrete Mathematics* (Graham, Knuth, and Patashnik), the solution can be found by manipulating the binary
representation of the number to move the first bit to the end. Converting it back to decimal gives the solution.

So, for 13 elves: `13 -> 0b1101 -> 0b1011 -> 11`. Writing a quick script to validate this gives me the following.

I see the clue in the puzzle title now, though I'm not sure what search terms would have lead me to the answer.

```
❯ perl josephus.pl
    1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
 1  1 
 2  1  1 
 3  1  1  3 
 4  1  1  3  1 
 5  1  1  3  1  3 
 6  1  1  3  1  3  5 
 7  1  1  3  1  3  5  7 
 8  1  1  3  1  3  5  7  1 
 9  1  1  3  1  3  5  7  1  3 
10  1  1  3  1  3  5  7  1  3  5 
11  1  1  3  1  3  5  7  1  3  5  7 
12  1  1  3  1  3  5  7  1  3  5  7  9 
13  1  1  3  1  3  5  7  1  3  5  7  9 11 
14  1  1  3  1  3  5  7  1  3  5  7  9 11 13 
15  1  1  3  1  3  5  7  1  3  5  7  9 11 13 15 
16  1  1  3  1  3  5  7  1  3  5  7  9 11 13 15  1 
17  1  1  3  1  3  5  7  1  3  5  7  9 11 13 15  1  3 
18  1  1  3  1  3  5  7  1  3  5  7  9 11 13 15  1  3  5 
19  1  1  3  1  3  5  7  1  3  5  7  9 11 13 15  1  3  5  7 
20  1  1  3  1  3  5  7  1  3  5  7  9 11 13 15  1  3  5  7  9
```

Okay, now that I've poked at this for an hour, I can code my solution.

```
❯ perl -nlE 'say 2 * ($_ - (1 << (int(log($_)/log(2))))) + 1' < input
1834471
```

## Part Two

Okay, I cheated. I knew there had to be another pattern to this one, but was way too lazy to figure it out. I looked over the Reddit discussion and found the following formula. But now I want to
know *why* it works. I ended up asking Gemini to explain the Josephus Problem when eliminating people "across" the circle. I understand the algorithm now and that there isn't a formula, due to
`k` changing each round. It'd be interesting to write some code to visualize the process, but I'm satisfied that I've learned something, tired, and ready to move on.

```
❯ perl -nlE '$i = 1; $i *= 3 while $i * 3 < $_; say $_ - $i' < input
1420064
```
