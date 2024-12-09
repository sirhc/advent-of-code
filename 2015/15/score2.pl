#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;
use List::Util qw( reduce sum );
use List::MoreUtils qw( pairwise );

my %ingredient;

while ( my $line = <> ) {
  chomp $line;

  # Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
  $line =~ m/^(\w+): (.*)/;

  $ingredient{$1}{ $_->[0] } = $_->[1] for map { [ split ] } split /, /, $2;
}

# dd \%ingredient;

# Generate all possible combinations of numbers that add to 100.
sub make_list {
  my ( $sum, $size, $list ) = @_;

  if ( $size == 1 ) {
    return [ @$list, $sum ];
  }

  map { make_list( $sum - $_, $size - 1, [ @$list, $_ ] ) } ( 0 .. $sum );
}

for my $combination ( make_list( 100, ( scalar keys %ingredient ), [] ) ) {
  my %score = ();

  # say join ', ', @$combination;

  for my $property ( qw( calories capacity durability flavor texture ) ) {
    $score{$property} = sum pairwise { $a * $ingredient{$b}{$property} } @$combination, @{[ sort keys %ingredient ]};
  }

  # dd \%score;

  next if $score{calories} > 500;

  delete $score{'calories'};

  say reduce { $a * $b } map { $_ < 0 ? 0 : $_ } values %score;
}
