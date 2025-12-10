#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( first max min );
use Math::Combinatorics qw( combine );

my $part_two = shift // '';
my @tiles    = map { chomp; [ split /,/ ] } <>;

my %h_lines = (); push @{ $h_lines{ $_->[1] } }, $_ for @tiles;  # horizontal segments
my %v_lines = (); push @{ $v_lines{ $_->[0] } }, $_ for @tiles;  # vertical segments

my ( $upper, $lower ) = $part_two ? sort { $a->[1] <=> $b->[1] } find_exhaust_port( \%h_lines ) : ();

for my $pair ( combine( 2, @tiles ) ) {
  next if $part_two && ! is_valid( @$pair );

  say sprintf '%d %d,%d %d,%d', area( @$pair ), @{ $pair->[0] }, @{ $pair->[1] };
}

sub area {
  my ( $a, $b ) = @_;

  my ( $x1, $y1 ) = @$a;
  my ( $x2, $y2 ) = @$b;

  my $w = ( abs $x1 - $x2 ) + 1;
  my $h = ( abs $y1 - $y2 ) + 1;

  return $w * $h;
}

sub find_exhaust_port {  # return the two interior points forming the right end of the "trench"
  my ( $h_lines ) = @_;

  my @segments = ();

  for my $x ( keys %{ $h_lines } ) {
    push @segments, [ abs($h_lines{$x}->[0][0] - $h_lines{$x}->[1][0]), $h_lines{$x}->[0], $h_lines{$x}->[1] ];
  }

  @segments = sort { $b->[0] <=> $a->[0] } @segments;

  return map { $_->[1][0] > $_->[2][0] ? $_->[1] : $_->[2] } @segments[0, 1];
}

sub is_valid {  # returns true if no tiles are inside the rectangle produced by $a and $b
  my ( $a, $b ) = @_;

  # x1,y1 - - x2,y1
  #   | . . . . . |
  #   | . . . . . |
  #   | . . . . . |
  # x1,y2 - - x2,y2

  my $x1 = min( $a->[0], $b->[0] );
  my $x2 = max( $a->[0], $b->[0] );
  my $y1 = min( $a->[1], $b->[1] );
  my $y2 = max( $a->[1], $b->[1] );

  # First of all, one of the corners must be one of the exhaust port tiles. For my input, this leaves us with roughly 430 potential rectangles.
  return unless ( $x2 == $lower->[0] && $y1 == $lower->[1] ) || ( $x2 == $upper->[0] && $y2 == $upper->[1] );

  # Check if any horizontal segments intersect the rectangle.
  for my $key ( keys %h_lines ) {
    next if $key <= $y1 || $key >= $y2;  # above or below

    my ( $x_start, $x_end ) = ( min( $h_lines{$key}->[0][0], $h_lines{$key}->[1][0] ), max( $h_lines{$key}->[0][0], $h_lines{$key}->[1][0] ) );
    return if ( $x_start <= $x1 && $x_end > $x1 ) || ( $x_start < $x2 && $x_end >= $x2 );
  }

  # Check if any vertical segments intersect the rectangle.
  for my $key ( keys %v_lines ) {
    next if $key <= $x1 || $key >= $x2;  # left or right

    my ( $y_start, $y_end ) = ( min( $v_lines{$key}->[0][0], $v_lines{$key}->[1][0] ), max( $v_lines{$key}->[0][0], $v_lines{$key}->[1][0] ) );
    return if ( $y_start <= $y1 && $y_end > $y1 ) || ( $y_start < $y2 && $y_end >= $y2 );
  }

  return 1;
}
