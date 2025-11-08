#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

my @lines = map { chomp; $_ } <>;
# dd \@lines;

for my $line ( @lines ) {
  while ( $line =~ /(\((\d+)x(\d+)\))/gc ) {
    my ( $match, $num_chars, $repeat, $pos ) = ( $1, $2, $3, pos($line) );

    $line = join '',
      substr($line, 0, $pos - length($match)),    # everything before the marker
      substr($line, $pos, $num_chars) x $repeat,  # the repeated section, defined by the marker
      substr($line, $pos + $num_chars);           # everything after the repeated section

    # Adjust the position of the regex engine to account for the change in string length.
    pos($line) = $pos - length($match) + $num_chars * $repeat;
  }

  say $line;
}
