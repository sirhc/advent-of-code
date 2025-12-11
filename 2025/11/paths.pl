#!/usr/bin/env perl

use v5.40;
use strict;

my %input = map { $_->[0] => [ split / /, $_->[1] ] } map { chomp; [ split /: / ] } <>;

say sprintf 'you: %s', join ' ', @{ $input{you} };

while ( ! done(\%input) ) {
  @{ $input{you} } = map { $_ eq 'out' ? $_ : @{ $input{ $_ } } } grep { $_ ne 'you' } @{ $input{you} };  # avoid cycles
  say sprintf 'you: %s', join ' ', @{ $input{you} };
}

sub done {
  my ( $input ) = @_;

  return if grep { $_ ne 'out' } @{ $input->{you} };
  return 1;
}
