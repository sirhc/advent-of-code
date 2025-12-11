#!/usr/bin/env perl

use v5.40;
use strict;
use IPC::Open2;
use IPC::Run qw( run );
use List::MoreUtils qw( pairwise );

process_machine($_) for map { chomp; parse_input($_) } <>;

sub parse_input {
  my ( $line ) = @_;

  my @tokens = split ' ', $line;
  my %record = ( line => $line, tokens => [ @tokens ] );

  $record{lights}  = substr $tokens[0], 1, -1;
  $record{buttons} = [ map { [ split /,/, substr $tokens[$_], 1, -1 ] } 1 .. $#tokens - 1 ];
  $record{joltage} = [ split /,/, substr $tokens[-1], 1, -1 ];

  return { %record };
}

sub process_machine {
  my ( $machine ) = @_;

  my ( $in, $out, $err ) = ( lp_input($machine) );
  # print $in;

  run [ 'lp_solve' ], \$in, \$out, \$err;
  # print $out;

  say sprintf '%s : %d', $machine->{line}, $out =~ /Value of objective function: (\d+)/;
  while ( $out =~ /^x(\d+)\s+(\d+)/msg ) {
    say sprintf '  %-21s → %d', ( '(' . ( join ',', @{ $machine->{buttons}->[$1] } ) . ')' ), $2;
  }
}

sub lp_input {
  my ( $machine ) = @_;

  my @v = map { "x$_" } 0 .. $#{ $machine->{buttons} };
  my $input = sprintf "min: %s;\n", join ' + ', @v;

  for my $j ( 0 .. $#{ $machine->{joltage} } ) {
    my @c = map { ( grep { $_ == $j } @{ $machine->{buttons}->[$_] } ) ? 1 : 0 } 0 .. $#v;
    $input .= sprintf "%s = %d;\n",
      ( join ' + ', pairwise { join ' ', $a, $b } @c, @v ),
      $machine->{joltage}->[$j];
  }
  $input .= sprintf "int %s;\n", $_ for @v;

  return $input;
}
