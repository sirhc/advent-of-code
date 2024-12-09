#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

my @replacements;
my $molecule;

while ( my $line = <> ) {
  chomp $line;
  last if $line eq '';  # there's a blank line between the mappings and the molecule

  # H => HO
  $line =~ m/^(\S+) => (.*)/;
  push @replacements, [ $1, $2 ];
}

$molecule = <>;
chomp $molecule;

# dd \@replacements, $molecule;

# Part two is going to make us replace recursively, isn't it?

my $count = 0;

for my $replacement ( @replacements ) {
  my $tmp = $molecule;
  my $idx = 0;

  while ( 1 ) {
    $idx = index $molecule, $replacement->[0], $idx;
    last if $idx < 0;

    # dd $molecule, $idx;
    # dd {
    #   a => ( substr $molecule, 0, $idx ),                          # left of match
    #   b => ( substr $molecule, $idx, length $replacement->[0] ),   # match
    #   c => ( $replacement->[1] ),                                  # replacement
    #   d => ( substr $molecule, $idx + length $replacement->[0] ),  # right of match
    # };

    say join '', ( substr $molecule, 0, $idx ), ( $replacement->[1] ), ( substr $molecule, $idx + length $replacement->[0] );
    $idx += length $replacement->[0];
  }
}
