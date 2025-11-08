# Day 4: Security Through Obscurity

https://adventofcode.com/2016/day/4

## Part One

```
❯ perl rooms.pl example1
Room aaaaa-bbb-z-y-x-123[abxyz] is valid.
Room a-b-c-d-e-f-g-h-987[abcde] is valid.
Room not-a-real-room-404[oarel] is valid.
Room totally-real-room-200[decoy] is NOT valid.

❯ https adventofcode.com/2016/day/4/input | perl rooms.pl | grep 'is valid' | grep -Eo '[0-9]+' | paste -sd+ - | bc
361724
```

## Part Two

I'm glad I wrote my script to print the room names, because now I can just feed the output into a shell pipeline.

```
❯ echo qzmt-zixmtkozy-ivhz-343 | parallel -C - 'echo {} | caesar {-1}'
very encrypted name 343

❯ perl rooms.pl example1 | awk '/is valid/ { print $2 }' | parallel -C - 'echo {} | caesar {-1}'
ttttt uuu s r q 123[tuqrs]
z a b c d e f g 987[zabcd]
bch o fsoz fcca 404[cofsz]

❯ https adventofcode.com/2016/day/4/input | perl rooms.pl | awk '/is valid/ { print $2 }' | parallel -C - 'echo {} | caesar {-1}' | grep north
northpole object storage 482[oterp]
```
