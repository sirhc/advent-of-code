#!/usr/bin/env perl

use v5.40;
use strict;

use List::Util qw( all );
use List::MoreUtils qw( pairwise );

my %sue;
my %compound = (
  children    => sub { $_[0] == 3 },
  cats        => sub { $_[0]  > 7 },
  samoyeds    => sub { $_[0] == 2 },
  pomeranians => sub { $_[0]  < 3 },
  akitas      => sub { $_[0] == 0 },
  vizslas     => sub { $_[0] == 0 },
  goldfish    => sub { $_[0]  < 5 },
  trees       => sub { $_[0]  > 3 },
  cars        => sub { $_[0] == 2 },
  perfumes    => sub { $_[0] == 1 },
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
  my @compounds = sort keys %{ $sue{$sue} };
  my $check = all { $compound{$_}->($sue{$sue}{$_}) } @compounds;

  say sprintf '%s: %s%s', $sue, ( join ' ', %{ $sue{$sue} } ), $check ? ' (match)' : '';
}
