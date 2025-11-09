#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

my @instructions = <>;
my %board;

# bot 0 gives low to output 2 and high to output 0
# bot 1 gives low to output 1 and high to bot 0
# bot 2 gives low to bot 1 and high to bot 0
# value 2 goes to bot 2

for my $instruction ( @instructions ) {
  if ( $instruction =~ /^value (\d+) goes to bot (\d+)/ ) {
    push @{ $board{'bot'}[$2]{values} }, $1;
    next;
  }

  if ( $instruction =~ /^bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)/ ) {
    my ( $bot, $low_dest, $low_id, $high_dest, $high_id ) = ( $1, $2, $3, $4, $5 );

    $board{'bot'}[$bot]{'low'}  = sub { push @{ $board{$low_dest}[$low_id]{'values'} }, @{[ sort { $a <=> $b } @{ $board{'bot'}[$bot]{'values'} } ]}[0] };
    $board{'bot'}[$bot]{'high'} = sub { push @{ $board{$high_dest}[$high_id]{'values'} }, @{[ sort { $b <=> $a } @{ $board{'bot'}[$bot]{'values'} } ]}[0] };
    next;
  }
}

while ( 1 ) {
  my $done = 1;

  for my $i ( 0 .. $#{ $board{'bot'} } ) {
    my $bot = $board{'bot'}[$i];

    next unless defined $bot;
    next unless defined $bot->{'values'} && @{ $bot->{'values'} } == 2;

    $done = 0;

    say sprintf 'Bot %d is comparing %d and %d', $i, sort { $a <=> $b } @{ $bot->{'values'} };

    $bot->{'low'}->();
    $bot->{'high'}->();
    $bot->{'values'} = [];
  }

  # dd \@instructions, \%board;

  last if $done;
}

dd {
  output0 => $board{'output'}[0]{'values'},
  output1 => $board{'output'}[1]{'values'},
  output2 => $board{'output'}[2]{'values'},
};
