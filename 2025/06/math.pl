#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( reduce );

my @worksheet = map { chomp; [ split ' ', $_ ] } <>;

my %op = (
  '+' => sub { reduce { $a + $b } @_ },
  '*' => sub { reduce { $a * $b } @_ }
);

my $ops = pop @worksheet;

for my $i ( 0 .. $#$ops ) {
  say sprintf '%s %s', $ops->[$i], join ' ', map { $_->[$i] } @worksheet;  # Polish notation
  say '= ', $op{ $ops->[$i] }->( map { $_->[$i] } @worksheet );
}
