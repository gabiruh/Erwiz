package Erviz::ERD::Attribute;
use overload
  q{""}    => 'as_string',
  fallback => 1;

use Moose;

has name => ( is => 'ro', isa => 'Str', required => 1 );
has primary_key =>
  ( is => 'ro', isa => 'Bool', default => 0, predicate => 'is_primary_key' );

has foreign_key =>
  ( is => 'ro', isa => 'Bool', default => 0, predicate => 'is_foreign_key' );

has options => ( is => 'ro', isa => 'ArrayRef[Erviz::ERD::Option]' );

sub as_string {
  my $self       = shift;
  my $name       = $self->name;
  my $constraint = ( $self->primary_key && 'PK' )
    || ( $self->foreign_key && 'FK' );
  my $is_constraint = ( $self->primary_key || $self->foreign_key ) ? '*' : '';

  return qq!{ $is_constraint | $name ($constraint) }!;
}
1;

