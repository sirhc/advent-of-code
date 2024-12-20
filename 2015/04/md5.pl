#!/usr/bin/env perl

use v5.34;
use strict;

use Digest::MD5 qw( md5_hex );

my $input = $ARGV[0];
my $match = $ARGV[1] // '00000';
my $n     = 0;

while ( 1 ) {
  my $hash = md5_hex("$input$n");
  say $hash, ' ', $n;
  last if $hash =~ /^$match/;
  $n += 1;
}
