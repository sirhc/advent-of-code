#!/usr/bin/env perl

use v5.40;
use strict;

process_machine($_) for map { chomp; parse_input($_) } <>;

sub parse_input {
  my ( $line ) = @_;

  my @tokens = split ' ', $line;
  my %record = ( line => $line, tokens => [ @tokens ] );

  $record{lights}   = substr $tokens[0], 1, -1;
  $record{buttons}  = [ map { [ split /,/, substr $tokens[$_], 1, -1 ] } 1 .. $#tokens - 1 ];
  $record{joltages} = [ split /,/, substr $tokens[-1], 1, -1 ];

  return { %record };
}

sub process_machine {
  my ( $machine ) = @_;

  my @queue = ( [ '.' x length $machine->{lights}, [] ] );
  my %seen  = ();

  while ( @queue ) {
    my ( $state, $presses ) = @{ shift @queue };

    next if $seen{ $state }++;

    if ( $state eq $machine->{lights} ) {
      print_sequence( $machine, $presses );
      return;
    }

    # There aren't any restrictions on which buttons we can press (at least in part one), so try each one.
    for my $button ( @{ $machine->{buttons} } ) {
      push @queue, [ toggle( $state, $button ) , [ @$presses, $button ] ];
    }
  }

  die 'We should never get here, because we can press buttons indefinitely';
}

sub toggle {
  my ( $display, $button ) = @_;

  substr($display, $_, 1) = substr($display, $_, 1) eq '#' ? '.' : '#' for @$button;

  return $display;
}

sub print_sequence {
  my ( $machine, $sequence ) = @_;

  say sprintf '%s : %d', $machine->{line}, scalar @$sequence;

  my $display = '.' x length $machine->{lights};
  for my $button ( @$sequence ) {
    $display = toggle( $display, $button );
    say sprintf '  %-21s → [%s]', ( '(' . ( join ',', @$button ) . ')' ), $display;
  }
}
