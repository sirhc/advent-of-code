#!/usr/bin/env perl

use v5.40;
use strict;

use Algorithm::Combinatorics qw( variations_with_repetition );
use List::Util qw( sum );
use Data::Dump;

my $iterations = shift // 100;
my $grid       = [];  # $grid->[$row][$col] = 1|0
my $next       = [];

while ( my $line = <> ) {
  chomp $line;
  push @{ $grid }, [ map { $_ eq '#' ? 1 : 0 } split //, $line ];
}

flaw( $grid );

# dd $grid;

sub flaw {
  my ( $grid ) = @_;

  $grid->[ 0           ][ 0                          ] = 1;
  $grid->[ 0           ][ $#{ $grid->[0] }           ] = 1;
  $grid->[ $#{ $grid } ][ 0                          ] = 1;
  $grid->[ $#{ $grid } ][ $#{ $grid->[$#{ $grid }] } ] = 1;
}

sub neighbor {
  my ( $grid, $r, $c ) = @_;

  return 0 if $r < 0 || $r > $#{ $grid };
  return 0 if $c < 0 || $c > $#{ $grid->[$r] };
  # dd $r, $c, $grid->[$r][$c];
  return $grid->[$r][$c];
}

my @neighbors = grep { !( $_->[0] == 0 && $_->[1] == 0 ) } variations_with_repetition( [ -1 .. 1 ], 2 );

for my $iteration ( 0 .. $iterations ) {
  # say for map { join '', map { $_ ? '#' : '.' } @$_ } @$grid;
  # say '';
  say "Iteration $iteration: ", sum map { sum @$_ } @$grid;
  # say '';

  for my $r ( 0 .. $#{ $grid } ) {
    for my $c ( 0 .. $#{ $grid->[$r] } ) {
      my $sum = sum map { neighbor( $grid, $r + $_->[0], $c + $_->[1]) } @neighbors;

      # dd $r, $c, '->', $grid->[$r][$c], $sum;

      $next->[$r][$c] = $grid->[$r][$c];

      if ( $grid->[$r][$c] == 1 ) {
        $next->[$r][$c] = $sum == 2 || $sum == 3 ? 1 : 0;
        next;
      }

      if ( $grid->[$r][$c] == 0 ) {
        $next->[$r][$c] = $sum == 3 ? 1 : 0;
        next;
      }
    }
  }

  for my $r ( 0 .. $#{ $grid } ) {
    for my $c ( 0 .. $#{ $grid->[$r] } ) {
      $grid->[$r][$c] = $next->[$r][$c];
    }
  }
  flaw( $grid );
}
