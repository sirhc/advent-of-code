#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( max min sum );

my $input = [ map { chomp; [ split ' ' ] } <> ];

say sum map { max(@$_) - min(@$_) } @$input;
