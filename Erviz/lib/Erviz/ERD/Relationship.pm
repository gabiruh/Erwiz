package Erviz::ERD::Relationship;
use Moose;

has name       => ( is => 'ro', isa => 'Str' );
has attributes => ( is => 'ro', isa => 'ArrayRef[Erviz::ERD::Attribute]' );
has options    => ( is => 'ro', isa => 'ArrayRef[Erviz::ERD::Option]' );
1;
