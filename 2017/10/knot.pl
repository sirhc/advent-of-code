#!/usr/bin/env perl

use v5.40;
use strict;

my $size  = shift // die 'missing list size';
my @input = map { chomp; split /,/ } <>;
my @list  = ( 0 .. $size - 1 );
my $skip  = 0;
my $i     = 0;

while ( @input ) {
  my $length = shift @input;

  if ( $i + $length > @list ) {
    my $overflow = $i + $length - @list;
    my @segment  = reverse @list[ $i .. $#list ], @list[ 0 .. $overflow - 1 ];

    splice @list, 0, $overflow, @segment[ @segment - $overflow .. $#segment ];
    splice @list, $i, @list - $i, @segment[ 0 .. @segment - $overflow - 1 ];
  }
  else {
    splice @list, $i, $length, reverse @list[ $i .. $i + $length - 1 ];
  }

  $i = ( $i + $length + $skip++ ) % @list;
}

say "$list[0] * $list[1] = ", $list[0] * $list[1];
