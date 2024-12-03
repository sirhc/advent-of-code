https://adventofcode.com/2015/day/6

Part One

```
❯ perl toggle.pl input | tail
turn off 778,194 through 898,298
turn on 179,140 through 350,852
turn off 241,118 through 530,832
turn off 41,447 through 932,737
turn off 820,663 through 832,982
turn on 550,460 through 964,782
turn on 31,760 through 655,892
toggle 628,958 through 811,992

569999
```

Part Two

```
❯ perl toggle2.pl input | tail
turn off 778,194 through 898,298
turn on 179,140 through 350,852
turn off 241,118 through 530,832
turn off 41,447 through 932,737
turn off 820,663 through 832,982
turn on 550,460 through 964,782
turn on 31,760 through 655,892
toggle 628,958 through 811,992

17836115
```

```
❯ diff toggle.pl toggle2.pl
20,22c20,24
<   $lights[$x][$y] = 1 if $instruction eq 'turn on';
<   $lights[$x][$y] = 0 if $instruction eq 'turn off';
<   $lights[$x][$y] = !$lights[$x][$y] if $instruction eq 'toggle';
---
>   $lights[$x][$y] += 1 if $instruction eq 'turn on';
>   $lights[$x][$y] -= 1 if $instruction eq 'turn off';
>   $lights[$x][$y] += 2 if $instruction eq 'toggle';
>
>   $lights[$x][$y] = 0 if $lights[$x][$y] < 0;  # just in case 'turn off' was called on a light that was already at 0
```
