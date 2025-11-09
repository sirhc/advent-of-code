#!/usr/bin/env perl

use v5.36;
use strict;

use Data::Dump;

my %register     = map { $_ => 0 } qw( a b c d );
my @instructions = <>;
my $pointer      = 0;

# $register{'c'} = 1;  # part 2

while ( $pointer >= 0 && $pointer <= $#instructions ) {
  # dd {
  #   register     => \%register,
  #   instructions => \@instructions,
  #   pointer      => $pointer,
  # };

  # cpy x y
  if ( $instructions[$pointer] =~ /^cpy (\S+) (\S+)$/ ) {
    my ( $x, $y ) = ( $1, $2 );
    $register{$y} = ( $x =~ /-?\d+/ ) ? $x : $register{$x};
    $pointer++;
    next;
  }

  # inc x, dec x
  if ( $instructions[$pointer] =~ /^(inc|dec) (\S+)$/ ) {
    $register{$2} = $register{$2} + ( $1 eq 'inc' ? 1 : -1 );
    $pointer++;
    next;
  }

  # jnz x y
  if ( $instructions[$pointer] =~ /^jnz (\S+) (\S+)$/ ) {
    my ( $x, $y ) = ( $1, $2 );
    $pointer = $pointer + ( ( $x =~ /-?\d+/ ? $x : $register{$x} ) != 0 ? $y : 1 );
    next;
  }
}

dd { register => \%register };
