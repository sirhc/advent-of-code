#!/usr/bin/env perl

use v5.40;
use strict;

use Algorithm::Combinatorics qw( variations_with_repetition );
use List::Util qw( reduce );

while ( my $line = <> ) {
  chomp $line;

  $line =~ m/^(\d+): (.*)/;
  my ( $result, @operands ) = ( $1, split / /, $2 );

  # I have a feeling I will need to know which combination of operators was correct for part two.
  if ( grep { my @ops = @$_; $result == reduce { eval "$a @{[ shift @ops ]} $b" } @operands } variations_with_repetition( [ qw( + * ) ], scalar @operands  - 1 ) ) {
    print 'OK ';
  } else {
    print 'NO ';
  }

  say $line;
}
