#!/usr/bin/env perl

use v5.40;
use strict;

use Algorithm::Permute;

my %distance;
my $shortest;
my $longest;

while ( my $line = <> ) {
  chomp $line;

  # X to Y = ###
  $line =~ m/^(\S+) to (\S+) = (\d+)$/;

  # Store the distance for both locations for easy lookup.
  $distance{$1}{$2} = $distance{$2}{$1} = $3;
}

# use Data::Dump;
# dd \%distance;

# 40,320 permutations!!
my $p = Algorithm::Permute->new( [ sort keys %distance ] );

sub distance {
  my ( @locations ) = @_;

  my $current_location = shift @locations;
  my $distance = 0;

  while ( @locations > 0 ) {
    # say $current_location, ' -> ', $locations[0], ' = ', $distance{$current_location}{ $locations[0] };
    $distance += $distance{$current_location}{ $locations[0] };
    $current_location = shift @locations;
  }
  # say $distance;

  return $distance;
}

# Brute force, baby!
while ( my @places = $p->next ) {
  my $distance = distance( @places );
  say sprintf '%s = %d', ( join ' -> ', @places ), $distance;

  if ( !defined $shortest || $distance < $shortest ) {
    $shortest = $distance;
  }

  if ( !defined $longest || $distance > $longest ) {
    $longest = $distance;
  }
}

say $shortest;
say $longest;
