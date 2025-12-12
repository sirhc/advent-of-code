#!/usr/bin/env perl

use v5.40;
use strict;
use Data::Dump;

my %register     = map { $_ => 0 } qw( a b c d );
my @instructions = map { chomp; [ split / / ] } <>;
my $pointer      = 0;

$register{'a'} = 7;

say 'Before:';
dd \@instructions, \%register;

while ( $pointer >= 0 && $pointer <= $#instructions ) {
  my ( $instruction, @args ) = @{ $instructions[$pointer] };

  # cpy x y -> copies x (either an integer or the value of a register) into register y
  if ( $instruction eq 'cpy' ) {
    register( $args[1], $args[0] );
    $pointer++;
    next;
  }

  # inc x -> increases the value of register x by one
  if ( $instruction eq 'inc' ) {
    register( $args[0], register( $args[0] ) + 1 );
    $pointer++;
    next;
  }

  # dec x -> decreases the value of register x by one
  if ( $instruction eq 'dec' ) {
    register( $args[0], register( $args[0] ) - 1 );
    $pointer++;
    next;
  }

  # jnz x y -> jumps to an instruction y away, but only if x is not zero
  if ( $instruction eq 'jnz' ) {
    $pointer = $pointer + ( register($args[0]) == 0 ? 1 : register($args[1]) );
    next;
  }

  # tgl x -> toggles the instruction x away
  if ( $instruction eq 'tgl' ) {
    my $target = $pointer++ + register( $args[0] );

    # If an attempt is made to toggle an instruction outside the program, nothing happens.
    next unless $target >= 0 && $target <= $#instructions;

    # For one-argument instructions, inc becomes dec, and all other one-argument instructions become inc.
    if ( $instructions[$target]->[0] eq 'inc' ) {
      $instructions[$target]->[0] = 'dec';
      next;
    }

    if ( $#{ $instructions[$target] } == 1 ) {
      $instructions[$target]->[0] = 'inc';
      next;
    }

    # For two-argument instructions, jnz becomes cpy, and all other two-instructions become jnz.
    if ( $instructions[$target]->[0] eq 'jnz' ) {
      $instructions[$target]->[0] = 'cpy';
      next;
    }

    if ( $#{ $instructions[$target] } == 2 ) {
      $instructions[$target]->[0] = 'jnz';
      next;
    }
  }

  die "Unknown instruction: `$instruction @args`";
}

say '';
say 'After:';
dd \@instructions, \%register;

sub register {  # get/set register value
  my ( $reg, $val ) = @_;

  return $reg unless exists $register{ $reg };  # register(1) or register(1, 2)

  $register{$reg} = register($val) if defined $val;  # register('a', 5) or register('a', 'b')

  return $register{$reg};
}
