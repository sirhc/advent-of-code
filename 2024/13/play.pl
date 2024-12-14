#!/usr/bin/env perl

use v5.40;
use strict;

use List::Util qw( sum );
use Data::Dump;

my @input = grep { length } split "\n", do { local $/; <> };
my @prizes;  # $prize[$i] = [ $cost, ... ]

while ( @input ) {
  my $button_a = shift @input;
  my $button_b = shift @input;
  my $prize    = shift @input;

  # Button A: X+94, Y+34
  $button_a = [ $button_a =~ m/X.(\d+), Y.(\d+)/ ];

  # Button B: X+22, Y+67
  $button_b = [ $button_b =~ m/X.(\d+), Y.(\d+)/ ];

  # Prize: X=8400, Y=5400
  $prize = [ $prize =~ m/X.(\d+), Y.(\d+)/ ];

  my @presses = ();  # $presses[$i] = [ [ $a, $b ], ... ]

  for my $a ( 0 .. 100 ) {
    for my $b ( 0 .. 100 ) {
      next unless $a * $button_a->[0] + $b * $button_b->[0] == $prize->[0];
      next unless $a * $button_a->[1] + $b * $button_b->[1] == $prize->[1];

      push @presses, [ $a, $b ];
    }
  }

  dd { A => $button_a, B => $button_b, P => $prize };
  dd { presses => \@presses };
  dd { cost => [ map { cost( @$_ ) } @presses ] };

  push @prizes, map { cost( @$_ ) } @presses;
}

dd { prizes => \@prizes };
dd { tokens => sum @prizes };

sub cost {
  my ( $a, $b ) = @_;

  return 3 * $a + $b;
}
