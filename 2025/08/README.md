# Day 8: Playground

https://adventofcode.com/2025/day/8

## Part One

After a couple of false starts in which I was performing far too many calculations, I realized that I could calculate all of the distances up front (hey, it's been a
while since I took a computer science class). Once that list is sorted, I could just process the first `n` connections. Most of my trouble came from difficulty
interpreting the puzzle instructions. In particular, it was a while before I understood that the "nothing happens" case still counts as a connection, mostly due to some
off-by-one errors while testing the example.

```
❯ perl circuits.pl 10 example
162,817,812       => 7
57,618,57         => 1
906,360,560       => 18
592,479,940       => 3
352,342,300       => 4
466,668,158       => 5
542,29,236        => 6
431,825,988       => 7
739,650,466       => 18
52,470,668        => 12
216,146,977       => 10
819,987,18        => 16
117,168,530       => 12
805,96,715        => 18
346,949,466       => 7
970,615,88        => 15
941,993,340       => 16
862,61,35         => 18
984,92,344        => 18
425,690,689       => 7

❯ perl circuits.pl 10 < example | awk '{ print $NF }' | sort | uniq -c | sort -nr
   5 18
   4 7
   2 16
   2 12
   1 6
   1 5
   1 4
   1 3
   1 15
   1 10
   1 1

❯ perl circuits.pl 10 < example | awk '{ print $NF }' | sort | uniq -c | sort -nr | head -3 | awk '{ print $1 }' | paste -sd\* - | bc
40

❯ perl circuits.pl 1000 < input
62481,24370,53899 => 749
66340,66361,12487 => 698
82829,41567,50460 => 2
88731,67035,17931 => 960
59963,32380,72202 => 611
11358,27461,47584 => 992
78416,48279,4367  => 733
15462,94871,83068 => 970
98060,13169,1863  => 82
93577,72041,53914 => 784

❯ perl circuits.pl 1000 < input | awk '{ print $NF }' | sort | uniq -c | sort -nr | head -3 | awk '{ print $1 }' | paste -sd\* - | bc
163548
```

## Part Two

```
```
