#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

#                                     0                             1              2    3
# "aaaaa-bbb-z-y-x-123[abxyz]\n" => [ "aaaaa-bbb-z-y-x-123[abxyz]", "aaaaabbbzyx", 123, "abxyz" ]
my @rooms = map { $_->[1] =~ s/[-]//g; $_ }
            map { [ $_, m/^([[:alpha:]-]+)(\d+)\[(\w+)/ ] }
            map { chomp; $_ }
            <>;
# dd \@rooms;

for my $room ( @rooms ) {
  say sprintf 'Room %s is %svalid.', $room->[0], is_valid( $room->[1], $room->[3] ) ? '' : 'NOT ';
}

sub is_valid {
  my ( $name, $checksum ) = @_;

  my %count;
  do { $count{$_}++ } for split //, $name;

  return $checksum eq substr +( join '', sort { $count{$b} <=> $count{$a} || $a cmp $b } keys %count ), 0, 5;
}
