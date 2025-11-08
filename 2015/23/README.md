# Day 23: Opening the Turing Lock

https://adventofcode.com/2015/day/23

## Part One

This was surprisingly straightforward. All I had to do was implement a simple set of functions to update registers. My hangup was that I didn't read carefully and
assumed `jio` meant "jump if odd" after seeing `jie` ("jump if even"). It's actually "jump if *one*."

```
❯ perl registers.pl example1
{
  program => [["inc", "a"], ["jio", "a", "+2"], ["tpl", "a"], ["inc", "a"]],
}
{
  instruction => ["inc", "a"],
  pointer     => 0,
  registers   => { a => 0, b => 0 },
}
{
  instruction => ["jio", "a", "+2"],
  pointer     => 1,
  registers   => { a => 1, b => 0 },
}
{
  instruction => ["inc", "a"],
  pointer     => 3,
  registers   => { a => 1, b => 0 },
}
{ instruction => undef, pointer => 4, registers => { a => 2, b => 0 } }
{ registers => { a => 2, b => 0 } }

❯ perl registers.pl input | tail -1
{ registers => { a => 1, b => 307 } }
```

## Part Two

```
```
