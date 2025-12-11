#!/usr/bin/env perl

use v5.40;
use strict;

my ( $start, $end ) = ( shift // 'svr', shift // 'out' );
my %input = map { $_->[0] => [ split / /, $_->[1] ] } map { chomp; [ split /: / ] } <>;
my @queue = ( [ $start, [ $start ] ] );

while ( @queue ) {
  my ( $node, $path ) = @{ shift @queue };

  for my $next ( @{ $input{ $node } } ) {
    next if $next eq $start;

    if ( $next eq $end ) {
      say join ',', @{ $path }, $end;
      next;
    }

    push @queue, [ $next, [ @{ $path }, $next ] ];
  }
}
