#!/usr/bin/env perl

use v5.40;
use strict;

use Algorithm::Permute;

my %happiness;

while ( my $line = <> ) {
  chomp $line;

  # Alice would gain 26 happiness units by sitting next to Carol.
  # Alice would lose 82 happiness units by sitting next to David.
  $line =~ m/^(\S+) would (\S+) (\d+) happiness units by sitting next to (\S+)\.$/;

  # Store the distance for both locations for easy lookup.
  $happiness{$1}{$4} = $2 eq 'gain' ? $3 : -$3;
}

# use Data::Dump;
# dd \%happiness;
# exit;

my $p = Algorithm::Permute->new( [ sort keys %happiness ] );

# 40,320 possible seating arrangements.
# my @a; say join ', ', @a while @a = $p->next;

sub happiness {
  my ( @arrangement ) = @_;

  # say join ', ', @arrangement;

  my $diner = shift @arrangement;
  my $happiness = 0;

  # The table is a circle, so start with the person "behind" the first diner.
  # say '  ', $arrangement[-1], ' -> ', $diner, ' = ', $happiness{ $arrangement[-1] }{$diner};
  # say '  ', $diner, ' -> ', $arrangement[-1], ' = ', $happiness{$diner}{ $arrangement[-1] };
  $happiness += $happiness{$diner}{ $arrangement[-1] };
  $happiness += $happiness{ $arrangement[-1] }{$diner};

  while ( @arrangement > 0 ) {
    # say '  ', $diner, ' -> ', $arrangement[0], ' = ', $happiness{$diner}{ $arrangement[0] };
    # say '  ', $arrangement[0], ' -> ', $diner, ' = ', $happiness{ $arrangement[0] }{$diner};
    $happiness += $happiness{$diner}{ $arrangement[0] };
    $happiness += $happiness{ $arrangement[0] }{$diner};
    $diner = shift @arrangement;
  }
  # say '  :) ', $happiness;

  return $happiness;
}

while ( my @arrangement = $p->next ) {
  my $happiness = happiness( @arrangement );
  say sprintf '%4d : %s', $happiness, ( join ' -> ', @arrangement );
}
