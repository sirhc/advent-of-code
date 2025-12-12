#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( sum );

my ( $shapes, $regions ) = process_input( [ map { chomp; $_ } <> ] );

for my $region ( @$regions ) {
  my $area = sum map { $region->{presents}->[$_] * $shapes->[$_]->{area} } 0 .. $#{ $region->{presents} };

  say sprintf '%dx%d: area: %d (%s = %d) => %s',
    $region->{width},
    $region->{height},
    $region->{area},
    ( join ' + ', map { "$region->{presents}->[$_]*$shapes->[$_]->{area}" } 0 .. $#{ $region->{presents} } ),
    $area,
    ( $area <= $region->{area} ? 'good' : 'bad' );
}

sub process_input {
  my ( $lines ) = @_;

  my @shapes;
  my @regions;

  my $shape;
  my $area;

  while ( @$lines ) {
    my $line = shift @$lines;

    next if $line eq '';

    if ( $line =~ /^(\d+):/ ) {
      push @shapes, { area => 0, shape => [] };
      $shape = $1;
      $area = 0;
      next;
    }

    if ( $line =~ /[#.]/ ) {
      push @{ $shapes[$shape]->{shape} }, [ split //, $line ];
      $shapes[$shape]->{area} += sum map { $_ eq '#' ? 1 : 0 } @{ $shapes[$shape]->{shape}->[-1] };
      next;
    }

    if ( $line =~ /^(\d+)x(\d+): ([ \d]+)/ ) {
      push @regions, {
        width    => $1,
        height   => $2,
        area     => $1 * $2,
        presents => [ split / /, $3 ],
      };
      next;
    }

    die "Invalid input: `$line`";
  }

  return ( \@shapes, \@regions );;
}
