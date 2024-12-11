# Day 21: RPG Simulator 20XX

https://adventofcode.com/2015/day/21

## Part One

```
❯ perl start.pl input | mlr --c2p filter '$Winner == "Player Wins"' then sort -n Cost then head
Weapon    Armor      Ring1      Ring2      Cost DamageStat ArmorStat Winner
Longsword Leather    Damage +1  -          78   8          1         Player Wins
Longsword None       Damage +1  Defense +1 85   8          1         Player Wins
Greataxe  Leather    -          -          87   8          1         Player Wins
Warhammer Leather    Damage +2  -          88   8          1         Player Wins
Longsword None       Damage +2  -          90   9          0         Player Wins
Longsword Chainmail  Defense +1 -          91   7          3         Player Wins
Longsword Leather    Defense +2 -          93   7          3         Player Wins
Longsword Splintmail -          -          93   7          3         Player Wins
Greataxe  None       Defense +1 -          94   8          1         Player Wins
Warhammer None       Damage +2  Defense +1 95   8          1         Player Wins
```

## Part Two

```
```
