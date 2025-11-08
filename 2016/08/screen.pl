#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

# my ( $width, $height ) = ( 7, 3 );  # example
my ( $width, $height ) = ( 50, 6 );  # puzzle

my ( $lit, $unlit ) = ( '*', ' ' );

my @screen      = map { [ ( $unlit ) x $width ] } 1 .. $height;
my @operations  = <>;
#dd [ \@screen, \@operations ];

print_screen( @screen );

for my $operation ( @operations ) {
  print "Operation: $operation";

  if ( $operation =~ /^rect (\d+)x(\d+)/ ) {
    op_rect( \@screen, $1, $2 );
    print_screen( @screen );
    next;
  }

  if ( $operation =~ /^rotate row y=(\d+) by (\d+)/ ) {
    op_rotate_row( \@screen, $1, $2 );
    print_screen( @screen );
    next;
  }

  if ( $operation =~ /^rotate column x=(\d+) by (\d+)/ ) {
    op_rotate_column( \@screen, $1, $2 );
    print_screen( @screen );
    next;
  }
}

sub op_rect {
  my ( $screen, $w, $h ) = @_;

  for my $y ( 0 .. $h - 1 ) {
    for my $x ( 0 .. $w - 1 ) {
      $screen->[$y][$x] = $lit if defined $screen->[$y][$x];
    }
  }
}

sub op_rotate_row {
  my ( $screen, $y, $by ) = @_;

  my @new_row = map { $unlit } 0 .. $width - 1;

  for my $x ( 0 .. $width - 1 ) {
    my $new_x = ( $x + $by ) % $width;
    $new_row[$new_x] = $screen->[$y][$x];
  }

  $screen->[$y] = [ @new_row ];
}

sub op_rotate_column {
  my ( $screen, $x, $by ) = @_;

  my @new_col = map { $unlit } 0 .. $height - 1;

  for my $y ( 0 .. $height - 1 ) {
    my $new_y = ( $y + $by ) % $height;
    $new_col[$new_y] = $screen->[$y][$x];
  }

  for my $y ( 0 .. $height - 1 ) {
    $screen->[$y][$x] = $new_col[$y];
  }
}

sub print_screen {
  my @screen = @_;

  say 'Screen:';
  say join "\n", map { join '', @$_ } @screen;
  say '';
  say 'Lit pixels: ', scalar grep { $_ eq $lit } map { @$_ } @screen;
  say '';
}
