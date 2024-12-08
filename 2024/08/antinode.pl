#!/usr/bin/env perl

use v5.40;
use strict;

use Algorithm::Combinatorics qw( combinations );
use Data::Printer;

my @map;    # $map[0] = [ split //, '....1.y.D...Y..........w....m.....................' ]
my %nodes;  # $nodes{'X'} = [ [ $row, $col ], [ $row, $col ], ... ]

while ( my $line = <> ) {
  chomp $line;
  push @map, [ split //, $line ];

  my $row = $#map;
  my @col = grep { $map[$row][$_] ne '.' } 0 .. $#{$map[$row]};

  push @{ $nodes{ $map[$row][$_] } }, [ $row, $_ ] for @col;
}

# p %nodes;

# say join '', @$_ for @map;
# say '';

for my $node ( sort keys %nodes ) {
  # p $nodes{$node};

  for my $pair ( combinations( $nodes{$node}, 2 ) ) {
    my $r = $pair->[0][0] - $pair->[1][0];  # row distance
    my $c = $pair->[0][1] - $pair->[1][1];  # col distance

    my @n = ( [ $pair->[0][0] + $r, $pair->[0][1] + $c ], [ $pair->[1][0] - $r, $pair->[1][1] - $c ] );

    # Mark the antinodes on the map. This has the benefit of only marking unique locations, since if the map is already
    # marked, it will only show up once.
    for my $n ( @n ) {
      my ( $r, $c ) = @$n;
      next if $r < 0 || $r > $#map;
      next if $c < 0 || $c > $#{$map[$r]};

      $map[ $r ][ $c ] = '#';
    }
  }
}

say join '', @$_ for @map;
say '';

say scalar @{ [ map { grep { $_ eq '#' } @$_ } @map ] };
