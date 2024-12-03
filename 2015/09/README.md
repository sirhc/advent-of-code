# Day 9: All in a Single Night

https://adventofcode.com/2015/day/9

## Part One

```
❯ perl distance.pl input | tail
AlphaCentauri -> Arbre -> Faerun -> Norrath -> Snowdin -> Tambi -> Straylight -> Tristram = 526
Tristram -> AlphaCentauri -> Arbre -> Faerun -> Norrath -> Snowdin -> Straylight -> Tambi = 631
AlphaCentauri -> Tristram -> Arbre -> Faerun -> Norrath -> Snowdin -> Straylight -> Tambi = 637
AlphaCentauri -> Arbre -> Tristram -> Faerun -> Norrath -> Snowdin -> Straylight -> Tambi = 669
AlphaCentauri -> Arbre -> Faerun -> Tristram -> Norrath -> Snowdin -> Straylight -> Tambi = 584
AlphaCentauri -> Arbre -> Faerun -> Norrath -> Tristram -> Snowdin -> Straylight -> Tambi = 683
AlphaCentauri -> Arbre -> Faerun -> Norrath -> Snowdin -> Tristram -> Straylight -> Tambi = 614
AlphaCentauri -> Arbre -> Faerun -> Norrath -> Snowdin -> Straylight -> Tristram -> Tambi = 589
AlphaCentauri -> Arbre -> Faerun -> Norrath -> Snowdin -> Straylight -> Tambi -> Tristram = 562
207
```

## Part Two

```
❯ perl distance.pl input | tail
Tristram -> AlphaCentauri -> Arbre -> Faerun -> Norrath -> Snowdin -> Straylight -> Tambi = 631
AlphaCentauri -> Tristram -> Arbre -> Faerun -> Norrath -> Snowdin -> Straylight -> Tambi = 637
AlphaCentauri -> Arbre -> Tristram -> Faerun -> Norrath -> Snowdin -> Straylight -> Tambi = 669
AlphaCentauri -> Arbre -> Faerun -> Tristram -> Norrath -> Snowdin -> Straylight -> Tambi = 584
AlphaCentauri -> Arbre -> Faerun -> Norrath -> Tristram -> Snowdin -> Straylight -> Tambi = 683
AlphaCentauri -> Arbre -> Faerun -> Norrath -> Snowdin -> Tristram -> Straylight -> Tambi = 614
AlphaCentauri -> Arbre -> Faerun -> Norrath -> Snowdin -> Straylight -> Tristram -> Tambi = 589
AlphaCentauri -> Arbre -> Faerun -> Norrath -> Snowdin -> Straylight -> Tambi -> Tristram = 562
207
804
```
