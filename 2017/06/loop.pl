#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( reduce );

my @blocks = map { chomp; split ' ' } <>;
my %seen;
my $i = 0;

say join ' ', "$i:", @blocks;

while ( 1 ) {
  my $index = reduce { $blocks[$b] > $blocks[$a] ? $b : $a } 0 .. $#blocks;
  my $value = $blocks[$index];

  $blocks[$index] = 0;

  do {
    $index = ( $index + 1 ) % @blocks;
    $blocks[$index]++;
  } while ( --$value > 0 );

  $i++;
  say join ' ', "$i:", @blocks;

  if ( $seen{ join ',', @blocks }++ ) {
    exit;
  }
}
