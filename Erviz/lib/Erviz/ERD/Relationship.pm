package Erviz::ERD::Relationship;
use Moose;
with 'Erviz::ERD::Role::Options';

has name       => ( is => 'ro', isa => 'Str' );
has attributes => ( is => 'ro', isa => 'ArrayRef[Erviz::ERD::Attribute]' );
1;
