#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( reduce );

my @input = ( ( map { ord } map { chomp; split // } <> ), 17, 31, 73, 47, 23 );
my @list  = ( 0 .. 255 );
my $skip  = 0;
my $pos   = 0;

for ( 1 .. 64 ) {
  for my $length ( @input ) {
    if ( $pos + $length > @list ) {
      my $overflow = $pos + $length - @list;
      my @segment  = reverse @list[ $pos .. $#list ], @list[ 0 .. $overflow - 1 ];

      splice @list, 0, $overflow, @segment[ @segment - $overflow .. $#segment ];
      splice @list, $pos, @list - $pos, @segment[ 0 .. @segment - $overflow - 1 ];
    }
    else {
      splice @list, $pos, $length, reverse @list[ $pos .. $pos + $length - 1 ];
    }

    $pos = ( $pos + $length + $skip++ ) % @list;
  }
}

while ( @list ) {
  printf '%0.2x', reduce { $a ^ $b } splice @list, 0, 16;
}
print "\n";
