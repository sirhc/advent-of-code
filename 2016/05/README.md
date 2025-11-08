# Day 5: How About a Nice Game of Chess?

https://adventofcode.com/2016/day/5

## Part One

This feels computationally expensive. Even though MD5 isn't considered secure anymore, I'm not familiar with any way to
reverse engineer hashes. The incrementing number in the puzzle description suggests a brute-force approach is expected.
I'm not entirely sure what to expect in part two.

```
❯ echo -n abc3231929 | md5sum
00000155f8105dff7f56ee10fa9b9abd  -
❯ echo -n abc5017308 | md5sum
000008f82c5b3924a1ecbebf60344e00  -
❯ echo -n abc5278568 | md5sum
00000f9a2c309875e05c5a5d09f1b8c4  -
```

Before I resort to writing a program, I want to see how long it might take using command line utilities. Obviously,
there is some overhead in starting a new process for each hash, so I may end up writing a program anyway.

```
❯ echo $'3231929\n5017308\n5278568' | env door=abc parallel --env door --keep-order --tag 'printf %s%s $door {} | md5sum'
3231929 00000155f8105dff7f56ee10fa9b9abd  -
5017308 000008f82c5b3924a1ecbebf60344e00  -
5278568 00000f9a2c309875e05c5a5d09f1b8c4  -
```

In theory, this will work, but it's going to be incredibly slow due to the overhead involved in invoking `md5sum`. It's
clever, but I need something faster.

```
❯ seq 0 9999999 | env door="$( head -1 input )" parallel --env door --keep-order --tag 'printf %s%s $door {} | md5sum' | grep $'\t00000'
```

Oh yeah, that was way more reasonable. Even with the fancy printing of the password as each piece was decoded.

```
❯ time perl password.pl input
Door: uqwqemis
Password: 1 a 3 0 9 9 a a [ 16734551]
[
  [4515059, "00000191970e97b86ecd2220e76d86b2", 1],
  [6924074, "00000a1568b97dfc4736c4248df549b3", "a"],
  [8038154, "00000312234ca27718d52476a44c257c", 3],
  [13432968, "00000064ec7123bedfc9ff00cc4f55f2", 0],
  [13540621, "0000091c9c2cd243304328869af7bab2", 9],
  [14095580, "0000096753dd21d352853f1d97e19d01", 9],
  [14821988, "00000a220003ca08164ab5fbe0b7c08f", "a"],
  [16734551, "00000aaa1e7e216d6fb95a53fde7a594", "a"],
]
perl password.pl input  8.79s user 0.00s system 99% cpu 8.819 total 14k max rss
```

## Part Two

I made some improvements to my cinematic display of the password cracking. It was fun to watch.
