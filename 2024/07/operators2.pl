#!/usr/bin/env perl

use v5.40;
use strict;

use Algorithm::Combinatorics qw( variations_with_repetition );
use List::Util qw( reduce );

while ( my $line = <> ) {
  chomp $line;

  $line =~ m/^(\d+): (.*)/;
  my ( $result, @operands ) = ( $1, split / /, $2 );

  if ( grep { my @ops = @$_; $result == reduce { my $op = shift @ops; $op eq '||' ? "$a$b" : eval "$a $op $b" } @operands } variations_with_repetition( [ qw( + * || ) ], scalar @operands  - 1 ) ) {
    say $result;

    # Bail out early if we find a match. There's no need to check any further. It wasn't as important in part one,
    # because the number of possible variations was lower.
    next;
  }
}
