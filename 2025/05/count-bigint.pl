#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( pairs );
use Math::BigInt;

undef $/;

my $input  = <>; chomp $input;
my @ranges = sort { $a->[0] <=> $b->[0] } map { [ map { Math::BigInt->new($_) } split '-' ] } split "\n", ( split /\n\n/, $input )[0];

my $total = Math::BigInt->new(0);

for my $range ( @ranges ) {
  my $count = $range->[1] - $range->[0] + 1;

  say sprintf '%s-%s -> %s', $range->[0]->bstr, $range->[1]->bstr, $count->bstr;

  $total += $count;
}

say '';
say 'Total -> ', $total->bstr;
