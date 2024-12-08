# Day 12: JSAbacusFramework.io

https://adventofcode.com/2015/day/12

## Part One

```
❯ grep -Po -- '-?\d+' input | paste -sd+ | bc
119433
```

## Part Two

Find all of the "red" values in the input and remove the object that contains them.

```
❯ jq -c 'paths(scalars)' input | head
["e","a","e"]
["e","a","c"]
["e","a","a","c"]
["e","a","a","a"]
["e","a","a","b"]
["e","a","a","d"]
["e","a","g"]
["e","a","b","e"]
["e","a","b","c","c"]
["e","a","b","c","a"]

❯ jq -c 'paths(scalars) as $path | select(($path[-1] | type) == "string" and getpath($path) == "red") | $path, getpath($path)' input | head
["e","a","b","d",6,"c"]
"red"
["e","a","d","b","e"]
"red"
["e","a","f","d","d"]
"red"
["e","b",0,1,3,3,"b"]
"red"
["e","b",0,1,3,4,"i"]
"red"

❯ jq 'delpaths( [ paths(scalars) as $path | select(($path[-1] | type) == "string" and getpath($path) == "red") | $path[0:-1] ] )' input | grep -Po -- '-?\d+' | paste -sd+ | bc
68466
```
