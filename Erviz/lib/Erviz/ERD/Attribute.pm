package Erviz::ERD::Attribute;
use overload
  q{""}    => 'as_string',
  fallback => 1;

use Moose;
with 'Erviz::ERD::Role::Options';

has name => ( is => 'ro', isa => 'Str', required => 1 );
has is_primary_key =>
  ( is => 'ro', isa => 'Bool', default => 0, init_arg => 'primary_key' );

has is_foreign_key =>
  ( is => 'ro', isa => 'Bool', default => 0, init_arg => 'foreign_key' );

sub as_string {
  my $self = shift;
  my $name = quotemeta $self->name;
  my $constraint = '';
  $constraint = '(FK)' if $self->is_foreign_key;
  $constraint = '(PK)' if $self->is_primary_key;

  my $is_constraint = ( $self->is_primary_key || $self->is_foreign_key ) ? '*' : '';
  my $mark =
    quotemeta( $self->has_option('mark') ? $self->remove_option('mark') : '' );
  return qq!$name $constraint $mark!;
}
1;

