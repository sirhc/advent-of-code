# Day 4: High-Entropy Passphrases

https://adventofcode.com/2017/day/4

## Part One

I almost hesitate to do this with a simple shell one-liner, because it may not serve in my part two.

```
❯ < example while read -r line; do printf '%s %s\n' $line "$( <<< $line tr ' ' '\n' | sort | uniq -c | awk '$1 > 1 { print "invalid"; exit }' )"; done
aa bb cc dd ee 
aa bb cc dd aa invalid
aa bb cc dd aaa

❯ < input while read -r line; do printf '%s %s\n' $line "$( <<< $line tr ' ' '\n' | sort | uniq -c | awk '$1 > 1 { print "invalid"; exit }' )"; done | grep -v ' invalid' | wc -l
383
```

## Part Two

```
```
