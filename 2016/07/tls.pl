#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;
use List::MoreUtils qw( any );

my @ips = map { chomp; $_ } <>;
# dd \@ips;

for my $ip ( @ips ) {
  next if any { abba($_) } $ip =~ m/\[([a-z]+)\]/g;       # bracketed parts
  next unless any { abba($_) } split /\[[^]]+\]/, $ip;    # non-bracketed parts

  say $ip;
}

sub abba {
  my ( $string ) = @_;

  return 0 unless $string =~ m/((.)(.)\3\2)/;
  return 0 unless $2 ne $3;
  return 1;
}
