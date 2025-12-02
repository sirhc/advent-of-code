# Day 2: Gift Shop

https://adventofcode.com/2025/day/2

## Part One

My first thought was that this could be a deceptively simple problem. However, the input was not too much for processing it with `seq(1)` and `awk(1)`.

```
❯ < example1 tr ',' '\n' | tr '-' ' ' | xargs -L1 seq | wc -l
106

❯ < input tr ',' '\n' | tr '-' ' ' | xargs -L1 seq | wc -l
2070328

❯ < example1 tr ',' '\n' | tr '-' ' ' | xargs -L1 seq | awk -f invalid1.awk
> 1 1
> 2 2
> 9 9
> 10 10
> 11885 11885
> 222 222
> 446 446
> 3859 3859
Sum: 1227775554

❯ < input tr ',' '\n' | tr '-' ' ' | xargs -L1 seq | awk -f invalid1.awk
> 7241 7241
> 7242 7242
> 7243 7243
> 7244 7244
> 7245 7245
> 7246 7246
> 7247 7247
> 7248 7248
> 7249 7249
Sum: 43952536386
```

## Part Two

Now I have to do additional processing on each number, and I can't exclude odd-length numbers.

At first, I misinterpreted the instructions and assumed any repetition was acceptable. For example, `100` repeats `0`. So I had a loop in my Perl program that felt inelegant. After realizing
that the repetition had to be for the entire id, I got to pull in the `reduce` function and turn the entire exercise into a single line of functional code. The scaffolding around the code is
just so I can see the repetition.

This version did take a few seconds longer to run.

```
❯ < example1 tr ',' '\n' | tr '-' ' ' | xargs -L1 seq | perl invalid2.pl
11 => 1, 1
22 => 2, 2
99 => 9, 9
111 => 1, 1, 1
999 => 9, 9, 9
1010 => 10, 10
1188511885 => 11885, 11885
222222 => 2, 2, 2, 2, 2, 2
446446 => 446, 446
38593859 => 3859, 3859
565656 => 56, 56, 56
824824824 => 824, 824, 824
2121212121 => 21, 21, 21, 21, 21

❯ < example1 tr ',' '\n' | tr '-' ' ' | xargs -L1 seq | perl invalid2.pl | cut -d' ' -f1 | paste -sd+ | bc
4174379265

❯ < input tr ',' '\n' | tr '-' ' ' | xargs -L1 seq | perl invalid2.pl | tail
82828282 => 82, 82, 82, 82
72417241 => 7241, 7241
72427242 => 7242, 7242
72437243 => 7243, 7243
72447244 => 7244, 7244
72457245 => 7245, 7245
72467246 => 7246, 7246
72477247 => 7247, 7247
72487248 => 7248, 7248
72497249 => 7249, 7249

❯ < input tr ',' '\n' | tr '-' ' ' | xargs -L1 seq | perl invalid2.pl | cut -d' ' -f1 | paste -sd+ | bc
54486209192
```
