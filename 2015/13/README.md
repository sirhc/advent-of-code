# Day 13: Knights of the Dinner Table

https://adventofcode.com/2015/day/13

## Part One

```
❯ perl happiness.pl input | sort -n | tail
 733 : David -> Eric -> Carol -> Frank -> Bob -> Alice -> Mallory -> George
 733 : David -> George -> Mallory -> Alice -> Bob -> Frank -> Carol -> Eric
 733 : Eric -> Carol -> Frank -> Bob -> Alice -> Mallory -> George -> David
 733 : Eric -> David -> George -> Mallory -> Alice -> Bob -> Frank -> Carol
 733 : Frank -> Bob -> Alice -> Mallory -> George -> David -> Eric -> Carol
 733 : Frank -> Carol -> Eric -> David -> George -> Mallory -> Alice -> Bob
 733 : George -> David -> Eric -> Carol -> Frank -> Bob -> Alice -> Mallory
 733 : George -> Mallory -> Alice -> Bob -> Frank -> Carol -> Eric -> David
 733 : Mallory -> Alice -> Bob -> Frank -> Carol -> Eric -> David -> George
 733 : Mallory -> George -> David -> Eric -> Carol -> Frank -> Bob -> Alice
```

## Part Two

```
❯ perl happiness.pl input input2 | sort -n | tail
 725 : Eric -> Carol -> Frank -> Bob -> Alice -> Mallory -> Me -> George -> David
 725 : Eric -> David -> George -> Me -> Mallory -> Alice -> Bob -> Frank -> Carol
 725 : Frank -> Bob -> Alice -> Mallory -> Me -> George -> David -> Eric -> Carol
 725 : Frank -> Carol -> Eric -> David -> George -> Me -> Mallory -> Alice -> Bob
 725 : George -> David -> Eric -> Carol -> Frank -> Bob -> Alice -> Mallory -> Me
 725 : George -> Me -> Mallory -> Alice -> Bob -> Frank -> Carol -> Eric -> David
 725 : Mallory -> Alice -> Bob -> Frank -> Carol -> Eric -> David -> George -> Me
 725 : Mallory -> Me -> George -> David -> Eric -> Carol -> Frank -> Bob -> Alice
 725 : Me -> George -> David -> Eric -> Carol -> Frank -> Bob -> Alice -> Mallory
 725 : Me -> Mallory -> Alice -> Bob -> Frank -> Carol -> Eric -> David -> George
```
