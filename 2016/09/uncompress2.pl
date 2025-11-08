#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

my @strings = map { chomp; $_ } <>;
# dd \@strings;

say decode($_) for @strings;

sub decode {
  my ( $string ) = @_;
  my $length = 0;

  while ( length $string > 0 ) {
    if ( $string =~ /^(\((\d+)x(\d+)\))/ ) {
      my ( $match, $num_chars, $repeat ) = ( $1, $2, $3 );
      $length += decode( substr $string, length($match), $num_chars ) * $repeat;
      $string = substr $string, length($match) + $num_chars;
    }
    else {
      $length += 1;
      $string = substr $string, 1;
    }
  }

  return $length;
}
