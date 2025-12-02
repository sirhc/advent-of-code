# Day 2: Gift Shop

https://adventofcode.com/2025/day/2

## Part One

My first thought was that this could be a deceptively simple problem. However, the input was not too much for processing it with `seq(1)` and `awk(1)`.

```
❯ < example1 tr ',' '\n' | tr '-' ' ' | xargs -L1 seq | wc -l
106

❯ < input tr ',' '\n' | tr '-' ' ' | xargs -L1 seq | wc -l
2070328

❯ zsh invalid.zsh < example1
> 1 1
> 2 2
> 9 9
> 10 10
> 11885 11885
> 222 222
> 446 446
> 3859 3859
Sum: 1227775554

❯ zsh invalid.zsh < input | tail
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

```
```
