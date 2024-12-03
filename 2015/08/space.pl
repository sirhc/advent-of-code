#!/usr/bin/env perl

use v5.40;
use strict;

my $c_length = 0;  # code chars
my $m_length = 0;  # memory chars
my $e_length = 0;  # escaped chars

sub to_memory {
  my ( $line ) = @_;

  # First, remove the outer quotes.
  $line =~ s/^"//;
  $line =~ s/"$//;

  # Next, interpret the hexadecimal values.
  $line =~ s/\\x([0-9a-f][0-9a-f])/chr(hex($1))/gie;

  # Finally, all remaining escape characters can be interpreted. We don't really care that there are only a couple of
  # possible values, since we already took care of the \x case above. Anything else is a single char.
  $line =~ s/\\(.)/$1/g;

  return $line;
}

sub to_escape {
  my ( $line ) = @_;

  # Start by removing the surrounding quotes. This is just to make it easier to uniformly handle the quotes.
  $line =~ s/^"//;
  $line =~ s/"$//;

  # Now backslashes can be escaped.
  $line =~ s/\\/\\\\/g;

  # But now we've effectively unescaped the quotes. This is why they were removed earlier.
  $line =~ s/"/\\"/g;

  # Now we need to replace the (escaped) quotes and wrap the whole thing in a new set of quotes.
  $line = '"\"' . $line . '\""';

  return $line;
}

while ( my $line = <> ) {
  chomp $line;

  $c_length += length $line; # the number of characters in the code is straight forward, WYSIWYG
  $m_length += length to_memory($line);
  $e_length += length to_escape($line);
}

say "Code:   $c_length";
say "Memory: $m_length (difference: @{[ $c_length - $m_length ]})";
say "Escape: $e_length (difference: @{[ $e_length - $c_length ]})";
