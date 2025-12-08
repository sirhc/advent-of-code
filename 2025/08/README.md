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

To accomplish part two, I modified my code slightly to print some information and bail out if it detects that only one circuit exists. This allows me to provide a value
for `n` much higher than I anticipate needing while preserving the rest of the code (though the above one-liners will need modification to exclude the additional lines).

```
❯ perl circuits.pl 1000 < example | head
Number of connections : 29
Final connection      : 216,146,977 and 117,168,530

162,817,812       => 15
57,618,57         => 15
906,360,560       => 15
592,479,940       => 15
352,342,300       => 15
466,668,158       => 15
542,29,236        => 15

❯ echo '216 * 117' | bc
25272

❯ perl circuits.pl 10000 < input | head
Number of connections : 5492
Final connection      : 30181,15729,8194 and 25594,2972,13222

62481,24370,53899 => 847
66340,66361,12487 => 847
82829,41567,50460 => 847
88731,67035,17931 => 847
59963,32380,72202 => 847
11358,27461,47584 => 847
78416,48279,4367  => 847

❯ echo '30181 * 25594' | bc
772452514
```
