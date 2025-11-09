#!/usr/bin/env perl

use v5.36;
use strict;

use List::Util qw( sum );
use Data::Dump;

my $start = [ 1, 1 ];

# Example.
# my $goal     = [ 7, 4 ];
# my $favorite = 10;

# Puzzle.
my $goal         = [ 31, 39 ];
my ( $favorite ) = map { chomp; $_ } <>;

my %open_set  = ( hkey($start) => $start );
my %came_from = ();
my %g_score   = ( hkey($start) => 0 );
my %f_score   = ( hkey($start) => h( $start, $start ) );

# dd { open_set => \%open_set, g_score => \%g_score, f_score => \%f_score };

while ( keys %open_set ) {
  my $current = next_location( \%open_set, \%f_score );

  # dd [ current => $current, neighbors => [ neighbors( $current, $favorite ) ] ];

  # Part 1.
  if ( $current->[0] == $goal->[0] && $current->[1] == $goal->[1] ) {
    # dd { came_from => \%came_from };

    my @total_path = ( $current );
    while ( exists $came_from{ hkey($current) } ) {
      $current = $came_from{ hkey($current) };
      unshift @total_path, $current;
    }

    # dd { path => \@total_path, length => @total_path - 1 };

    say @total_path - 1;
    last;
  }

  # Part 2.
  # say join ' ', $g_score{ hkey($current) }, hkey($current);

  for my $neighbor ( neighbors( $current, $favorite ) ) {
    my $tentative_g_score = $g_score{ hkey($current) } + 1;  # all path weights are the same, it's a grid

    if ( !exists $g_score{ hkey($neighbor) } || $tentative_g_score < $g_score{ hkey($neighbor) } ) {
      $came_from{ hkey($neighbor) } = $current;
      $g_score{ hkey($neighbor) } = $tentative_g_score;
      $f_score{ hkey($neighbor) } = $g_score{ hkey($neighbor) } + h( $neighbor, $goal );

      if ( !exists $open_set{ hkey($neighbor) } ) {
        $open_set{ hkey($neighbor) } = $neighbor;
      }
    }
  }
}

# dd { open_set => \%open_set, came_from => \%came_from, g_score => \%g_score, f_score => \%f_score };

sub next_location {
  my ( $open_set, $f_score ) = @_;
  my ( $best ) = sort { $f_score->{ $a } <=> $f_score->{ $b } } keys %$open_set;
  my $location = $open_set->{ $best };

  delete $open_set->{ $best };

  return $location;
}

sub hkey {
  my ( $point ) = @_;
  return sprintf '%d,%d', $point->[0], $point->[1];
}

sub neighbors {
  my ( $point, $favorite ) = @_;

  return 
    grep { is_open( $_, $favorite ) }
    map { [ $point->[0] + $_->[0], $point->[1] + $_->[1] ] }
    (
      [  0, -1 ],  # north
      [  0,  1 ],  # south
      [  1,  0 ],  # east
      [ -1,  0 ],  # west
    );
}

sub h {
  my ( $point, $goal ) = @_;
  return abs( $point->[0] - $goal->[0] ) + abs( $point->[1] - $goal->[1] );
}

sub is_open {
  my ( $point, $favorite ) = @_;
  my ( $x, $y ) = ( $point->[0], $point->[1] );
  return $x >= 0 &&
         $y >= 0 &&
         ( sum grep { $_ == 1 } split //, sprintf '%b', $x * $x + 3 * $x + 2 * $x * $y + $y + $y * $y + $favorite ) % 2 == 0;
}
