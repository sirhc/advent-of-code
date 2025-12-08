#!/usr/bin/env perl

use v5.40;
use strict;

my $input = shift // die 'missing input';

say sprintf '%-36s => %s', 'start', $input;

while ( my $line = <> ) {
  chomp $line;

  if ( $line =~ /^swap position (\d) with position (\d)/ ) {
    my ( $x, $y ) = ( $1, $2 );
    ( substr( $input, $x, 1 ), substr( $input, $y, 1 ) ) = ( substr( $input, $y, 1 ), substr( $input, $x, 1 ) );
  }

  # swap letter X with letter Y
  if ( $line =~ /^swap letter (\w) with letter (\w)/ ) {
    my ( $x, $y ) = ( index( $input, $1 ), index( $input, $2 ) );
    ( substr( $input, $x, 1 ), substr( $input, $y, 1 ) ) = ( substr( $input, $y, 1 ), substr( $input, $x, 1 ) );
  }

  # rotate left/right X steps
  if ( $line =~ /^rotate (left|right) (\d) steps?/ ) {
    my ( $dir, $steps ) = ( $1, $2 );
    $steps = $steps % length($input);
    $input = $dir eq 'left'
      ? substr( $input, $steps ) . substr( $input, 0, $steps )
      : substr( $input, -$steps ) . substr( $input, 0, length($input) - $steps );
  }

  # rotate based on position of letter X
  if ( $line =~ /^rotate based on position of letter (\w)/ ) {
    my $index = index( $input, $1 );
    my $steps = ( 1 + $index + ( $index >= 4 ? 1 : 0 ) ) % length($input);
    $input = substr( $input, -$steps ) . substr( $input, 0, length($input) - $steps );
  }

  # reverse positions X through Y
  if ( $line =~ /^reverse positions (\d) through (\d)/ ) {
    my ( $x, $y ) = ( $1, $2 );
    substr( $input, $x, $y - $x + 1 ) = reverse substr( $input, $x, $y - $x + 1 );
  }

  # move position X to position Y
  if ( $line =~ /^move position (\d) to position (\d)/ ) {
    my ( $x, $y, $letter ) = ( $1, $2, substr( $input, $1, 1 ) );
    substr( $input, $x, 1 ) = '';
    substr( $input, $y, 0 ) = $letter;
  }

  say sprintf '%-36s => %s', $line, $input;
}
