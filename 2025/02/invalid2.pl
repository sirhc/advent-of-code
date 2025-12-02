#!/usr/bin/env perl

use v5.42;
use strict;
use List::Util qw( first reduce );

while ( defined ( my $id = <> ) ) {
  chomp $id;

  # 1188511885 ->
  #   1 1 8 8 5 1 1 8 8 5
  #   11 88 51 18 85
  #   118 851 188 5
  #   1188 5118 85
  #   11885 11885 <-- invalid

  my $segments = first { reduce { $a eq $b ? $a : '' } @$_ } map { [ unpack "(A$_)*", $id ] } 1 .. ( length($id) / 2 );

  if ( defined $segments ) {
    say "$id => ", join ', ', @$segments;
  }
}
