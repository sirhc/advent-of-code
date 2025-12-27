#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( sum );

my $start = shift // die 'missing bottom program name';
my %input = map { chomp; /^(\S+) \((\d+)\)(?: -> (.*))?/ && ( $1 => { weight => $2, disc => [ split /, /, ( $3 // '' ) ] } ) } <>;

for my $program ( @{ $input{$start}{disc} } ) {
  say join "\t", $program, weight($program);
}

sub weight {
  my ( $program ) = @_;

  return sum $input{$program}{weight}, map { weight($_) } @{ $input{$program}{disc} };
}
