#!/usr/bin/env perl

use v5.40;
use strict;
use Math::Combinatorics qw( combine );
use Storable qw( dclone );

my %elements = map { split } <DATA>;  # these are just for visualization purposes
my %isotopes = ();

my $state = {
  elevator => 0,
  floors   => [ [], [], [], [] ],
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

    push @{ $state->{'floors'}[$floor] }, $elements{$element} . ( $type eq 'generator' ? 'G' : 'M' );
  }
}

my $iterations = 0;

system 'setterm -cursor off';
say render($state);
say '';
say 'Minimum number of moves: ', bfs($state);
system 'setterm -cursor on';

sub bfs {
  my $initial_state = shift;
  my @queue         = ( [ $initial_state, 0 ] );  # state, depth
  my %visited       = ();

  while ( @queue ) {
    my ( $state, $depth ) = @{ shift @queue };

    # Skip this state if we've already seen it.
    next if $visited{ join '|', $state->{elevator}, map { join ',', sort @$_ } @{ $state->{floors} } }++;  # e.g., '0|HM,LiM|HG|LiG|'
      
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

sub is_goal {
  my ( $state ) = @_;

  for my $floor ( 0 .. 2 ) {
    return 0 if @{ $state->{floors}[$floor] };  # one of floors 1–3 is not empty
  }

  return 1;
}

sub generate_moves {
  my ( $state ) = @_;

  # Generate a list of all possible moves from the current floor.
  my $current_floor = $state->{'elevator'};
  my @items = @{ $state->{'floors'}[$current_floor] };
  my @moves = ( combine( 1, @items ), combine( 2, @items ) );

  my @new_states;

  for my $move ( @moves ) {
    for my $direction ( -1, 1 ) {  # down, up
      my $new_floor = $current_floor + $direction;
      next if $new_floor < 0 || $new_floor > 3;  # out of bounds

      # Set up the new state.
      my $new_state = dclone($state);

      $new_state->{'elevator'} = $new_floor;

      # Remove items from the current floor.
      $new_state->{'floors'}[$current_floor] = [ grep { my $item = $_; !grep { $_ eq $item } @$move } @{ $state->{'floors'}[$current_floor] } ];

      # Add items to the new floor.
      push @{ $new_state->{'floors'}[$new_floor]}, @$move;

      next unless is_safe( $new_state->{'floors'}[$current_floor] );  # ensure we left the current floor safe
      next unless is_safe( $new_state->{'floors'}[$new_floor] );      # ensure the new floor is safe

      push @new_states, $new_state;
    }
  }

  return @new_states;
}

sub is_safe {
  my ( $floor ) = @_;

  for my $item ( @$floor ) {
    next if $item =~ /G$/;                 # generators aren't affected by other items

    my $generator = $item =~ s/M$/G/r;
    next if grep { $_ eq $generator } @$floor;  # the microchip's paired generator is present

    return if grep { /G$/ } @$floor;     # the microchip is fried if any other generator is present
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
      push @{ $map[ $floor ] }, sprintf '%-3s', ( grep { $_ eq "${isotope}G" } @{ $state->{'floors'}[$floor] } ) ? "${isotope}G" : '.';
      push @{ $map[ $floor ] }, sprintf '%-3s', ( grep { $_ eq "${isotope}M" } @{ $state->{'floors'}[$floor] } ) ? "${isotope}M" : '.';
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
