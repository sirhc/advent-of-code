#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

my @input   = map { chomp; [ split // ] } <>;
my @message = ();

for my $x ( 0 .. $#{ $input[0] } ) {
  for my $y ( 0 .. $#input ) {
    $message[$x][$y] = $input[$y][$x];
  }
}

# dd [ \@input, \@message ];

print extract_letter(@$_) for @message;
print "\n";

sub extract_letter {
  my @column = @_;

  my %count;
  do { $count{$_}++ } for @column;

  return ${[ sort { $count{$b} <=> $count{$a} } keys %count ]}[0];
}
