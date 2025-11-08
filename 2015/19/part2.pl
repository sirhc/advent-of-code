#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

# https://www.reddit.com/r/adventofcode/comments/3xflz8/comment/cy4k8ca/
#
# I was trying to create a recursive solution to this problem, working backwards from the output string to "e". Thanks to the above Reddit comment, I was able to write
# something simpler.

my %rule = map { reverse =~ m/(\w*).*\b(\w+)/ } <>;
my $string = delete $rule{""};

my $count = 0;
$count++ while ( $string =~ s/(@{[ join "|", keys %rule ]})/$rule{$1}/ );

print "$count @{[scalar reverse $string]}\n"
