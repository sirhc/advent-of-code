# Day 11: Reactor

https://adventofcode.com/2025/day/11

## Part One

This part, at least, is relatively straightforward. I'm positive this isn't going to help me at all in part two, but I'm going to take the most expedient path (heh) to
solve part one. I can simply expand each path until all of them resolve to `out`. Normally, I'd like to visualize the paths taken, but that would require maintaining
state. I kept it simple. I have mad respect for the folks on Reddit who create the fancy visualizations.

```
❯ perl paths.pl < example
you: bbb ccc
you: ddd eee ddd eee fff
you: ggg out ggg out out
you: out out out out out

❯ perl paths.pl < example | tail -1 | grep -o out | wc -l
       5

❯ perl paths.pl < input | head -5
you: ftu cig mut mgp cog iou igb rzz qdz rhg lfb geh mht
you: kfo ngm gvy jur nnq xey gvy giq fkl jur pjj rzk giq gvy nnq ypt lmo uar hoj lmo cnx lmo uar kfo svx ngm cce ypt nnq gvy
you: mod djy dqp kes dal hwp kte kte kte hwp dal dxs hzt mgc dal hwp kte hwp vcz vcz kte hwp kte hzt mgc dxs sdf sdf hwp vcz dal hwp kte kte hwp dal fkx diz eso cvu eso diz ztj ztj eso fkx cvu eso eso diz ztj cvu fkx eso diz ztj ztj eso fkx cvu mod djy dqp mod djy dqp kes mod dqp fkx diz eso cvu kte hwp dal dal hwp kte
you: ryj ryj kuf kuf lip jae jae ryj lip dvf ulf ske plr plr ulf ske plr ulf ske plr ulf ske plr dvf ulf ske dgv vfe zpg isd zpg vfe dvf ulf ske plr plr ulf ske plr plr ske dvf plr ske dvf plr ulf ske plr plr ulf ske zpg vfe dgv vfe zpg isd isd vfe dgv isd vfe dgv plr plr ske dvf dvf ulf ske plr plr ulf ske plr ulf ske plr dvf ulf ske kzd wvx wpj cnn kzd wvx cij wpj cnn kzd wvx cij wpj cnn cnn kzd wvx cij kzd wvx cij wpj cnn wpj cij wvx cnn wpj cij wvx cnn kzd wvx cij kzd wvx wpj cnn wpj cnn cnn kzd wvx cij cnn kzd wvx cij kzd wvx cij wpj cnn wpj cij wvx wpj cnn kzd wvx wpj cnn cnn kzd wvx cij kzd wvx cij wpj cnn wpj cij wvx cnn wpj cij wvx cnn kzd wvx cij kzd wvx wpj cnn wpj cnn ryj ryj kuf kuf lip jae ryj ryj kuf kuf lip jae jae ryj lip ryj kuf lip jae kzd wvx wpj cnn kzd wvx cij wpj cnn kzd wvx cij wpj cnn plr ulf ske plr dvf ulf ske dvf ulf ske plr plr ulf ske
you: ohe xgp ohe xgp jta xgp jta xgp rki jta rki ohe jta rki ohe ohe xgp rki xrf lep lep fie fie fie lep lep fie fie lep lep fie fie lep lep fie fie xrf lep lep fie fpu jrp wno gip fpu kpe fpu jrp gip kpe fpu xrf lep lep fie fie fie lep lep fie fie fie lep fie xrf fie lep fie xrf fie lep lep fie fie fie lep lep fie kpe fpu fpu jrp wno gip fpu kpe fpu jrp gip fpu jrp gip fpu fpu jrp wno gip fpu jrp gip fpu fpu jrp wno gip fie fie lep fie xrf xrf lep lep fie fie fie lep lep fie fie lep lep fie fie xrf lep lep fie qbo qbo nos lud qbo nos qbo qbo qbo lud nos lud qbo nos qbo qbo qbo lud nos lud qbo nos qbo nos qbo qbo qbo lud qbo qbo lud nos lud qbo nos qbo nos lud qbo lud qbo nos qbo nos lud qbo lud qbo nos qbo qbo qbo lud qbo qbo nos lud qbo nos qbo nos lud qbo nos qbo nos qbo qbo qbo lud nos qbo qbo qbo lud qbo qbo lud nos lud qbo nos qbo nos lud qbo lud qbo nos lud qbo nos qbo qbo qbo nos lud qbo nos qbo nos qbo qbo qbo lud qbo qbo lud nos lud qbo nos qbo nos lud qbo lud qbo nos qbo nos lud qbo lud qbo nos qbo qbo qbo lud qbo qbo nos lud qbo nos qbo nos lud qbo nos qbo ohe xgp ohe xgp jta xgp jta xgp rki jta rki ohe ohe xgp ohe xgp jta xgp jta xgp rki jta rki ohe jta rki ohe ohe xgp rki ohe xgp jta xgp rki jta rki ohe qbo qbo nos lud qbo nos qbo qbo qbo lud nos lud qbo nos qbo qbo qbo lud nos lud qbo nos qbo fie lep lep fie fie xrf lep lep fie xrf lep lep fie fie fie lep lep fie

❯ perl paths.pl < input | tail -1 | grep -o out | wc -l
     690
```

## Part Two

Now I wish I had spent time printing each path in part one. I'd already be done with part two. Oh well, it's an excuse to go back and do what I wanted to do anyway. Just
for fun, I tried my new program on part one as well.

```
❯ perl paths2.pl you out < input | wc -l
     690

❯ perl paths2.pl svr out < example2
svr,aaa,fft,ccc,ddd,hub,fff,ggg,out
svr,aaa,fft,ccc,ddd,hub,fff,hhh,out
svr,aaa,fft,ccc,eee,dac,fff,ggg,out
svr,aaa,fft,ccc,eee,dac,fff,hhh,out
svr,bbb,tty,ccc,ddd,hub,fff,ggg,out
svr,bbb,tty,ccc,ddd,hub,fff,hhh,out
svr,bbb,tty,ccc,eee,dac,fff,ggg,out
svr,bbb,tty,ccc,eee,dac,fff,hhh,out

❯ perl paths2.pl svr out < example2 | grep ,dac, | grep -c ,fft,
2
```

As much as I would love to use this on my input, there are far too many paths to list them all in a reasonable amount of time. Instead, I need to create a solution that
can take advantage of memoization.

```
❯ time perl paths3.pl svr out < input
svr -> out : 557332758684000
perl paths3.pl svr out < input  0.01s user 0.01s system 78% cpu 0.026 total 6560k max rss
```

Ah yes, over 557 trillion paths. Probably best that I changed my approach.
