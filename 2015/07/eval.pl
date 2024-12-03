#!/usr/bin/env perl

use v5.40;
use strict;

use Memoize;

# This will run for a very, very long time if we recalculate the values each time. Once we know the value of a wire, we
# can just reuse it.
memoize('evaluate');

my %diagram;  # e.g., $diagram{'a'} = "lx"

sub evaluate {
  my ( $expr ) = @_;

  if ( $expr =~ m/^\d+$/ ) {
    return $expr;
  }

  if ( ! exists $diagram{ $expr } ) {
    die "Unknown wire: $expr";
  }

  say "$expr -> $diagram{ $expr }";

  if ( my ( $x, $y ) = $diagram{ $expr } =~ m/^(\S+) AND (\S+)$/ ) {
    return evaluate($x) & evaluate($y);
  }

  if ( my ( $x, $y ) = $diagram{ $expr } =~ m/^(\S+) OR (\S+)$/ ) {
    return evaluate($x) | evaluate($y);
  }

  if ( my ( $x, $y ) = $diagram{ $expr } =~ m/^(\S+) LSHIFT (\S+)$/ ) {
    return evaluate($x) << $y;
  }

  if ( my ( $x, $y ) = $diagram{ $expr } =~ m/^(\S+) RSHIFT (\S+)$/ ) {
    return evaluate($x) >> $y;
  }

  if ( my ( $x ) = $diagram{ $expr } =~ m/^NOT (\S+)$/ ) {
    return ~evaluate($x);
  }

  return evaluate( $diagram{ $expr } );
}

while ( my $line = <> ) {
  $line =~ m/^(.+) -> (\S+)/;
  $diagram{$2} = $1;
}

# use Data::Dump;
# dd \%diagram; say '';

# Using the example data for testing.
# for my $wire ( qw( d e f g h i x y ) ) {
#   say "$wire: ", evaluate($wire);
# }

say 'a: ', evaluate('a');
