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

```
```
