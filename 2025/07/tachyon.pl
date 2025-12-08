#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( sum );

my $diagram = [ map { chomp; [ split // ] } <> ];

for my $row ( 0 .. $#$diagram - 1 ) {
  for my $col ( 0 .. $#{ $diagram->[$row] } ) {
    if ( $diagram->[$row][$col] eq 'S' || $diagram->[$row][$col] eq '|' ) {
      if ( $diagram->[$row + 1][$col] eq '.' ) {
        $diagram->[$row + 1][$col] = '|';
        next;
      }

      if ( $diagram->[$row + 1][$col] eq '^' ) {
        $diagram->[$row + 1][$col - 1] = '|';
        $diagram->[$row + 1][$col + 1] = '|';
        next;
      }
    }
  }
}

render( $diagram );

sub render {
  my ( $diagram ) = @_;

  for my $row ( 0 .. $#$diagram ) {
    say sprintf '%s %2d', ( join '', @{ $diagram->[$row] } ), count( $diagram, $row );
  }
}

sub count {
  my ( $diagram, $row ) = @_;

  return sum map { $diagram->[$row][$_] eq '^' && $diagram->[$row - 1][$_] eq '|' ? 1 : 0 } 0 .. $#{ $diagram->[$row] };
}
