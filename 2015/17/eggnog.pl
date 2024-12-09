#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

my $liters     = 150;
# my $liters     = 25;  # for the example data
my @containers = sort { $b <=> $a } split /\n/, do { local $/; <> };

# dd \@containers;

sub check {
  my ( $volume, $containers ) = @_;

  # dd "$volume -> @$containers";

  # We've run out of containers.
  if ( @{ $containers } == 0 ) {
    return 0;
  }

  # This container is too big, move on to the next.
  if ( $volume - $containers->[0] < 0 ) {
    return check( $volume, [ @{ $containers }[ 1 .. $#{ $containers } ] ] );
  }

  # This container is just right, add to our solution count and try the others.
  if ( $volume - $containers->[0] == 0 ) {
    return 1 + check( $volume, [ @{ $containers }[ 1 .. $#{ $containers } ] ] );
  }

  return check( $volume - $containers->[0], [ @{ $containers }[ 1 .. $#{ $containers } ] ] ) + check( $volume, [ @{ $containers }[ 1 .. $#{ $containers } ] ] );
}

say check( $liters, \@containers );
