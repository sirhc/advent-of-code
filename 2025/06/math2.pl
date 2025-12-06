#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( reduce );

my @worksheet = map { chomp; $_ } <>;

my %op = (
  '+' => sub { reduce { $a + $b } @_ },
  '*' => sub { reduce { $a * $b } @_ }
);

my @nums;

for my $i ( reverse 0 .. length($worksheet[0]) - 1 ) {
  my $num = ( join '', map { substr $_, $i, 1 } @worksheet ) =~ s/\s+//gr;
  next if $num eq '';

  push @nums, $num =~ /^(\d+)/;

  if ( $num =~ /([^\d])$/ ) {
    my $op = $1;
    say sprintf '%s %s', $op, join ' ', @nums;  # Polish notation
    say '= ', $op{ $op }->( @nums );
    @nums = ();
  }
}
