#!/usr/bin/env perl

use v5.40;
use strict;
use Digest::MD5 qw( md5_hex );
no Smart::Comments;

my $input = shift // die 'missing input';
my $start = [ 0, 0 ];
my $vault = [ 3, 3 ];

my %moves = (       # +-----------------+
  U => [  0, -1 ],  # | 0,0 1,0 2,0 3,0 |
  D => [  0,  1 ],  # | 0,1 1,1 2,1 3,1 |
  L => [ -1,  0 ],  # | 0,2 1,2 2,2 3,2 |
  R => [  1,  0 ],  # | 0,3 1,3 2,3 3,3 |
);                  # +-----------------+

### assert: wander('hijkl') eq ''
### assert: wander('ihgpwlah') eq 'DDRRRD'
### assert: wander('kglvqrro') eq 'DDUDRLRRUDRD'
### assert: wander('ulqzkmiv') eq 'DRURDRUDDLLDLUURRDULRLDUUDDDRR'

say wander($input);

sub wander {
  my ( $input ) = @_;

  my @queue = ( [ $start, '' ] );

  while ( @queue ) {
    my ( $position, $path ) = @{ shift @queue };

    if ( $position->[0] == $vault->[0] && $position->[1] == $vault->[1] ) {
      return $path;
    }

    my $h = md5_hex( $input . $path );
    my @d = map { substr( $h, $_, 1 ) =~ /[b-f]/ ? 1 : 0 } ( 0 .. 3 );

    for my $pair ( [ 'U', $d[0] ], [ 'D', $d[1] ], [ 'L', $d[2] ], [ 'R', $d[3] ] ) {
      my ( $dir, $open ) = @$pair;

      my $next_position = [ $position->[0] + $moves{$dir}->[0], $position->[1] + $moves{$dir}->[1] ];

      next unless $open
        && $next_position->[0] >= 0
        && $next_position->[0] <= $vault->[0]
        && $next_position->[1] >= 0
        && $next_position->[1] <= $vault->[1];

      push @queue, [ $next_position, $path . $dir ];
    }
  }

  return '';
}
