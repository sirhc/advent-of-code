#!/usr/bin/env perl

use v5.40;
use strict;

my @input = map { chomp; $_ } <>;

while ( @input ) {
  my ( $stream, $score, $depth, $garbage ) = ( shift @input, 0, 0, 0 );

  for ( my $i = 0; $i < length($stream); $i++ ) {
    my $char = substr( $stream, $i, 1 );

    if ( $garbage ) {
      $i += 1      if $char eq '!';  # skip the next character
      $garbage = 0 if $char eq '>';  # end of garbage
      next;
    }

    $depth += 1        if $char eq '{';
    $score += $depth-- if $char eq '}';
    $garbage = 1       if $char eq '<';
  }

  say $score;
}
