#!/usr/bin/env perl

use v5.40;
use strict;

my $part      = $ENV{PART} // 1;
my $blueprint = [ map { chomp; [ split // ] } <> ];
my @points    = find_points($blueprint);

my @queue   = ( [ $points[0], [ 1, (0) x ( scalar @points - 1 ) ], 0 ] );  # [ [ location, points visited, distance traveled ], ... ]
my %visited = ();                                                          # ( 'row,col,visited_0,visited_1,...' => count )

while ( @queue ) {
  my ( $location, $visited, $distance ) = @{ shift @queue };

  if ( $blueprint->[ $location->[0] ][ $location->[1] ] =~ /^(\d)$/ ) {
    $visited->[$1] = 1;
  }

  next if $visited{ join ',', @$location, @$visited }++;

  if ( $part == 1 && visited_all($visited) ) {
    say $distance;
    last;
  }

  if ( $part == 2 && visited_all($visited) && $blueprint->[ $location->[0] ][ $location->[1] ] eq '0' ) {
    say $distance;
    last;
  }

  push @queue, map { [ $_, [ @$visited ], $distance + 1 ] } neighbors( $blueprint, $location );
}

sub find_points {
  my ( $blueprint ) = @_;

  my @points = ();

  for my $row ( 0 .. $#{ $blueprint } ) {
    for my $col ( 0 .. $#{ $blueprint->[$row] } ) {
      if ( $blueprint->[$row][$col] =~ /^(\d)$/ ) {
        $points[$1] = [ $row, $col ];
      }
    }
  }

  return @points;
}

sub neighbors {
  my ( $blueprint, $location ) = @_;

  return grep { $blueprint->[ $_->[0] ][ $_->[1] ] ne '#' } map { [ $location->[0] + $_->[0], $location->[1] + $_->[1] ] } (
    [ -1,  0 ],  # up
    [  1,  0 ],  # down
    [  0, -1 ],  # left
    [  0,  1 ],  # right
  );
}

sub visited_all {
  my ( $visited ) = @_;

  return ( grep { $_ == 0 } @$visited ) ? '' : 1;
}
