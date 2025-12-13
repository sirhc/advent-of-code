#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( sum );
use Math::Combinatorics qw( combine );

my @rows = map { chomp; [ split ' ' ] } <>;

# I spent way too much time on this...
say sum map { map { $_->[0] / $_->[1] } grep { $_->[0] % $_->[1] == 0 } map { [ sort { $b <=> $a } @$_ ] } combine( 2, @$_ ) } @rows;
