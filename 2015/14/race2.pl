#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Printer;
use List::Util qw( max );

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

    fatigue  => 0,  # fatigue == stamina -> rest
    rest     => 0,  # rest == recovery -> fatigue resets
    distance => 0,
    score    => 0,
  };
}

while ( $time > 0 ) {
  # p $time;
  # p %reindeer;

  # Advance reindeer.
  for my $reindeer ( keys %reindeer ) {
    my $r = $reindeer{$reindeer};

    # If the reindeer isn't fatigued, advance them.
    if ( $r->{'fatigue'} < $r->{'stamina'} ) {
      $r->{'distance'} += $r->{'speed'};
      $r->{'fatigue'}++;
      next;
    }

    # Otherwise, the reindeer is resting.
    $r->{'rest'} += 1;

    # If the reindeer has now recovered, they can race again in the next second.
    if ( $r->{'rest'} >= $r->{'recovery'} ) {
      $r->{'fatigue'} = 0;
      $r->{'rest'} = 0;
    }
  }

  # Award a point to the leader(s).
  my $lead = max map { $reindeer{$_}{'distance'} } keys %reindeer;
  for my $leader ( grep { $reindeer{$_}{'distance'} == $lead } keys %reindeer ) {
    $reindeer{$leader}{'score'} += 1;
  }

  $time -= 1;
}

# p %reindeer;

say join ',', qw( Reindeer Distance Score );

for my $reindeer ( sort keys %reindeer ) {
  say join ',', $reindeer, map { $reindeer{$reindeer}{$_} } qw( distance score );
}
