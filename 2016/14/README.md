# Day 14: One-Time Pad

https://adventofcode.com/2016/day/14

## Part One

This was straightforward, but I kept bumping into edge cases due to the way I approached the problem. One that I fixed quickly was attempting to validate a candidate
hash against itself. Typical off-by-one error due to adding the candidate to the list before attempting validation. The one that took me longer, because it only affected
my input and not the example, was mistakenly validating the same hash more than once.

A tip I found in the Reddit discussion was to compute all the hashes I would need up front, which reduced the cycle time significantly.

https://www.reddit.com/r/adventofcode/comments/5i8pzz/comment/db6clgr/

Considering how deceptively tricky this simple problem was, I'm not sure I'm looking forward to part two.

```
❯ perl generate.pl $( cat example ) > example.md5
❯ perl validate.pl < example.md5 | mlr --c2p tail
index hash                             validator_index validator_hash
20371 714981a50246c55aaa14bc8baff48cf6 20994           4a31aaaaad6e0a6dc6c5911f2fef2321
20582 3946e417e23aaabb3735a4551718ffff 20994           4a31aaaaad6e0a6dc6c5911f2fef2321
20635 67e1d093a6cfe1ea8b40173aaad64273 20994           4a31aaaaad6e0a6dc6c5911f2fef2321
20669 1f7eb500d1f09b3569a762ee5c8aaacd 20994           4a31aaaaad6e0a6dc6c5911f2fef2321
21908 bf0d82c707319dd1934556e2914ccc9a 22804           1e15d83ba7591b79ccccc2e9a22f78b8
21927 74e0ccc5c8b7336be72d7dc1b9b36486 22804           1e15d83ba7591b79ccccc2e9a22f78b8
21978 3b1b8edb73ccc4cf49841d7e19b955d3 22804           1e15d83ba7591b79ccccc2e9a22f78b8
22023 705825e1986ccc196166f9d9d29c16bd 22804           1e15d83ba7591b79ccccc2e9a22f78b8
22193 00ee429b6acccdab81a4b6f2cd9ea278 22804           1e15d83ba7591b79ccccc2e9a22f78b8
22728 26ccc731a8706e0c4f979aeb341871f0 22804           1e15d83ba7591b79ccccc2e9a22f78b8

❯ perl generate.pl $( cat input ) > input.md5
❯ perl validate.pl < input.md5 | mlr --c2p tail
index hash                             validator_index validator_hash
14651 444ab6448a1e6aa87dfcd9b2362c13a2 15267           44a27ba0c4444451c082a5ba1eb52050
14833 0a2f43efe44424a8aa311319b1b45449 15267           44a27ba0c4444451c082a5ba1eb52050
15133 322732c444c14d63cbc2cf83c6fe4b0c 15267           44a27ba0c4444451c082a5ba1eb52050
15265 3e7d904440b4dd6695b150c46654a970 15267           44a27ba0c4444451c082a5ba1eb52050
18292 2addd1d5fa7ab94cec196f096c7cba17 19188           036b0266f5eb3ddddd1005842818cd96
18378 9abcac6528f42a6ddd19f4484dcc5a89 19188           036b0266f5eb3ddddd1005842818cd96
18464 1db507cc165ddd1a8a2f7a682e492a3d 19188           036b0266f5eb3ddddd1005842818cd96
18473 451d1aff2679cfb39b90cddd130968f3 19188           036b0266f5eb3ddddd1005842818cd96
18577 cc1d53a509841d4b4cddde9f9c7e296f 19188           036b0266f5eb3ddddd1005842818cd96
18626 3b9f53b34ddd6dd60113f44a9bafca29 19188           036b0266f5eb3ddddd1005842818cd96
```

## Part Two

```
```
