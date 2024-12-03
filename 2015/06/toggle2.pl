#!/usr/bin/env perl

use v5.34;
use strict;
use List::Util qw( sum );

$| = 1;

# (0, 999) ... (999, 999)
#  .            .
#  .            .
#  .            .
# (0, 0)   ... (999, 0)

my @lights = ();  # $lights[$x][$y] = true|false

sub update_light {
  my ( $x, $y, $instruction ) = @_;

  $lights[$x][$y] += 1 if $instruction eq 'turn on';
  $lights[$x][$y] -= 1 if $instruction eq 'turn off';
  $lights[$x][$y] += 2 if $instruction eq 'toggle';

  $lights[$x][$y] = 0 if $lights[$x][$y] < 0;  # just in case 'turn off' was called on a light that was already at 0
}

while ( my $line = <> ) {
  chomp $line;

  say $line;

  # E.g.,
  # turn on 489,959 through 759,964
  # turn off 820,516 through 871,914
  # toggle 756,965 through 812,992
  my ( $instruction, $x1, $y1, $x2, $y2 ) = $line =~ m/^(.*) (\d+),(\d+) through (\d+),(\d+)$/;

  # This would be much faster in a language that supported proper multi-dimensional arrays. But I'm taking advantage of
  # Perl's autovivification to make the code simpler.
  for my $x ( $x1 .. $x2 ) {
    for my $y ( $y1 .. $y2 ) {
      update_light( $x, $y, $instruction );
    }
  }
}

say '';
say sum map { $_ } map { defined ? @$_ : () } @lights;
