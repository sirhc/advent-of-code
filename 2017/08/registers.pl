#!/usr/bin/env perl

use v5.40;
use strict;

my @input = map { chomp; [ split ' ' ] } <>;  # e.g., b inc 5 if a > 1

my %register;
my %op = (
  'inc' => sub { $register{ $_[0] } += $_[1] },
  'dec' => sub { $register{ $_[0] } -= $_[1] },
  '=='  => sub { ( $register{ $_[0] } // 0 ) == $_[1] },
  '!='  => sub { ( $register{ $_[0] } // 0 ) != $_[1] },
  '>'   => sub { ( $register{ $_[0] } // 0 ) >  $_[1] },
  '>='  => sub { ( $register{ $_[0] } // 0 ) >= $_[1] },
  '<'   => sub { ( $register{ $_[0] } // 0 ) <  $_[1] },
  '<='  => sub { ( $register{ $_[0] } // 0 ) <= $_[1] },
);

while ( @input ) {
  my ( $instruction ) = shift @input;  # e.g., [ qw( b inc 5 if a > 1 ) ]
                                       #             0 1   2 3  4 5 6

  next unless $op{ $instruction->[5] }->( $instruction->[4], $instruction->[6] );
  $op{ $instruction->[1] }->( $instruction->[0], $instruction->[2] );
}

for my $reg ( sort { $register{$a} <=> $register{$b} } keys %register ) {
  say sprintf '%-3s %5d', $reg, $register{$reg};
}
