#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;
use Digest::MD5 qw( md5_hex );

# md5_hex('abc3231929') eq '00000155f8105dff7f56ee10fa9b9abd';
# md5_hex('abc5017308') eq '000008f82c5b3924a1ecbebf60344e00';
# md5_hex('abc5278568') eq '00000f9a2c309875e05c5a5d09f1b8c4';

my ( $door ) = map { chomp; $_ } <>;
say "Door: $door";

my @password = ();
my $index    = 0;

print_password();

while ( 1 ) {
  my $hash = md5_hex($door . $index);
  push @password, [ $index, $hash, $1 ] if $hash =~ /^00000(.)/;

  print_password() if rand() > 0.9;

  last if scalar @password == 8;
  $index += 1;
}

print_password();
say '';
dd \@password;

sub print_password {
  print "\rPassword: ", join( ' ', ( map { $_->[2] } @password ), map { '*' } 1 .. 8 - scalar @password ), sprintf ' [%9d]', $index;
}
