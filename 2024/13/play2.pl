#!/usr/bin/env perl

use v5.40;
use strict;

use List::Util qw( sum );
use Data::Dump;

my @input = grep { length } split "\n", do { local $/; <> };
my $error = 10000000000000;
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
  $prize = [ map { $_ + $error } $prize =~ m/X.(\d+), Y.(\d+)/ ];

  dd { A => $button_a, B => $button_b, P => $prize };

  my ( $xA, $yA ) = @{ $button_a };
  my ( $xB, $yB ) = @{ $button_b };
  my ( $xP, $yP ) = @{ $prize };

  my $A = ( $yP - ( ( $xP * $yA - $yP * $xA ) / ( -1 * $yB * $xA + $xB * $yA ) ) * $yB ) / $yA;
  my $B = ( $xP * $yA - $yP * $xA ) / ( -1 * $yB * $xA + $xB * $yA );

  dd { A => $A, B => $B };

  if ( $A == int $A && $B == int $B ) {
    push @prizes, [ $A, $B ];
  }
}

dd { prizes => \@prizes };
dd { cost   => [ map { 3 * $_->[0] + $_->[1] } @prizes ] };
dd { tokens => sum map { 3 * $_->[0] + $_->[1] } @prizes };
