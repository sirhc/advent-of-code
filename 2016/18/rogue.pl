#!/usr/bin/env perl

use v5.40;
use strict;
use Memoize;
no Smart::Comments;

memoize( 'get_row' );

### assert: not is_trap( '..^^.', 0 )
### assert:     is_trap( '..^^.', 1 )
### assert:     is_trap( '..^^.', 2 )
### assert:     is_trap( '..^^.', 3 )
### assert:     is_trap( '..^^.', 4 )

### assert: next_row('..^^.') eq '.^^^^';
### assert: next_row('.^^^^') eq '^^..^';

### assert: get_row( '..^^.', 1 ) eq '.^^^^';
### assert: get_row( '..^^.', 2 ) eq '^^..^';

### assert: get_row( '.^^.^.^^^^', 1 ) eq '^^^...^..^'
### assert: get_row( '.^^.^.^^^^', 2 ) eq '^.^^.^.^^.'
### assert: get_row( '.^^.^.^^^^', 3 ) eq '..^^...^^^'
### assert: get_row( '.^^.^.^^^^', 4 ) eq '.^^^^.^^.^'
### assert: get_row( '.^^.^.^^^^', 5 ) eq '^^..^.^^..'
### assert: get_row( '.^^.^.^^^^', 6 ) eq '^^^^..^^^.'
### assert: get_row( '.^^.^.^^^^', 7 ) eq '^..^^^^.^^'
### assert: get_row( '.^^.^.^^^^', 8 ) eq '.^^^..^.^^'
### assert: get_row( '.^^.^.^^^^', 9 ) eq '^^.^^^..^^'

my $rows  = shift // die 'missing number of rows';
my $input = <>; chomp $input;

say get_row( $input, $_ ) for 0 .. $rows - 1;

sub get_row {
  my ( $row, $num ) = @_;

  $row = next_row( $row ) for 1 .. $num;
  return $row;
}

sub next_row {
  my ( $row ) = @_;

  return join '', map { is_trap( $row, $_ ) ? '^' : '.' } 0 .. length($row) - 1;
}

sub is_trap {
  my ( $row, $pos ) = @_;

  my $segment = substr '.' . $row . '.', $pos, 3;
  return $segment eq '^^.' || $segment eq '.^^' || $segment eq '^..' || $segment eq '..^';
}
