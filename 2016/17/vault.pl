#!/usr/bin/env perl

use v5.40;
use strict;
use Digest::MD5 qw( md5_hex );
use List::Util qw( max reduce );
no Smart::Comments;

my $input = shift // die 'missing input';

my %moves = (                                      # +-----------------+
  U => sub { [ $_[0]->[0],    $_[0]->[1] - 1 ] },  # | 0,0 1,0 2,0 3,0 |
  D => sub { [ $_[0]->[0],    $_[0]->[1] + 1 ] },  # | 0,1 1,1 2,1 3,1 |
  L => sub { [ $_[0]->[0] -1, $_[0]->[1]     ] },  # | 0,2 1,2 2,2 3,2 |
  R => sub { [ $_[0]->[0] +1, $_[0]->[1]     ] },  # | 0,3 1,3 2,3 3,3 |
);                                                 # +-----------------+

### assert: !defined wander('hijkl')
### assert: wander('ihgpwlah') eq 'DDRRRD'
### assert: wander('kglvqrro') eq 'DDUDRLRRUDRD'
### assert: wander('ulqzkmiv') eq 'DRURDRUDDLLDLUURRDULRLDUUDDDRR'

### assert: longest('hijkl') == 0
### assert: longest('ihgpwlah') == 370
### assert: longest('kglvqrro') == 492
### assert: longest('ulqzkmiv') == 830

say wander($input);
say longest($input);

sub longest {
  my ( $input ) = @_;
  return ( max map { length $_ } paths($input) ) // 0;
}

sub wander {
  my ( $input ) = @_;
  return reduce { length $a <= length $b ? $a : $b } paths($input);
}

sub paths {
  my ( $input ) = @_;

  my @queue = ( [ [ 0, 0 ], '' ] );
  my @paths = ();

  while ( @queue ) {
    my ( $position, $path ) = @{ shift @queue };

    if ( $position->[0] == 3 && $position->[1] == 3 ) {
      push @paths, $path;
      next;
    }

    my $h = md5_hex( $input . $path );
    my @d = map { substr( $h, $_, 1 ) =~ /[b-f]/ ? 1 : 0 } ( 0 .. 3 );

    for my $pair ( [ 'U', $d[0] ], [ 'D', $d[1] ], [ 'L', $d[2] ], [ 'R', $d[3] ] ) {
      my ( $dir, $open ) = @$pair;

      my $next = $moves{$dir}->( $position );
      next unless $open && $next->[0] >= 0 && $next->[0] <= 3 && $next->[1] >= 0 && $next->[1] <= 3;

      push @queue, [ $next, $path . $dir ];
    }
  }

  return @paths;
}
