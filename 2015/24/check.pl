#!/usr/bin/env perl

use v5.40;
use strict;

use Algorithm::Combinatorics qw( combinations );
use List::Util qw( sum product );

my @packages = sort { $a <=> $b } map { $_ + 0 } <>;

# my $target_weight = sum(@packages) / 3;  # part 1
my $target_weight = sum(@packages) / 4;  # part 2

# Print the quantum entanglement for all of the combinations of a given size that equals the target weight. Once we've found at least one valid combination at a given size,
# we can stop searching.
my $found = 0;
for my $size ( 1 .. $#packages ) {
  my $iter = combinations( \@packages, $size );
  while ( my $group = $iter->next ) {
    next unless sum(@$group) == $target_weight;
    say sprintf '%d (%s)', product(@$group), join( ', ', sort { $a <=> $b } @$group );
    $found = 1;
  }
  last if $found;
}
