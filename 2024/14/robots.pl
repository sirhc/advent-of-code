#!/usr/bin/env perl

use v5.40;
use strict;

use List::Util qw( product );
use Data::Dump;

my $width   = shift @ARGV // 101;
my $height  = shift @ARGV // 103;
my $seconds = shift @ARGV // 100;
my @robots  = map { [ [ @$_[ 0, 1 ] ], [ @$_[ 2, 3 ] ] ] } map { [ m/p=(\d+),(\d+) v=(-?\d+),(-?\d+)/ ] } split /\n/, do { local $/; <> };  # p=0,4 v=3,-3

# $robots[$i] = [ [ $x, $y ], [ $vx, $vy ] ];
#
# Note: $x -> $col, $y -> $row

my $mid_width  = int( $width  / 2 );
my $mid_height = int( $height / 2 );

# dd { width  => $width, height => $height, seconds => $seconds, robots => \@robots };
print_tiles( 'Initial state:' );

for my $robot ( @robots ) {
  $robot->[0][0] = ( $robot->[0][0] + $robot->[1][0] * $seconds ) % $width;
  $robot->[0][1] = ( $robot->[0][1] + $robot->[1][1] * $seconds ) % $height;
}

# dd { width  => $width, height => $height, seconds => $seconds, robots => \@robots };
print_tiles( "After $seconds @{[ $seconds == 1 ? 'second' : 'seconds' ]}:" );

my %quadrants = map { $_ => 0 } 1 .. 4;
$quadrants{$_} += 1 for grep { $_ > 0 } map { quadrant( @{ $_->[0] } ) } @robots;
dd { quadrants => \%quadrants, safety_factor => product values %quadrants };

sub print_tiles {
  my ( $title ) = @_;

  say $title;

  for my $row ( 0 .. $height - 1 ) {
    for my $col ( 0 .. $width - 1 ) {
      print map { $_ > 0 ? $_ : '.' } scalar grep { $_->[0][1] == $row && $_->[0][0] == $col } @robots;
    }
    print "\n";
  }

  say '';

  # Print the map again, with the quadrants.
  for my $row ( 0 .. $height - 1 ) {
    if ( $row == $mid_height ) {
      say '';
      next;
    }

    for my $col ( 0 .. $width - 1 ) {
      print map { $col == $mid_width ? ' ' : $_ } map { $_ > 0 ? $_ : '.' } scalar grep { $_->[0][1] == $row && $_->[0][0] == $col } @robots;
    }
    print "\n";
  }

  say '';
}

# Not that it really matters, but this is how I'm treating the quadrants. A value of 0 means the coordinate is in one of
# the middle crosses.
#
# ..... .....
# ..1.. ..2..
# ..... .....
#
# ..... .....
# ..3.. ..4..
# ..... .....

sub quadrant {
  my ( $x, $y ) = @_;

  return 1 if $x < $mid_width && $y < $mid_height;
  return 2 if $x > $mid_width && $y < $mid_height;
  return 3 if $x < $mid_width && $y > $mid_height;
  return 4 if $x > $mid_width && $y > $mid_height;
  return 0;
}
