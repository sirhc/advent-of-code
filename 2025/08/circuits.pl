#!/usr/bin/env perl

use v5.40;
use strict;

my $c = 0;
my $connections = shift // die 'missing connection count';
my @junctions   = map { chomp; [ ( split /,/ ), $c++ ] } <>;  # [ [ x, y, z, circuit ], ... ]
my @distances   = ();  # [ [ distance, i, j ], ... ]

for my $i ( 0 .. $#junctions ) {
  for my $j ( $i + 1 .. $#junctions ) {
    push @distances, [ distance( $junctions[$i], $junctions[$j] ), $i, $j ];
  }
}

@distances = sort { $b->[0] <=> $a->[0] } @distances;

while ( $connections --> 0 ) {
  my $connection = pop @distances;
  my $i = $junctions[ $connection->[1] ];
  my $j = $junctions[ $connection->[2] ];

  $_->[3] = $j->[3] for grep { $_->[3] == $i->[3] } @junctions;  # add $i to $j's circuit
}

say for map { sprintf '%-17s => %d', ( join ',', @{ $_ }[0, 1, 2] ), $_->[3] } @junctions;

sub distance {
  my ( $a, $b ) = @_;

  return ( $a->[0] - $b->[0] ) ** 2 + ( $a->[1] - $b->[1] ) ** 2 + ( $a->[2] - $b->[2] ) ** 2;
}
