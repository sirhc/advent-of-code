#!/usr/bin/env perl

use v5.40;
use strict;

use List::Util qw( all );
use List::MoreUtils qw( pairwise );

my %sue;
my %compound = (
  children    => 3,
  cats        => 7,
  samoyeds    => 2,
  pomeranians => 3,
  akitas      => 0,
  vizslas     => 0,
  goldfish    => 5,
  trees       => 3,
  cars        => 2,
  perfumes    => 1,
);

while ( my $line = <> ) {
  chomp $line;

  # Sue 1: goldfish: 9, cars: 0, samoyeds: 9
  my ( $sue, $compounds ) = $line =~ m/^(Sue \d+): (.*)/;
  $sue{$sue}{$1} = $2 while $compounds =~ m/(\w+): (\d+)/g;
}

# use Data::Dump;
# dd \%compound;
# dd \%sue;

for my $sue ( keys %sue ) {
  my @compounds = sort keys %{$sue{$sue}};
  my $check = all { $_ } pairwise { $a == $b } @{[ @{ $sue{$sue} }{ @compounds } ]}, @{[ @compound{ @compounds } ]};

  say sprintf '%s: %s%s', $sue, ( join ' ', %{ $sue{$sue} } ), $check ? ' (match)' : '';
}
