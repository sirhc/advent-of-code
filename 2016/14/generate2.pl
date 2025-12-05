#!/usr/bin/env perl

use v5.40;
use strict;

use Digest::MD5 qw( md5_hex );

my $salt  = shift @ARGV // 'abc';
my $count = shift @ARGV // 1_000_000;
my $index = 0;

while ( $index < $count ) {
  my $hash = md5_hex( $salt . $index++ );
  $hash = md5_hex( $hash ) for 1 .. 2016;
  say $hash;
}
