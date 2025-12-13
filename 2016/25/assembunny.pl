#!/usr/bin/env perl

use v5.40;
use strict;

my @instructions = map { chomp; [ split / / ] } <>;
my $register     = { a => $ENV{A} // 0, map { $_ => 0 } qw( b c d ) };
my $pointer      = 0;

while ( $pointer >= 0 && $pointer <= $#instructions ) {
  my ( $instruction, @args ) = @{ $instructions[$pointer] };

  # cpy x y -> copies x (either an integer or the value of a register) into register y
  if ( $instruction eq 'cpy' ) {
    register( $register, $args[1], $args[0] );
    $pointer++;
    next;
  }

  # inc x -> increases the value of register x by one
  if ( $instruction eq 'inc' ) {
    register( $register, $args[0], register( $register, $args[0] ) + 1 );
    $pointer++;
    next;
  }

  # dec x -> decreases the value of register x by one
  if ( $instruction eq 'dec' ) {
    register( $register, $args[0], register( $register, $args[0] ) - 1 );
    $pointer++;
    next;
  }

  # jnz x y -> jumps to an instruction y away, but only if x is not zero
  if ( $instruction eq 'jnz' ) {
    $pointer = $pointer + ( register( $register, $args[0] ) == 0 ? 1 : register( $register, $args[1] ) );
    next;
  }

  # out x -> transmits x (either an integer or the value of a register) as the next value for the clock signal
  if ( $instruction eq 'out' ) {
    # say register( $register, $args[0] );
    say join ',', ( sprintf '%b', $register->{a} ), @{ $register }{ qw( a b c d ) };
    last if register( $register, 'a' ) == 0;  # end of cycle
    $pointer++;
    next;
  }

  die "Unknown instruction: `$instruction @args`";
}

sub register {  # get/set register value
  my ( $register, $name, $value ) = @_;

  return $name unless exists $register->{ $name };  # register(1) or register(1, 2)

  $register->{ $name } = register( $register, $value ) if defined $value;  # register('a', 5) or register('a', 'b')

  return $register->{ $name };
}
