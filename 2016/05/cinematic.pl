#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;
use Digest::MD5 qw( md5_hex );

my ( $door ) = map { chomp; $_ } <>;
my @chars    = map { chr } ( 33 .. 126 );
my @password = map { [ 0, '', '*' ] } ( 1 .. 8 );
my $index    = 0;

say "Door: $door";
print_password();

while ( 1 ) {
  my $hash = md5_hex($door . $index);
  $password[ $1 ] = [ $index, $hash, $2 ] if $hash =~ /^00000([0-7])(.)/ && $password[ $1 ]->[2] eq '*';

  print_password() if rand() > 0.9;

  last unless grep { $_->[2] eq '*' } @password;
  $index += 1;
}

print_password();
say '';
dd \@password;

sub print_password {
  print "\rPassword: ", join( ' ', map { $_->[2] eq '*' ? $chars[ int rand @chars ] : $_->[2] } @password ), sprintf ' [%9d]', $index;
}
