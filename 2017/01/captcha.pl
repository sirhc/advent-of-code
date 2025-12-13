#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( sum );

my @input = map { chomp; [ split // ] } <>;

for my $input ( @input ) {
  say sum map { $input->[$_] == $input->[ ( $_ + ( ( $ENV{PART} // 1 ) == 1 ? 1 : @$input / 2 ) ) % @$input ] ? $input->[$_] : 0 } 0 .. $#$input;
}
