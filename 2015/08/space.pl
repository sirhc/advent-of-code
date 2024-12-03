#!/usr/bin/env perl

use v5.40;
use strict;

my $c_length = 0;  # code chars
my $m_length = 0;  # memory chars

while ( my $line = <> ) {
  chomp $line;

  # say $line;

  # The number of characters in the code is straight forward. WYSIWYG.
  $c_length += length $line;

  # The size in memory requires a bit of interpretation.

  # First, remove the outer quotes.
  $line =~ s/^"//;
  $line =~ s/"$//;

  # Next, interpret the hexadecimal values.
  $line =~ s/\\x([0-9a-f][0-9a-f])/chr(hex($1))/gie;

  # Finally, all remaining escape characters can be interpreted. We don't really care that there are only a couple of
  # possible values, since we already took care of the \x case above. Anything else is a single char.
  $line =~ s/\\(.)/$1/g;

  $m_length += length $line;

  # say $line;
}

say "Code:       $c_length";
say "Memory:     $m_length";
say "Difference: @{[ $c_length - $m_length ]}";
