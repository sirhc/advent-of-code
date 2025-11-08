#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

my %register = ( a => 0, b => 0 );

# instruction->( [0]pointer, [1...]instruction )
my %instruction = (
  hlf => sub { $register{$_[2]} = int( $register{$_[2]} / 2 ); $_[0] += 1 },
  tpl => sub { $register{$_[2]} *= 3;                          $_[0] += 1 },
  inc => sub { $register{$_[2]} += 1;                          $_[0] += 1 },
  jmp => sub { $_[0] += $_[2] },
  jie => sub { $_[0] += ( $register{$_[2]} % 2 == 0 ) ? $_[3] : 1 },
  jio => sub { $_[0] += ( $register{$_[2]}     == 1 ) ? $_[3] : 1 },
);

my @program = map { [ split ] } map { s/,//r } <>;  # jio a, +2; jmp +22
my $pointer = 0;

dd { program => \@program };

while ( 1 ) {
  dd { instruction => $program[$pointer], pointer => $pointer, registers => \%register };

  last if ( $pointer < 0 || $pointer > $#program );
  $instruction{ $program[$pointer][0] }->( $pointer, @{ $program[$pointer] } );
}

dd { registers => \%register };
