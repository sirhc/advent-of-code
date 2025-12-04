#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( reduce );
use List::MoreUtils qw( pairwise );

my $count = shift @ARGV // 2;
my @banks = map { chomp; [ split // ] } <>;

for my $bank ( @banks ) {
  render_bank( $bank, find_batteries( $bank, $count ) );
}

sub find_batteries {
  my ( $bank, $count ) = @_;

  my @batteries = (0) x @$bank;
  my $index = -1;

  while ( $count-- > 0 ) {
    # Find the first index of the battery with the highest joltage within the current window (we have to have enough batteries to turn on).
    $index = reduce { $bank->[$b] > $bank->[$a] ? $b : $a } $index + 1 .. $#$bank - $count;

    $batteries[$index] = 1;  # turn on battery
  }

  return @batteries;
}

sub render_bank {
  my ( $bank, @batteries ) = @_;

  say sprintf "%s -> %s\n%s",
    ( join '', @$bank ),
    ( join '', pairwise { $b ? $a : '' } @$bank, @batteries ),
    ( join '', map { $_ ? '^' : ' ' } @batteries );
}
