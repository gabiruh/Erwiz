package Erviz::ERD::Entity;
use Moose;
with 'Erviz::ERD::Role::Options';

has name => ( is => 'ro', isa => 'Str' );
has attributes => (
  is      => 'ro',
  traits  => ['Array'],
  isa     => 'ArrayRef[Erviz::ERD::Attribute]',
  handles => { join_attributes => 'join', map_attributes => 'map' }
);

sub visit {
  my ( $self, $g ) = @_;
  my $name = quotemeta $self->name;
  my $mark =
    quotemeta $self->has_option('mark') ? $self->remove_option('mark') : '';
  my $constraints_column = join(
    '|',
    $self->map_attributes(
      sub { ( $_->is_primary_key || $_->is_foreign_key ) ? '*' : ' '; }
    )
  );
  my $attributes_column = $self->join_attributes(' | ');
  $g->add_node(
    $name,
    tooltip => $self->name,
    shape   => 'record',
    label   => "{ $name $mark | { {$constraints_column} | {$attributes_column} }}",
    $self->all_options
  );
}

1;
