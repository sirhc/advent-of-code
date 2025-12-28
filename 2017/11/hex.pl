#!/usr/bin/env perl

use v5.40;
use strict;

my @input = map { chomp; split /,/ } <>;
my $modified;

do {
  $modified = 0;

  for ( my $i = 0; $i < $#input; $i++ ) {
    for ( my $j = $i + 1; $j <= $#input; $j++ ) {
      my $combined = combine( $input[$i], $input[$j] );

      if ( $input[$i] ne $combined ) {
        splice @input, $j, 1;
        $modified = 1;
      }

      $input[$i] = $combined;
    }
  }
} until ( !$modified );

@input = grep { $_ ne '' } @input;

say scalar @input;

sub combine {
  my ( $a, $b ) = @_;

  # Various backtracks.
  return '' if ( $a eq 'n'  && $b eq 's' )
            || ( $a eq 's'  && $b eq 'n' )
            || ( $a eq 'ne' && $b eq 'sw' )
            || ( $a eq 'sw' && $b eq 'ne' )
            || ( $a eq 'nw' && $b eq 'se' )
            || ( $a eq 'se' && $b eq 'nw' );

  return 'n' if ( $a eq 'ne' && $b eq 'nw' ) || ( $a eq 'nw' && $b eq 'ne' );
  return 's' if ( $a eq 'se' && $b eq 'sw' ) || ( $a eq 'sw' && $b eq 'se' );

  return 'ne' if ( $a eq 'n' && $b eq 'se' ) || ( $a eq 'se' && $b eq 'n' );
  return 'nw' if ( $a eq 'n' && $b eq 'sw' ) || ( $a eq 'sw' && $b eq 'n' );
  return 'se' if ( $a eq 's' && $b eq 'ne' ) || ( $a eq 'ne' && $b eq 's' );
  return 'sw' if ( $a eq 's' && $b eq 'nw' ) || ( $a eq 'nw' && $b eq 's' );

  return $a;
}
