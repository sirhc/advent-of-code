#!/usr/bin/env perl

use v5.40;
use strict;

my %rule;

while ( my $line = <> ) {
  chomp $line;
  last if $line eq '';

  my ( $x, $y ) = split /\|/, $line;
  $rule{ $x }{ $y } = 1;
}

# use Data::Dump;
# dd \%rule;;

while ( my $line = <> ) {
  chomp $line;

  # Work backwards through the list of pages.
  my @pages = reverse split /,/, $line;

  for my $i ( 0 .. $#pages ) {
    for my $j ( $i + 1 .. $#pages ) {
      if ( exists $rule{ $pages[$i] }{ $pages[$j] } ) {
        @pages[$i, $j] = @pages[$j, $i];
      }
    }
  }

  say $pages[ ( scalar @pages ) / 2 ], ' ', join ',', reverse @pages;
}
