#!/usr/bin/env perl

use v5.40;
use strict;

use Algorithm::Combinatorics qw( combinations );
use Data::Dump;

my @map;    # $map[0] = [ split //, '....1.y.D...Y..........w....m.....................' ]
my %nodes;  # $nodes{'X'} = [ [ $row, $col ], [ $row, $col ], ... ]

while ( my $line = <> ) {
  chomp $line;
  push @map, [ split //, $line ];

  my $row = $#map;
  my @col = grep { $map[$row][$_] ne '.' } 0 .. $#{$map[$row]};

  push @{ $nodes{ $map[$row][$_] } }, [ $row, $_ ] for @col;
}

# dd %nodes;

say join '', @$_ for @map;
say '';

for my $node ( sort keys %nodes ) {
  # dd $nodes{$node};

  for my $pair ( combinations( $nodes{$node}, 2 ) ) {
    my $r = $pair->[0][0] - $pair->[1][0];  # row distance
    my $c = $pair->[0][1] - $pair->[1][1];  # col distance

    # Work our way "up" and "down" from our first pair until we fall off the map.
    for my $direction ( qw( up down ) ) {
      my @location = @{ $pair->[0] };

      # Limit ourselves to the size of the map. Could use while(1) here, but boundaries are good.
      for ( 0 .. $#map ) {
        # dd @location;

        last if $location[0] < 0 || $location[0] > $#map;
        last if $location[1] < 0 || $location[1] > $#{$map[$r]};

        $map[ $location[0] ][ $location[1] ] = '#';

        $location[0] = $direction eq 'up' ? $location[0] + $r : $location[0] - $r;
        $location[1] = $direction eq 'up' ? $location[1] + $c : $location[1] - $c;
      }
    }
  }
}

say join '', @$_ for @map;
say '';

say scalar @{ [ map { grep { $_ eq '#' } @$_ } @map ] };
