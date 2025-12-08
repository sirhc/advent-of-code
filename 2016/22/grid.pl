#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

my $grid = [];

while ( my $line = <> ) {
  # Filesystem              Size  Used  Avail  Use%
  # /dev/grid/node-x0-y0     92T   72T    20T   78%
  next unless $line =~ /node-x(\d+)-y(\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T/;

  $grid->[$2][$1] = {
    size  => $3,
    used  => $4,
    avail => $5,
  };
}

pairs( $grid );

sub pairs {
  my ( $grid ) = @_;

  for my $y ( 0 .. $#$grid ) {
    for my $x ( 0 .. $#{ $grid->[$y] } ) {
      say for map {
        sprintf 'node-x%d-y%d (%d) -> node-x%d-y%d (%d)',
          $x, $y, $grid->[$y][$x]{'size'},
          $_->[0], $_->[1], $grid->[ $_->[1 ]][ $_->[0] ]{'avail'},
      } viable( $grid, $x, $y );
    }
  }
}

sub viable {
  my ( $grid, $x1, $y1 ) = @_;

  my @viable = ();

  for my $y2 ( 0 .. $#$grid ) {
    for my $x2 ( 0 .. $#{ $grid->[$y2] } ) {
      next if $grid->[$y1][$x1]{'used'} == 0;  # node A is not empty
      next if $x1 == $x2 && $y1 == $y2;        # nodes A and B are not the same node
      next if $grid->[$y1][$x1]{'used'} > $grid->[$y2][$x2]{'avail'}; # the data on node A Used) would fit on node B

      push @viable, [ $x2, $y2 ];
    }
  }

  return @viable;
}
