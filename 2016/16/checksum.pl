#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( pairmap );
use Smart::Comments;

my $length = shift // die 'missing length';
my $input  = shift // die 'missing input';

### assert: dragon_curve('1') eq '100'
### assert: dragon_curve('0') eq '001'
### assert: dragon_curve('11111') eq '11111000000'
### assert: dragon_curve('111100001010') eq '1111000010100101011110000'

### assert: checksum('110010110100') eq '100'
### assert: checksum('110010110100') eq '100'

### assert: checksum2('10000011110010000111') eq '01100'
### assert: checksum2('10000011110010000111') eq '01100'

while ( length $input < $length ) {
  $input = dragon_curve($input);
}

say substr $input, 0, $length;
# say checksum( substr $input, 0, $length );  # oh, you got me and my suboptimal solution, part two
say checksum2( substr $input, 0, $length );

sub dragon_curve {
  my ( $data ) = @_;

  my $atad = reverse $data;
  $atad =~ tr/01/10/;
  return $data . '0' . $atad;
}

sub checksum {
  my ( $data ) = @_;

  my $sum = join '', map { $_->[0] == $_->[1] ? 1 : 0 } map { [ split // ] } unpack "(A2)*", $data;

  return $sum if length($sum) % 2 == 1;
  return checksum($sum);
}

sub checksum2 {
  my ( $data ) = @_;

  my @data = split //, $data;

  while ( scalar @data % 2 == 0 ) {
    @data = pairmap { $a eq $b ? '1' : '0' } @data;
  }

  return join '', @data;
}
