#!/usr/bin/env perl

use strict;
use v5.40;

sub check_report {
  my @levels = @_;

  # The report levels must be in either ascending or descending order.
  if ( ( join ' ', @levels ) ne ( join ' ', sort { $a <=> $b } @levels ) && ( join ' ', @levels ) ne ( join ' ', sort { $b <=> $a } @levels ) ) {
    return 0;
  }

  for my $i ( 0 .. $#levels - 1 ) {
    # Adjacent levels must differ by at least one and at most three.
    return 0 if abs($levels[$i] - $levels[$i + 1]) < 1;
    return 0 if abs($levels[$i] - $levels[$i + 1]) > 3;
  }

  return 1;
}

while ( <> ) {
  chomp;
  my @report = split ' ', $_;

  # Part One.
  if ( check_report( @report ) ) {
    say 'Part 1 -> Safe ', join ' ', @report;
  } else {
    say 'Part 1 -> Unsafe ', join ' ', @report;
  }

  # Part Two.
  for my $i ( 0 .. $#report ) {
    my $remove = $report[$i];
    my @test   = ( @report[ 0 .. $i - 1 ], @report[ $i + 1 .. $#report ] );

    if ( check_report(@test) ) {
      say sprintf 'Part 2 -> Safe %s => %s (removed %d at position %d)', ( join ' ', @report ), ( join ' ', @test), $remove, $i;
      last;
    }
  }

  say sprintf 'Part 2 -> Unsafe %s', ( join ' ', @report );
}
