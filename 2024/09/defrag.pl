#!/usr/bin/env perl

use v5.40;
use strict;

use List::Util qw( first min sum );
use Data::Dump;

my $file = 0;
my $id   = 0;
my @fs   = map { $file = !$file; $file ? [ $id++, $_ ] : $_ } map { split // } split /\n/, do { local $/; <> };

# If the last block is a file, add zero space to the end, which we'll use later to keep track of free space.
push @fs, 0 if ref $fs[-1];

# Keep track of the current block of space we're trying to fill, so we don't have to keep scanning the list.
my $fill = first { !ref $fs[$_] } ( 1 .. $#fs );

# dd @fs;

sub print_map {
  # Printing the map is only useful for the examples. Only print the first digit of the file id, to keep thing from
  # getting out of hand.
  say map { ref $_ ? ( substr "$_->[0]", 0, 1 ) x $_->[1] : '.' x $_ } @fs;
}

# print_map();

while ( $fill < $#fs ) {
  # dd at => $fill, space => $fs[$fill];

  # If there's no space available in the current block, jump to the next one.
  if ( $fs[$fill] == 0 ) {
    $fill += 2;
    next;
  }

  # Grab some of the file from the end, which will always be the second-to-last element in the list. The instructions
  # said one block at a time, but we're taking a shortcut.
  my ( $id, $size ) = ( $fs[-2][0], min $fs[$fill], $fs[-2][1] );
  # dd id => $id, size => $size;

  # If the file from the end of the list is the same as the one to our left, add to it. Otherwise, insert a new record.
  # We could add a zero-length space block, but it shouldn't matter.
  if ( $fs[$fill - 1][0] == $id ) {
    $fs[$fill - 1][1] += $size;
  } else {
    splice @fs, $fill, 0, [ $id, $size ];
    $fill += 1;
  }

  # Reduce the space available in the current block.
  $fs[$fill] -= $size;

  # Reduce the file size we took from the end of the list, adding it to the space at the end.
  $fs[-2][1] -= $size;
  $fs[-1]    += $size;

  # If we've used up the entire file at the end, remove it and merge the trailing space blocks.
  if ( $fs[-2][1] <= 0 ) {
    my ( $tail1, undef, $tail2 ) = splice @fs, -3;
    push @fs, $tail1 + $tail2;
    # dd tail1 => $tail1, tail2 => $tail2;
  }

  # dd @fs;
  # print_map();
}

sub checksum {
  my $sum = 0;
  my $i   = 0;

  for my $block ( @fs ) {
    next unless ref $block;
    # dd block => $block;
    # dd range => ( $i .. $i + $block->[1] - 1 );

    $sum += sum map { $_ * $block->[0] } ( $i .. $i + $block->[1] - 1 );
    $i += $block->[1];
  }

  return $sum;
}

say checksum();
