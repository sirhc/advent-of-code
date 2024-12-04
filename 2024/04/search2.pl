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

# Diagonals are just brute force. Good thing I took the approach in part one.

# . . . . .
# . M . S .
# . . A . .
# . M . S .
# . . . . .

for my $r ( 0 .. $rows - 3 ) {
  for my $c ( 0 .. $cols - 3 ) {
    my $diag1 = join '', ( substr $rows[$r], $c, 1 ), ( substr $rows[$r + 1], $c + 1, 1 ), ( substr $rows[$r + 2], $c + 2, 1 );
    my $diag2 = join '', ( substr $rows[$r], $c + 2, 1 ), ( substr $rows[$r + 1], $c + 1, 1 ), ( substr $rows[$r + 2], $c, 1 );

    if ( $diag1 =~ /MAS|SAM/ && $diag2 =~ /MAS|SAM/ ) {
      $count += 1;
    }
  }
}

say 'count: ', $count;
