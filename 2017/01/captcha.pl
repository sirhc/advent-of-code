#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( sum );

my @input = map { chomp; [ split // ] } <>;

for my $input ( @input ) {
  say sum map { $input->[$_] == $input->[ ( $_ + 1 ) % @$input ] ? $input->[$_] : 0 } 0 .. $#$input;
}
