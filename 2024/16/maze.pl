#!/usr/bin/env perl

use v5.40;
use strict;

use List::Util qw( sum );
use Data::Dump;

#        0°                ( 0,-1)
#        ↑                    ↑
# 270° ← • →  90°  (-1, 0) ← • → ( 1, 0)
#        ↓                    ↓   
#       180°               ( 0, 1) 

my @maze  = map { chomp; [ split // ] } <>;
my $start = find_position( 'S', \@maze );    # [ row, col, direction ]
my $end   = find_position( 'E', \@maze );

# dd [ \@maze, $start, $end ];
# draw_maze( \@maze );

my %open_set  = ( hkey($start) => $start );
my %came_from = ();
my %g_score   = ( hkey($start) => 0 );
my %f_score   = ( hkey($start) => h( $start, $start ) );

while ( keys %open_set ) {
  my $current = next_location( \%open_set, \%f_score );

  if ( $current->[0] == $end->[0] && $current->[1] == $end->[1] ) {
    # dd { came_from => \%came_from };

    my @total_path = ( $current );
    while ( exists $came_from{ hkey($current) } ) {
      $current = $came_from{ hkey($current) };
      unshift @total_path, $current;
    }

    # dd { path => \@total_path, length => @total_path - 1 };

    for my $step ( @total_path ) {
      $maze[ $step->[0] ][ $step->[1] ] = get_char($step) unless
        ( $step->[0] == $start->[0] && $step->[1] == $start->[1] ) ||
        ( $step->[0] == $end->[0]   && $step->[1] == $end->[1] );
    }
    draw_maze( \@maze );

    # say @total_path - 1;  # path length
    say sum map { cost( $total_path[$_ - 1], $total_path[$_] ) } ( 1 .. $#total_path );

    last;
  }

  for my $neighbor ( neighbors( $current, \@maze ) ) {
    my $tentative_g_score = $g_score{ hkey($current) } + cost( $current, $neighbor );

    if ( !exists $g_score{ hkey($neighbor) } || $tentative_g_score < $g_score{ hkey($neighbor) } ) {
      $came_from{ hkey($neighbor) } = $current;
      $g_score{ hkey($neighbor) } = $tentative_g_score;
      $f_score{ hkey($neighbor) } = $g_score{ hkey($neighbor) } + h( $neighbor, $end );

      if ( !exists $open_set{ hkey($neighbor) } ) {
        $open_set{ hkey($neighbor) } = $neighbor;
      }
    }
  }
}

exit;

sub cost {
  my ( $location, $neighbor ) = @_;

  my $turns = abs( $location->[2] - $neighbor->[2] ) / 90;

  # The math on this considers a turn from 0 (north) to 270 (west) to be 3
  # clockwise turns, when it's really just one counter-clockwise turn.
  # There's probably a better way to figure this out, but this works.
  return 1 + 1000 * ( $turns == 3 ? 1 : $turns );
}

sub draw_maze {
  my ( $maze ) = @_;

  say join '', @$_ for @maze;
  say '';
}

sub find_position {
  my ( $char, $maze ) = @_;

  for my $row ( 0 .. $#$maze ) {
    for my $col ( 0 .. $#{ $maze->[$row] } ) {
      return [ $row, $col, 90 ] if $maze->[$row][$col] eq $char;
    }
  }

  return;
}

sub get_char {
  my ( $location ) = @_;

  return '^' if $location->[2] ==   0;
  return '>' if $location->[2] ==  90;
  return 'v' if $location->[2] == 180;
  return '<' if $location->[2] == 270;
}

sub h {
  my ( $location, $goal ) = @_;
  return abs( $location->[0] - $goal->[0] ) + abs( $location->[1] - $goal->[1] );
}

sub hkey {
  my ( $location ) = @_;
  return sprintf '%d,%d', $location->[0], $location->[1];
}

sub is_open {
  my ( $location, $maze ) = @_;
  my ( $row, $col ) = ( $location->[0], $location->[1] );
  return $row >= 0 && $row <= $#$maze &&
         $col >= 0 && $col <= $#{ $maze->[$row] } &&
         $maze->[$row][$col] ne '#';
}

sub neighbors {
  my ( $location, $maze ) = @_;

  return 
    grep { is_open( $_, $maze ) }
    map  { [ $location->[0] + $_->[0], $location->[1] + $_->[1], $_->[2] ] }
    (
      [ -1,  0,   0 ],  # north
      [  1,  0, 180 ],  # south
      [  0,  1,  90 ],  # east
      [  0, -1, 270 ],  # west
    );
}

sub next_location {
  my ( $open_set, $f_score ) = @_;
  my ( $best ) = sort { $f_score->{ $a } <=> $f_score->{ $b } } keys %$open_set;
  my $location = $open_set->{ $best };

  delete $open_set->{ $best };

  return $location;
}
