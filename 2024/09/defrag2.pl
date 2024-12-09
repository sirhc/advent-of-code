#!/usr/bin/env perl

use v5.40;
use strict;

use List::Util qw( first min sum );
use Data::Dump;

# I'm changing the representation of the file system a little, to make it easier to work with part two. By using the
# same "data structure" for free space and files, instead of simply a number for free space, it should be easier to drop
# files into the free space.

my @fs = do {
  my $file = 0;
  my $id   = 0;

  map { $file = !$file; $file ? [ $id++, $_ ] : [ undef, $_ ] } map { split // } split /\n/, do { local $/; <> };
};

# Select the right-most file to start with. Conveniently, all of our input and examples end with a file.
my $file = $#fs;

# If the last block is a file, add zero space to the end, which we'll use later to keep track of free space.
# push @fs, [ undef, 0 ] if defined $fs[-1][0];

# Keep track of the current block of space we're trying to fill, so we don't have to keep scanning the list.
# my $fill = first { !ref $fs[$_] } ( 1 .. $#fs );

# dd @fs;
# print_map();

sub print_map {
  # Printing the map is only useful for the examples. Only print the first digit of the file id, to keep thing from
  # getting out of hand.
  say map { defined $_->[0] ? ( substr "$_->[0]", 0, 1 ) x $_->[1] : '.' x $_->[1] } @fs;
}

while ( $file > 0 ) {
  my ( $id, $size ) = @{ $fs[$file] };
  # dd { file => $file, id => $id, size => $size };

  # Find the first index to the left of the file that has enough space to store it.
  my $space = first { ! defined $fs[$_][0] && $fs[$_][1] >= $size } 1 .. $file - 1;
  # dd { space => $space };

  # We didn't find space. Move on to the next file.
  if ( ! defined $space ) {
    $file -= 2;
    next;
  }

  # Insert the file into the space we found, dropping a zero-length space block to the left to preserve our assumption
  # that every other block is a file.
  splice @fs, $space, 0, [ undef, 0 ], [ $id, $size ];

  # Reduce the space available in the block we used.
  $fs[$space + 2][1] -= $size;

  # Finally, clear out the file we moved.
  $fs[$file + 2][0] = undef;

  # We don't need to update the file index, because we effectively shifted the list under it to its right. So it's
  # automatically at the correct position.

  # dd @fs;
  # print_map();
}

sub checksum {
  my $sum = 0;
  my $i   = 0;

  for my $block ( @fs ) {
    if ( ! defined $block->[0] ) {
      $i += $block->[1];
      next;
    }

    # dd { block => $block, range => [ $i .. $i + $block->[1] - 1 ] };

    $sum += sum map { $_ * $block->[0] } ( $i .. $i + $block->[1] - 1 );
    $i += $block->[1];
  }

  return $sum;
}

# dd @fs;
say checksum();
