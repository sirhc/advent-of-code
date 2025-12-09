#!/usr/bin/env perl

use v5.40;
use strict;
use Math::Combinatorics qw( combine );

my $part_two = shift // '';
my @tiles    = map { chomp; [ split /,/ ] } <>;

for my $pair ( combine( 2, @tiles ) ) {
  next if $part_two && ! is_valid( \@tiles, @$pair );

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

sub is_valid {  # checks if a given rectangle is valid
  my ( $tiles, $a, $b ) = @_;

  # a . 2
  # . . .
  # 1 . b
  if ( $a->[0] <= $b->[0] && $a->[1] <= $b->[1] ) {  # a is upper left, b is lower right -> check lower left, upper right
    return is_contained( $tiles, [ $a->[0], $b->[1] ], \&left_of, \&below ) && is_contained( $tiles, [ $b->[0], $a->[1] ], \&right_of, \&above );
  }

  # 1 . b
  # . . .
  # a . 2
  if ( $a->[0] <= $b->[0] && $a->[1] >  $b->[1] ) {  # a is lower left, b is upper right -> check upper left, lower right
    return is_contained( $tiles, [ $a->[0], $b->[1] ], \&left_of, \&above ) && is_contained( $tiles, [ $b->[0], $a->[1] ], \&right_of, \&below );
  }

  # 2 . a
  # . . .
  # b . 1
  if ( $a->[0] >  $b->[0] && $a->[1] <= $b->[1] ) {  # a is upper right, b is lower left -> check lower right, upper left
    return is_contained( $tiles, [ $a->[0], $b->[1] ], \&right_of, \&below ) && is_contained( $tiles, [ $b->[0], $a->[1] ], \&left_of, \&above );
  }

  # b . 1
  # . . .
  # 2 . a
  if ( $a->[0] >  $b->[0] && $a->[1] >  $b->[1] ) {  # a is lower right, b is upper left -> check upper right, lower left
    return is_contained( $tiles, [ $a->[0], $b->[1] ], \&right_of, \&above ) && is_contained( $tiles, [ $b->[0], $a->[1] ], \&left_of, \&below );
  }

  die 'huh?'
}

sub is_contained {
  my ( $tiles, $tile, $check_x, $check_y ) = @_;

  for my $to_check ( @$tiles ) {
    return 1 if $check_x->( $to_check, $tile ) && $check_y->( $to_check, $tile );
  }

  return;
}

sub above {  # true if a is above b
  my ( $a, $b ) = @_;
  return $a->[1] <= $b->[1];
}

sub below {  # true if a is below b
  my ( $a, $b ) = @_;
  return $a->[1] >= $b->[1];
}

sub left_of {  # true if a is left of b
  my ( $a, $b ) = @_;
  return $a->[0] <= $b->[0];
}

sub right_of {  # true if a is right of b
  my ( $a, $b ) = @_;
  return $a->[0] >= $b->[0];
}
