#!/usr/bin/env perl

use v5.40;
use strict;

use Algorithm::Combinatorics qw( combinations );
use List::Util qw( sum );
use POSIX qw(ceil);
use Data::Dump;

my %player = (
  'Hit Points' => 100,
  'Damage'     => 0,
  'Armor'      => 0,
);
my %boss;

# There are 660 possible combinations of weapons, armor, and rings.
my %shop = (
  Weapons => [
    [ 'Dagger',     { Cost =>   8, Damage => 4, Armor => 0 } ],
    [ 'Shortsword', { Cost =>  10, Damage => 5, Armor => 0 } ],
    [ 'Warhammer',  { Cost =>  25, Damage => 6, Armor => 0 } ],
    [ 'Longsword',  { Cost =>  40, Damage => 7, Armor => 0 } ],
    [ 'Greataxe',   { Cost =>  74, Damage => 8, Armor => 0 } ],
  ],

  Armor => [
    [ 'None',       { Cost =>   0, Damage => 0, Armor => 0 } ],
    [ 'Leather',    { Cost =>  13, Damage => 0, Armor => 1 } ],
    [ 'Chainmail',  { Cost =>  31, Damage => 0, Armor => 2 } ],
    [ 'Splintmail', { Cost =>  53, Damage => 0, Armor => 3 } ],
    [ 'Bandedmail', { Cost =>  75, Damage => 0, Armor => 4 } ],
    [ 'Platemail',  { Cost => 102, Damage => 0, Armor => 5 } ],
  ],

  Rings => [
    [ 'Damage +1',  { Cost =>  25, Damage => 1, Armor => 0 } ],
    [ 'Damage +2',  { Cost =>  50, Damage => 2, Armor => 0 } ],
    [ 'Damage +3',  { Cost => 100, Damage => 3, Armor => 0 } ],
    [ 'Defense +1', { Cost =>  20, Damage => 0, Armor => 1 } ],
    [ 'Defense +2', { Cost =>  40, Damage => 0, Armor => 2 } ],
    [ 'Defense +3', { Cost =>  80, Damage => 0, Armor => 3 } ],
  ],
);

while ( my $line = <> ) {
  chomp $line;

  # Hit Points: 104
  $line =~ m/^([^:]+): (\d+)/;
  $boss{$1} = $2;
}

# dd { shop => \%shop, player => \%player, boss => \%boss };

say join ',', qw( Weapon Armor Ring1 Ring2 Cost DamageStat ArmorStat Winner );

for my $weapon ( @{ $shop{'Weapons'} } ) {
  for my $armor ( @{ $shop{'Armor'} } ) {
    for my $rings ( combinations( $shop{'Rings'}, 0 ), combinations( $shop{'Rings'}, 1 ), combinations( $shop{'Rings'}, 2 ) ) {
      my @equipment = ( $weapon, $armor, @$rings );

      $player{'Damage'} = sum map { $_->[1]{'Damage'} } @equipment;
      $player{'Armor'}  = sum map { $_->[1]{'Armor'}  } @equipment;

      # dd { player => $player, boss => $boss, equipment => \@equipment };

      printf '%s,', $weapon->[0];
      printf '%s,', $armor->[0];
      printf '%s,', exists $rings->[0] ? $rings->[0][0] : '';
      printf '%s,', exists $rings->[1] ? $rings->[1][0] : '';
      printf '%d,', sum map { $_->[1]{'Cost'} } @equipment;
      printf '%d,', $player{'Damage'};
      printf '%d,', $player{'Armor'};
      printf '%s Wins',
        $boss{'Damage'} - $player{'Armor'} <= 0 && $player{'Damage'} - $boss{'Armor'} <= 0 ? 'No One' :
        $boss{'Damage'} - $player{'Armor'} <= 0                                            ? 'Player' :
        $player{'Damage'} - $boss{'Armor'} <= 0                                            ? 'Boss'   :
        ceil( $boss{'Hit Points'} / ( $player{'Damage'} - $boss{'Armor'} ) ) <= ceil( $player{'Hit Points'} / ( $boss{'Damage'} - $player{'Armor'} ) )
          ? 'Player'
          : 'Boss';
      printf "\n";
    }
  }
}
