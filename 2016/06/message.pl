#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

my @input = map { chomp; [ split // ] } <>;
my @code  = ();

for my $x ( 0 .. $#{ $input[0] } ) {
  for my $y ( 0 .. $#input ) {
    $code[$x][$y] = $input[$y][$x];
  }
}

# dd [ \@input, \@code ];

my @message = map { extract_letters(@$_) }  @code;

dd \@message;

sub extract_letters {
  my @column = @_;

  my %count;
  do { $count{$_}++ } for @column;
  # dd \%count;

  my @letters = sort { $count{$b} <=> $count{$a} } keys %count;
  return [ $letters[0], $letters[-1] ];
}
