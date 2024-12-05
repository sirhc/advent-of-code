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

  my @pages  = split /,/, $line;
  my $middle = $pages[ ( scalar @pages ) / 2 ];

  # Work backwards through the list of pages.
  my @check = reverse @pages;

  while ( @check ) {
    my $value = shift @check;

    for my $i ( @check ) {
      if ( exists $rule{ $value }{ $i } ) {
        # Just set the middle value to zero, since the goal is to sum the middle values of all the good ones.
        $middle = 0;
        last;
      }
    }
  }

  say $middle, ' ', join ',', @pages;
}
