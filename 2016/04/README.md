# Day 4: Security Through Obscurity

https://adventofcode.com/2016/day/4

## Part One

```
❯ perl rooms.pl example1
Room aaaaa-bbb-z-y-x-123[abxyz] is valid.
Room a-b-c-d-e-f-g-h-987[abcde] is valid.
Room not-a-real-room-404[oarel] is valid.
Room totally-real-room-200[decoy] is NOT valid.

❯ perl rooms.pl input | grep 'is valid' | grep -Eo '[0-9]+' | paste -sd+ - | bc
361724
```

## Part Two

```
```
