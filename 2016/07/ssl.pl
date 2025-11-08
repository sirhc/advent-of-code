#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;
use List::MoreUtils qw( any uniq );

my @ips = map { chomp; $_ } <>;
# dd \@ips;

for my $ip ( @ips ) {
  # next if any { abba($_) } $ip =~ m/\[([a-z]+)\]/g;       # bracketed parts
  # next unless any { abba($_) } split /\[[^]]+\]/, $ip;    # non-bracketed parts

  my @aba = uniq
            grep  { !/^(.)\1/ }
            grep  { length == 3 }
            map   { m/(?=((.).\2))/g }
            split /\[[^]]+\]/, $ip; # supernet sequences
  next unless @aba;

  my @bab = map { s/^(.)(.)./$2$1$2/r } @aba;


  next unless any { /@{[ join '|', @bab ]}/ } $ip =~ m/\[([a-z]+)\]/g;  # hypernet sequences
  # dd { ip => $ip, aba => \@aba, bab => \@bab };

  say $ip;
}

sub aba {
  my ( $string ) = @_;

  return 0 unless $string =~ m/((.)(.)\3\2)/;
  return 0 unless $2 ne $3;
  return 1;
}
