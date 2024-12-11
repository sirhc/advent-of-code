# Day 21: RPG Simulator 20XX

https://adventofcode.com/2015/day/21

## Part One

```
❯ perl fight.pl input | mlr --c2p filter '$Winner == "Player Wins"' then sort -n Cost then head
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

Well that was easy.

```
❯ perl fight.pl input | mlr --c2p filter '$Winner == "Boss Wins"' then sort -n Cost then tail
Weapon Armor     Ring1      Ring2      Cost DamageStat ArmorStat Winner
Dagger Leather   Damage +3  -          121  7          1         Boss Wins
Dagger Leather   Defense +1 Defense +3 121  4          5         Boss Wins
Dagger Leather   Damage +1  Defense +3 126  5          4         Boss Wins
Dagger None      Damage +3  Defense +1 128  7          1         Boss Wins
Dagger None      Defense +2 Defense +3 128  4          5         Boss Wins
Dagger None      Damage +1  Damage +3  133  8          0         Boss Wins
Dagger None      Damage +2  Defense +3 138  6          3         Boss Wins
Dagger Chainmail Damage +3  -          139  7          2         Boss Wins
Dagger Leather   Damage +3  Defense +1 141  7          2         Boss Wins
Dagger None      Damage +3  Defense +2 148  7          2         Boss Wins
```
