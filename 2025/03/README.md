# Day 3: Lobby

https://adventofcode.com/2025/day/3

## Part One

When first looking at this problem, my first thought is that it seems obvious that we should choose the largest number possible. Intuitively, this would create a larger
value than any of the other available numbers. For example, in `818181911112111`, we should select `9` as the first number. Any of the `8` values would be wrong, because
`90 > 80`. For the second number, we should select the largest number to the right of the first. Again, this makes intuitive sense, because any number to the left is
necessarily smaller than the first number we've chosen, which would result in a smaller overall value. So we select `2` as the second number, resulting in `92`.

Now, what if the largest number is the final number in the sequence? For example, in `234234234234278`, we would select `8` as the first number. With no more numbers to
the right, we need to select the largest number, again starting from the left. That would be `7`, resulting in `87`.

As usual with these Advent of Code puzzles, I feel like I'm missing something and my approach is naïve.

```text
❯ perl joltage.pl < example1
987654321111111 -> 98
^^
811111111111119 -> 89
^             ^
234234234234278 -> 78
             ^^
818181911112111 -> 92
      ^    ^

❯ perl joltage.pl < example1 | awk '$2 == "->" { print $3 }' | paste -sd+ - | bc
357

❯ perl joltage.pl < input | head -8
3223323232423342133321323321133325222233342332323323343713331321434231231232333333232334233323322122 -> 74
                                                       ^        ^
3422323123349134332433333333432333313333323413433133433343234433433334323333452433843344143323335344 -> 98
            ^                                                                     ^
3323113221321312236523622222221222225424323212132242333365351332221432232235143422248222121121832228 -> 88
                                                                                    ^         ^
3463333333523444333334433344544335323235227453444243335438244443585333243345323433342343323423544343 -> 88
                                                         ^       ^

❯ perl joltage.pl < input | awk '$2 == "->" { print $3 }' | paste -sd+ - | bc
17207
```

## Part Two

Ah, there was my naiveté. I wrote a solution that supports exactly two batteries. Now I need to come up with a solution that works with `n` batteries. Based on the
examples, let's see if I can determine an algorithm.

Given how I solved part one, I developed an approach of scanning for the largest number in the string and scanning back and forth to locate the next number. That was
wrong in that it would only sometimes worked. After getting frustrated and going to Reddit, I realized what a proper approach would be.

Given the length of the final number, we can assume that the first digit will be the highest number found in the bank, leaving at least enough room for the remaining
digits. So, in the examples, to select 12 batteries out of 15, the first number must be one of the first 4 batteries. So we can select the highest number from that list.
Now we have to leave room for 11 batteries, starting our search to the right of the battery we just selected.

It all seems obvious in retrospect and the code turned out to be much simpler than I expected.

```
❯ perl joltage2.pl 2 < example1
987654321111111 -> 98
^^
811111111111119 -> 89
^             ^
234234234234278 -> 78
             ^^
818181911112111 -> 92
      ^    ^

❯ perl joltage2.pl 12 < example1
987654321111111 -> 987654321111
^^^^^^^^^^^^
811111111111119 -> 811111111119
^^^^^^^^^^^   ^
234234234234278 -> 434234234278
  ^ ^^^^^^^^^^^
818181911112111 -> 888911112111
^ ^ ^ ^^^^^^^^^

❯ perl joltage2.pl 12 < input | tail -8
6645513635553536456434465554555532563634624843245574253462583453246844857313433341876266423526473852 -> 888887673852
                                           ^               ^       ^  ^           ^^^          ^^^^^
1113233522332432321212222313412315521343627282223261232234221222322442422324222532621323222434113195 -> 866434113195
                                            ^     ^                               ^        ^^^^^^^^^
2221255122222112321232232225222222242222221523222213222222221121122123224312322231221223212222222224 -> 555543333224
     ^^                    ^               ^                            ^^  ^   ^      ^^ ^        ^
1112121122222223222222222222112242222232323212322222213112322622222132213212123253423222223242122232 -> 654342122232
                                                             ^                  ^ ^ ^       ^^^^^^^^

❯ perl joltage2.pl 12 < input | awk '$2 == "->" { print $3 }' | paste -sd+ - | bc
170997883706617
```
