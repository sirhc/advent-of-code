#!/usr/bin/env perl

use v5.40;
use strict;

my $input      = $ARGV[0] // '1113222113';
my $iterations = $ARGV[1] // 40;

for my $i ( 1 .. $iterations ) {
  my $result = '';
  while ( $input =~ /((\d)\2*)/g ) {
    $result .= length($1) . $2;
  }

  say sprintf '#%2d: %s -> %s len: %d', $i, $input, $result, length $result;

  $input = $result;
}
