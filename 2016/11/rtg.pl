#!/usr/bin/env perl

use v5.40;
use strict;
use Math::Combinatorics qw( combine );
use Clone qw( clone );
use List::Util qw( any pairs );

use Data::Dump;

my %elements = map { split } <DATA>;  # these are just for visualization purposes
my %isotopes = ();

my $state = {
  elevator => 0,
  floors   => [ {}, {}, {}, {} ],  # [ { HeG => 1, HeM => 0 }, ... ]
};

while ( defined ( my $line = <> ) ) {
  $line =~ /^The (\w+) floor contains /;
  my $floor = $1 eq 'first'  ? 0
            : $1 eq 'second' ? 1
            : $1 eq 'third'  ? 2
            : $1 eq 'fourth' ? 3
            :                  die "Unknown floor: $1";

  while ( $line =~ /an? (\w+)(?:-compatible)? (generator|microchip)/g ) {
    my ( $element, $type ) = ( $1, $2 );

    $isotopes{ $elements{$element} } = 1;

    #push @{ $state->{'floors'}[$floor] }, $elements{$element} . ( $type eq 'generator' ? 'G' : 'M' );
    $state->{'floors'}[$floor]{ $elements{$element} . ( $type eq 'generator' ? 'G' : 'M' ) } = 1;
  }
}

my $iterations = 0;
my $known      = 0;

say 'Initial state:';
say '';
say render($state);
# say serialize($state);
say '';

# say is_safe( $state->{'floors'}[0] ) ? 'Floor 1 is safe' : 'Floor 1 is NOT safe';
# say is_safe( $state->{'floors'}[1] ) ? 'Floor 2 is safe' : 'Floor 2 is NOT safe';
# say is_safe( $state->{'floors'}[2] ) ? 'Floor 3 is safe' : 'Floor 3 is NOT safe';
# say is_safe( $state->{'floors'}[3] ) ? 'Floor 4 is safe' : 'Floor 4 is NOT safe';
# exit;

# dd $state;
# exit;

for my $floor ( 0 .. 3 ) {
  for my $element ( keys %elements ) {
    my $generator = $elements{$element} . 'G';
    my $microchip = $elements{$element} . 'M';

    if ( exists $state->{'floors'}[$floor]{$generator} && exists $state->{'floors'}[$floor]{$microchip} ) {
      $state->{'floors'}[$floor]{$generator} = 0;
      $state->{'floors'}[$floor]{$microchip} = 0;

      $known += 12 - 4 * $floor;
    }
  }

  # $state->{'floors'}[$floor] = [ map { $_->[0] } grep { $_->[1] == 1 } pairs %{ $state->{'floors'}[$floor] } ];
}

# dd [ $known, $state ];

# exit;

say 'Known moves: ', $known;
say '';
say render($state);
say '';
printf "\e[?25l";  # hide the cursor
say 'Minimum number of moves: ', bfs($state) + $known;
printf "\e[?25h";  # show the cursor

sub bfs {
  my $initial_state = shift;
  my @queue         = ( [ $initial_state, 0 ] );  # state, depth
  my %visited       = ();

  while ( @queue ) {
    my ( $state, $depth ) = @{ shift @queue };

    # Skip this state if we've already seen it.
    next if $visited{ serialize($state) }++;
      
    # Return the depth of the search if the goal state is reached.
    if ( is_goal($state) ) {
      print "\n\n";
      return $depth;
    }

    printf "Iteration: %7d : Depth: %3d : Queue: %3d\r", $iterations++, $depth, scalar @queue;

    # Generate and enqueue the next possible states.
    push @queue, map { [ $_, $depth + 1 ] } generate_moves($state);
  }

  return -1;  # no solution found
}

sub get_items {
  my ( $state, $floor ) = @_;

  return map { $_->[0] } grep { $_->[1] == 1 } pairs %{ $state->{'floors'}[$floor] };
}

sub serialize {
  my ( $state ) = @_;

  return join '|', $state->{'elevator'}, map { my $floor = $_; join ',', sort +get_items( $state, $floor ) } 0 .. 3;  # e.g., '0|HM,LiM|HG|LiG|'
}

sub is_goal {
  my ( $state ) = @_;

  for my $floor ( 0 .. 2 ) {
    return if any { $_ == 1 } values %{ $state->{'floors'}[$floor] };  # one of floors 1–3 is not empty
  }

  return 1;
}

sub generate_moves {
  my ( $state ) = @_;

  # Generate a list of all possible moves from the current floor.
  my $current_floor = $state->{'elevator'};
  my @items = get_items( $state, $current_floor );
  my @moves = ( combine( 1, @items ), combine( 2, @items ) );

  my @new_states;

    # Prioritize taking two items up and one item down.
    # for my $move ( sort { $direction == 1 ? @$b <=> @$a : @$a <=> @$b } @moves ) {
  for my $move ( @moves ) {
    for my $direction ( -1, 1 ) {  # down, up
      my $new_floor = $current_floor + $direction;
      next if $new_floor < 0 || $new_floor > 3;  # out of bounds

      # next if $direction ==  1 && @$move == 1;   # don't take a single item up
      # next if $direction == -1 && @$move == 2;   # don't take two items down

      # if ( $direction == -1 && @{ $state->{'floors'}[$new_floor] } == 0 ) {
      #   next if @$move == 1;  # don't take a single item down to an empty floor
      #   next if ( $move->[0] =~ s/.$//r ) eq ( $move->[1] =~ s/.$//r );  # don't take two items of the same type down
      # }

      # Set up the new state.
      my $new_state = clone($state);

      $new_state->{'elevator'} = $new_floor;

      # Remove items from the current floor.
      $new_state->{'floors'}[$current_floor]{$_} = 0 for @$move;

      # Add items to the new floor.
      $new_state->{'floors'}[$new_floor]{$_} = 1 for @$move;

      next unless is_safe( $new_state->{'floors'}[$current_floor] );  # ensure we left the current floor safe
      next unless is_safe( $new_state->{'floors'}[$new_floor] );      # ensure the new floor is safe

      push @new_states, $new_state;
    }
  }

  return @new_states;
}

sub is_safe {
  my ( $floor ) = @_;

  # A floor is represented by a hash: { HeG => 1, HeM => 0, LiG => 1, LiM => 1 }.
  for my $item ( grep { /M$/ } keys %$floor ) {
    next if $floor->{ $item } == 0;              # the microchip is not actually present (due to state representation)
    next if $floor->{ $item =~ s/M$/G/r } // 0;  # the microchip's paired generator is present
    return if grep { $_->[0] =~ /G$/ && $_->[1] == 1 } pairs %$floor;  # the microchip is fried if any other generator is present
  }

  return 1;
}

sub render {
  my $state = shift;
  my @map   = ();

  for my $floor ( 0 .. 3 ) {
    push @{ $map[ $floor ] }, sprintf 'F%d ', $floor + 1;
    push @{ $map[ $floor ] }, sprintf '%-3s', $state->{'elevator'} == $floor ? 'E' : '.';

    for my $isotope ( sort keys %isotopes ) {
      for my $item ( "${isotope}G", "${isotope}M" ) {
        push @{ $map[ $floor ] }, sprintf '%-3s', $state->{'floors'}[$floor]{$item} // 0 > 0 ? $item : '.';
      }
      # push @{ $map[ $floor ] }, sprintf '%-3s', ( grep { $_ eq "${isotope}G" } @{ $state->{'floors'}[$floor] } ) ? "${isotope}G" : '.';
      # push @{ $map[ $floor ] }, sprintf '%-3s', ( grep { $_ eq "${isotope}M" } @{ $state->{'floors'}[$floor] } ) ? "${isotope}M" : '.';
    }
  }

  return join "\n", map { join ' ', @$_ } reverse @map;
}

__DATA__
hydrogen      H
helium        He
lithium       Li
beryllium     Be
boron         B
carbon        C
nitrogen      N
oxygen        O
fluorine      F
neon          Ne
sodium        Na
magnesium     Mg
aluminium     Al
silicon       Si
phosphorus    P
sulfur        S
chlorine      Cl
argon         Ar
potassium     K
calcium       Ca
scandium      Sc
titanium      Ti
vanadium      V
chromium      Cr
manganese     Mn
iron          Fe
cobalt        Co
nickel        Ni
copper        Cu
zinc          Zn
gallium       Ga
germanium     Ge
arsenic       As
selenium      Se
bromine       Br
krypton       Kr
rubidium      Rb
strontium     Sr
yttrium       Y
zirconium     Zr
niobium       Nb
molybdenum    Mo
technetium    Tc
ruthenium     Ru
rhodium       Rh
palladium     Pd
silver        Ag
cadmium       Cd
indium        In
tin           Sn
antimony      Sb
tellurium     Te
iodine        I
xenon         Xe
cesium        Cs
barium        Ba
lanthanum     La
cerium        Ce
praseodymium  Pr
neodymium     Nd
promethium    Pm
samarium      Sm
europium      Eu
gadolinium    Gd
terbium       Tb
dysprosium    Dy
holmium       Ho
erbium        Er
thulium       Tm
ytterbium     Yb
lutetium      Lu
hafnium       Hf
tantalum      Ta
tungsten      W
rhenium       Re
osmium        Os
iridium       Ir
platinum      Pt
gold          Au
mercury       Hg
thallium      Tl
lead          Pb
bismuth       Bi
polonium      Po
astatine      At
radon         Rn
francium      Fr
radium        Ra
actinium      Ac
thorium       Th
protactinium  Pa
uranium       U
neptunium     Np
plutonium     Pu
americium     Am
curium        Cm
berkelium     Bk
californium   Cf
einsteinium   Es
fermium       Fm
mendelevium   Md
nobelium      No
lawrencium    Lr
rutherfordium Rf
dubnium       Db
seaborgium    Sg
bohrium       Bh
hassium       Hs
meitnerium    Mt
darmstadtium  Ds
roentgenium   Rg
copernicium   Cn
nihonium      Nh
flerovium     Fl
moscovium     Mc
livermorium   Lv
tennessine    Ts
oganesson     Og
ununennium    Uue
elerium       El
dilithium     Di
