#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;
use List::Util qw( max min );
use Storable qw( dclone );

my %spells = (
  'Magic Missile' => 53,   # cost
  'Drain'         => 73,
  'Shield'        => 113,
  'Poison'        => 173,
  'Recharge'      => 229,
);

my %state = (
  # 'Player' => { 'Hit Points' => 10, 'Mana' => 250, 'Armor' => 0, 'Spent' => 0 },  # examples
  'Player' => { 'Hit Points' => 50, 'Mana' => 500, 'Armor' => 0, 'Spent' => 0 },  # input

  # 'Boss' => { 'Hit Points' => 13, 'Damage' => 8 },  # example 1
  # 'Boss' => { 'Hit Points' => 14, 'Damage' => 8 },  # example 2
  'Boss' => { 'Hit Points' => 58, 'Damage' => 9 },  # input

  'Effects' => { 'Shield' => 0, 'Poison' => 0, 'Recharge' => 0 },
);

my @stack = ();
my @spent = ();

push @stack, dclone( \%state );

while ( @stack ) {
  my $state = pop @stack;

  # Player turn.

  # For part 2, we need to do one more check before moving on with the rest.
  $state->{'Player'}{'Hit Points'} -= 1;
  if ( check_loss( $state ) ) {
    next;
  }

  # Do this before the spell choice loop, because active effects will reduce time and may increase mana.
  apply_effects( $state );
  if ( check_win( $state ) ) {
    # dd $turn;
    push @spent, $state->{'Player'}{'Spent'};
    next;
  }

  for my $spell ( spell_options( $state ) ) {
    # Player's choice creates a decision tree.
    my $turn = dclone( $state );
    $turn->{'Spell'} = $spell;

    cast_spell( $turn, $spell );
    if ( check_win( $turn ) ) {
      # dd $turn;
      push @spent, $turn->{'Player'}{'Spent'};
      next;
    }

    # Boss turn. No decision trees here.
    apply_effects( $turn );
    if ( check_win( $turn ) ) {
      # dd $turn;
      push @spent, $turn->{'Player'}{'Spent'};
      next;
    }
    boss_attack( $turn );
    if ( check_loss( $turn ) ) {
      next;
    }

    if ( scalar @spent && $turn->{'Player'}{'Spent'} >= ( min @spent ) ) {
      # There's no need to continue playing if we've already found a cheaper win.
      next;
    }

    push @stack, $turn;
  }
}

say min @spent;

sub apply_effects {
  my ( $state ) = @_;

  if ( $state->{'Effects'}{'Poison'} > 0 ) {
    $state->{'Boss'}{'Hit Points'} -= 3;
  }

  if ( $state->{'Effects'}{'Recharge'} > 0 ) {
    $state->{'Player'}{'Mana'} += 101;
  }

  for my $effect ( qw( Shield Poison Recharge ) ) {
    $state->{'Effects'}{$effect} = max 0, ( $state->{'Effects'}{$effect} - 1 );
  }
}

sub boss_attack {
  my ( $state ) = @_;

  $state->{'Player'}{'Hit Points'} -= $state->{'Boss'}{'Damage'} - ( $state->{'Effects'}{'Shield'} > 0 ? 7 : 0 );
}

sub cast_spell {
  my ( $state, $spell ) = @_;

  $state->{'Player'}{'Mana'}  -= $spells{$spell};
  $state->{'Player'}{'Spent'} += $spells{$spell};

  if ( $spell eq 'Magic Missile' ) {
    $state->{'Boss'}{'Hit Points'} -= 4;
  }

  if ( $spell eq 'Drain' ) {
    $state->{'Boss'}{'Hit Points'} -= 2;
    $state->{'Player'}{'Hit Points'} += 2;
  }

  if ( $spell eq 'Shield' ) {
    $state->{'Effects'}{'Shield'} = 6;
  }

  if ( $spell eq 'Poison' ) {
    $state->{'Effects'}{'Poison'} = 6;
  }

  if ( $spell eq 'Recharge' ) {
    $state->{'Effects'}{'Recharge'} = 5;
  }
}

sub check_loss {
  my ( $state ) = @_;

  return 1 if $state->{'Player'}{'Hit Points'} <= 0;
}

sub check_win {
  my ( $state ) = @_;

  return 1 if $state->{'Boss'}{'Hit Points'} <= 0;
}

sub spell_options {
  my ( $state ) = @_;

  return
    grep { $state->{'Player'}->{'Mana'} >= $spells{$_} }  # can only cast spells the player can afford
    grep { ( $state->{'Effects'}->{$_} // 0 ) == 0 }      # can only cast spells that aren't active (effects wear off before casting)
    sort keys %spells;
}
