package Erviz::ERD::Attribute;
use Moose;

has name => ( is => 'ro', isa => 'Str', required => 1 );
has primary_key =>
  ( is => 'ro', isa => 'Bool', default => 0, predicate => 'is_primary_key' );

has foreign_key =>
  ( is => 'ro', isa => 'Bool', default => 0, predicate => 'is_foreign_key' );

has options => ( is => 'ro', isa => 'ArrayRef[Erviz::ERD::Option]' );
1;
