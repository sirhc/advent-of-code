#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

# ########
# #..O.O.#
# ##@.O..#
# #...O..#
# #.#.O..#
# #...O..#
# #......#
# ########
#
# <^^>>>vv<v>>v<<

my @map;
my @moves;
my $robot;  # [ $row, $col ]

my %dir = (
  '^' => [ -1,  0, \&move_vertical   ],  # up
  'v' => [  1,  0, \&move_vertical   ],  # down
  '<' => [  0, -1, \&move_horizontal ],  # left
  '>' => [  0,  1, \&move_horizontal ],  # right
);

while ( my $line = <> ) {
  chomp $line;
  last if $line eq '';
  push @map, [ map { $_ eq '@' ? qw( @ . ) : $_ eq 'O' ? qw( [ ] ) : ( $_, $_ ) } split //, $line ];

  # Find the robot.
  my ( $col ) = grep { $map[$#map][$_] eq '@' } 0 .. $#{ $map[ $#map ] };
  $robot = [ $#map, $col ] if defined $col;
}

@moves = map { split // } split /\n/, do { local $/; <> };

# dd { map => \@map, moves => \@moves, robot => $robot };
print_map('Initial state:');

for my $move ( @moves ) {
  # dd { move => $move, robot => $robot };
  @$robot = $dir{ $move }[2]->( @$robot, $move );
  # dd { move => $move, robot => $robot };

  # print_map("Move $move:");
}

print_map('Final state:');

my $sum = 0;

for my $row ( 0 .. $#map ) {
  for my $col ( 0 .. $#{ $map[$row] } ) {
    next unless $map[ $row ][ $col ] eq '[';
    $sum += 100 * $row + $col;
  }
}

say $sum;

sub move_horizontal {
  my ( $row, $col, $move ) = @_;

  my ( $nrow, $ncol ) = ( $row + $dir{ $move }[0], $col + $dir{ $move }[1] );

  if ( $map[ $nrow ][ $ncol ] eq '[' || $map[ $nrow ][ $ncol ] eq ']' ) {
    move_horizontal( $nrow, $ncol, $move );
  }

  if ( $map[ $nrow ][ $ncol ] eq '#' ) {
    return ( $row, $col );
  }

  if ( $map[ $nrow ][ $ncol ] eq '.' ) {
    $map[ $nrow ][ $ncol ] = $map[ $row ][ $col ];
    $map[ $row ][ $col ] = '.';
    return ( $nrow, $ncol );
  }

  return ( $row, $col );
}

sub is_blocked {
  my ( $row, $col, $move ) = @_;

  my ( $nrow, $ncol ) = ( $row + $dir{ $move }[0], $col + $dir{ $move }[1] );

  if ( $map[ $row ][ $col ] eq '@' && $map[ $nrow ][ $ncol ] eq '#') {
    return 1;
  }

  if ( $map[ $row ][ $col ] eq '[' ) {
    if ( $map[ $nrow ][ $ncol ] eq '#' || $map[ $nrow ][ $ncol + 1 ] eq '#' ) {
      return 1;
    }

    return is_blocked( $nrow, $ncol, $move ) || is_blocked( $nrow, $ncol + 1, $move );
  }

  if ( $map[ $row ][ $col ] eq ']' ) {
    if ( $map[ $nrow ][ $ncol ] eq '#' || $map[ $nrow ][ $ncol - 1 ] eq '#' ) {
      return 1;
    }

    return is_blocked( $nrow, $ncol, $move ) || is_blocked( $nrow, $ncol - 1, $move );
  }

  return 0;
}

sub move_vertical {
  my ( $row, $col, $move ) = @_;

  return ( $row, $col ) if is_blocked( $row, $col, $move );

  my ( $nrow, $ncol ) = ( $row + $dir{ $move }[0], $col + $dir{ $move }[1] );

  if ( $map[ $row ][ $col ] eq '@' ) {
    move_vertical( $nrow, $ncol, $move );
  }

  if ( $map[ $row ][ $col ] eq '[' ) {
    move_vertical( $nrow, $ncol, $move );
    move_vertical( $nrow, $ncol + 1, $move );
  }

  if ( $map[ $row ][ $col ] eq ']' ) {
    move_vertical( $nrow, $ncol, $move );
    move_vertical( $nrow, $ncol - 1, $move );
  }

  if ( $map[ $row ][ $col ] eq '[' && ( $map[ $nrow ][ $ncol ] eq '#' || $map[ $nrow ][ $ncol + 1 ] eq '#' ) ) {
    return ( $row, $col );
  }

  if ( $map[ $row ][ $col ] eq ']' && ( $map[ $nrow ][ $ncol ] eq '#' || $map[ $nrow ][ $ncol - 1 ] eq '#' ) ) {
    return ( $row, $col );
  }

  if ( $map[ $row ][ $col ] eq '@' && $map[ $nrow ][ $ncol ] eq '.' ) {
    $map[ $nrow ][ $ncol ] = '@';
    $map[ $row ][ $col ] = '.';

    return ( $nrow, $ncol );
  }

  if ( $map[ $row ][ $col ] eq '[' && $map[ $nrow ][ $ncol ] eq '.' && $map[ $nrow ][ $ncol + 1 ] eq '.' ) {
    $map[ $nrow ][ $ncol     ] = '[';
    $map[ $nrow ][ $ncol + 1 ] = ']';

    $map[ $row ][ $col     ] = '.';
    $map[ $row ][ $col + 1 ] = '.';

    return ( $nrow, $ncol );
  }

  if ( $map[ $row ][ $col ] eq ']' && $map[ $nrow ][ $ncol ] eq '.' && $map[ $nrow ][ $ncol - 1 ] eq '.' ) {
    $map[ $nrow ][ $ncol - 1 ] = '[';
    $map[ $nrow ][ $ncol     ] = ']';

    $map[ $row ][ $col - 1 ] = '.';
    $map[ $row ][ $col     ] = '.';

    return ( $nrow, $ncol );
  }

  return ( $row, $col );
}

sub print_map {
  say $_[0];
  say join '', @$_ for @map;
  say '';
}
