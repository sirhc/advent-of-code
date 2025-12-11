#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( sum );
use Memoize;

memoize('walk');

my ( $start, $end ) = ( shift // 'svr', shift // 'out' );
my %input = map { $_->[0] => [ split / /, $_->[1] ] } map { chomp; [ split /: / ] } <>;

say sprintf '%s -> %s : %d', $start, $end, walk( $start, 0, 0 );

sub walk {
  my ( $node, $dac, $fft ) = @_;

  return 1 if $node eq $end && $dac && $fft;
  return 0 if $node eq $end;

  $dac = 1 if $node eq 'dac';
  $fft = 1 if $node eq 'fft';

  return sum map { walk( $_, $dac, $fft ) } @{ $input{$node} };
}
