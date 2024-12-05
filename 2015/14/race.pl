#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Printer;
use List::Util qw( reduce );

my $time = 2503;
my %reindeer;

while ( my $line = <> ) {
  chomp $line;

  # Vixen can fly 8 km/s for 8 seconds, but then must rest for 53 seconds.
  $line =~ m{^(\S+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds};

  $reindeer{$1} = {
    speed    => $2,
    stamina  => $3,
    recovery => $4,

    remaining_time  => $time,
    distance        => 0,
    resting         => 0,
  };
}

# p %reindeer;

for my $reindeer ( sort keys %reindeer ) {
  my $r = $reindeer{$reindeer};

  # say 'Reindeer: ', $reindeer;

  while ( $r->{'remaining_time'} > 0 ) {
    if ( $r->{'resting'} ) {
      $r->{'remaining_time'} -= $r->{'recovery'};
    } else {
      # Doesn't matter how much stamina they have if they're out of time.
      $r->{'distance'} += $r->{'speed'} * ( $r->{'stamina'} < $r->{'remaining_time'} ? $r->{'stamina'} : $r->{'remaining_time'} );
      $r->{'remaining_time'} -= $r->{'stamina'};
    }
    $r->{'resting'} = !$r->{'resting'};

    # say '  Distance Traveled: ', $r->{'distance'};
    # say '  Time Remaining:    ', $r->{'remaining_time'};
  }
}

# p %reindeer;

my $winner = reduce { $reindeer{$a}{'distance'} > $reindeer{$b}{'distance'} ? $a : $b } keys %reindeer;

say $winner, ' ', $reindeer{$winner}{'distance'};
