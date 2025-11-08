# Day 8: Two-Factor Authentication

https://adventofcode.com/2016/day/8

## Part One

```
❯ perl screen.pl example1
Operation: rect 3x2
Screen:
###....
###....
.......

Lit pixels: 6

Operation: rotate column x=1 by 1
Screen:
#.#....
###....
.#.....

Lit pixels: 6

Operation: rotate row y=0 by 4
Screen:
....#.#
###....
.#.....

Lit pixels: 6

Operation: rotate column x=1 by 1
Screen:
.#..#.#
#.#....
.#.....

Lit pixels: 6
```

When running with the puzzle input, I noticed that the screen actually spells something out, which I guess makes sense.
So I changed the characters I'm using for lit and unlit pixels to make it easier to read.

```
❯ perl screen.pl input | tail -11
Operation: rotate column x=1 by 5
Screen:
****  **   **  ***   **  ***  *  * *   * **   **  
*    *  * *  * *  * *  * *  * *  * *   **  * *  * 
***  *  * *  * *  * *    *  * ****  * * *  * *  * 
*    *  * **** ***  * ** ***  *  *   *  **** *  * 
*    *  * *  * * *  *  * *    *  *   *  *  * *  * 
****  **  *  * *  *  *** *    *  *   *  *  *  **  

Lit pixels: 128
```

## Part Two

Well, there you go.
