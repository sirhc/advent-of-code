#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( sum );

my $diagram   = [ map { chomp; [ split // ] } <> ];
my $timelines = [ map { [ (0) x scalar @{ $diagram->[$_] } ] } 0 .. $#$diagram ];

for my $row ( 0 .. $#$diagram - 1 ) {
  @{ $timelines->[$row] } = @{ $timelines->[$row - 1] };  # copy the previous row to propagate timelines

  for my $col ( 0 .. $#{ $diagram->[$row] } ) {
    if ( $diagram->[$row][$col] eq 'S' ) {
      $timelines->[$row][$col] = 1;  # start with one timeline
    }

    if ( $diagram->[$row][$col] eq '^' ) {
      $timelines->[$row][$col - 1] += $timelines->[$row - 1][$col];  # split the timelines to the left
      $timelines->[$row][$col + 1] += $timelines->[$row - 1][$col];  # ... and the right
      $timelines->[$row][$col] = 0;  # no timelines directly below the splitter
    }

    if ( $diagram->[$row][$col] eq 'S' || $diagram->[$row][$col] eq '|' ) {
      if ( $diagram->[$row + 1][$col] eq '.' ) {
        $diagram->[$row + 1][$col] = '|';
      }

      if ( $diagram->[$row + 1][$col] eq '^' ) {
        $diagram->[$row + 1][$col - 1] = '|';
        $diagram->[$row + 1][$col + 1] = '|';
      }
    }
  }
}

@{ $timelines->[-1] } = @{ $timelines->[-2] };

render( $diagram, $timelines );

sub render {
  my ( $diagram, $timelines ) = @_;

  for my $row ( 0 .. $#$diagram ) {
    say sprintf '%s %2d %d', ( join '', @{ $diagram->[$row] } ), count( $diagram, $row ), sum @{ $timelines->[$row] };
  }
}

sub count {
  my ( $diagram, $row ) = @_;

  return sum map { $diagram->[$row][$_] eq '^' && $diagram->[$row - 1][$_] eq '|' ? 1 : 0 } 0 .. $#{ $diagram->[$row] };
}
