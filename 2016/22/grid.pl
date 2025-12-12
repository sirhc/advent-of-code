#!/usr/bin/env perl

use v5.40;
use strict;

my $grid = [];
my $goal;   # [ $row, $col ]
my $empty;  # [ $row, $col ]

while ( my $line = <> ) {
  # Filesystem              Size  Used  Avail  Use%
  # /dev/grid/node-x0-y0     92T   72T    20T   78%
  next unless $line =~ /node-x(\d+)-y(\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T/;

  $grid->[$2][$1] = {
    size  => $3,
    used  => $4,
    avail => $5,
  };

  if ( $4 == 0 ) {
    $empty = [ $2, $1 ];
  }
}

$goal = [ 0, $#{ $grid->[0] } ];
$empty = [ 1, 1 ];

for my $row ( 0 .. $#$grid ) {
  for my $col ( 0 .. $#{ $grid->[$row] } ) {
    if ( $row == 0 && $col == 0 ) {
      print ' A ';
      next;
    }

    if ( $row == $goal->[0] && $col == $goal->[1] ) {
      print ' G ';
      next;
    }

    if ( $row == $empty->[0] && $col == $empty->[1] ) {
      print ' _ ';
      next;
    }

    # Mark if the node is too small to store the goal data (spoiler: they're all large enough).
    if ( $grid->[$row][$col]->{size} < $grid->[ $goal->[0] ][ $goal->[0] ]->{used} ) {
      print ' X ';
      next;
    }

    # Mark if the node uses more space than the size of our empty node.
    if ( $grid->[$row][$col]->{used} > $grid->[ $empty->[0] ][ $empty->[0] ]->{size} ) {
      print ' # ';
      next;
    }

    print ' . ';
  }

  print "\n";
}
