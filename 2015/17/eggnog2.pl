#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;
use List::Util qw( sum );

my $liters     = 150;
# my $liters     = 25;  # for the example data
my @containers = sort { $b <=> $a } split /\n/, do { local $/; <> };

# dd $liters, \@containers;

sub check {
  my ( $volume, $containers, $remaining ) = @_;

  # dd $volume, $containers, $remaining;

  # We've run out of containers.
  if ( @{ $remaining } == 0 ) {
    return 0;
  }

  # This container is too big, move on to the next.
  if ( $volume - $remaining->[0] < 0 ) {
    return check( $volume, $containers, [ @{ $remaining }[ 1 .. $#{ $remaining } ] ] );
  }

  # This container is just right, add to our solution count and try the others.
  if ( $volume - $remaining->[0] == 0 ) {
    say sprintf '%d -> %s = %d', scalar @$containers, ( join ' + ', @$containers, $remaining->[0] ), sum( @$containers, $remaining->[0] );
    return 1 + check( $volume, $containers, [ @{ $remaining }[ 1 .. $#{ $remaining } ] ] );
  }

  return check( $volume - $remaining->[0], [ @$containers, $remaining->[0] ], [ @{ $remaining }[ 1 .. $#{ $remaining } ] ] )
       + check( $volume,                      $containers,                    [ @{ $remaining }[ 1 .. $#{ $remaining } ] ] );
}

check( $liters, [], \@containers );
