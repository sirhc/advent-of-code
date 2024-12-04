#!/usr/bin/env perl

use v5.40;
use strict;

my @rows = ();

while ( my $line = <> ) {
  chomp $line;
  push @rows, $line;
}

my $rows = scalar @rows;
my $cols = length $rows[0];

say 'rows = ', $rows;
say 'cols = ', $cols;

my $count = 0;

# Rows are easy.
#
# . . . . . .
# . X M A S .
# . S A M X .
# . . . . . .

for my $row ( @rows ) {
  # The XMAS and SAMX can overlap, so we can't just use XMAS|SAMX as the regex.
  my @m = $row =~ m/XMAS/g;
  $count += scalar @m;
  @m = $row =~ m/SAMX/g;
  $count += scalar @m;
}

say 'count after rows: ', $count;

# Columns are a bit more tricky.
#
# . X S .
# . M A .
# . A M .
# . S X .

my @cols = ();

for my $i ( 0 .. $#rows ) {
  my $col = join '', map { substr $rows[$_], $i, 1 } 0 .. $#rows;
  my @m = $col =~ m/XMAS/g;
  $count += scalar @m;
  @m = $col =~ m/SAMX/g;
  $count += scalar @m;
}

say 'count after cols: ', $count;

# Diagonals are just brute force.

# . X . . .
# . . M . .
# . . . A .
# . . . . S
#
# . S . . .
# . . A . .
# . . . M .
# . . . . X

for my $r ( 0 .. $rows - 4 ) {
  for my $c ( 0 .. $cols - 4 ) {
    my $diag = join '', ( substr $rows[$r], $c, 1 ), ( substr $rows[$r + 1], $c + 1, 1 ), ( substr $rows[$r + 2], $c + 2, 1 ), ( substr $rows[$r + 3], $c + 3, 1 );
    if ( $diag =~ /XMAS|SAMX/ ) {
      $count += 1;
    }
  }
}

say 'count after down right: ', $count;

# . . . X .
# . . M . .
# . A . . .
# S . . . .
#
# . . . S .
# . . A . .
# . M . . .
# X . . . .

for my $r ( 0 .. $rows - 4 ) {
  for my $c ( 0 .. $cols - 4 ) {
    my $diag = join '', ( substr $rows[$r], $c + 3, 1 ), ( substr $rows[$r + 1], $c + 2, 1 ), ( substr $rows[$r + 2], $c + 1, 1 ), ( substr $rows[$r + 3], $c, 1 );
    if ( $diag =~ /XMAS|SAMX/ ) {
      $count += 1;
    }
  }
}

say 'count after down left: ', $count;
