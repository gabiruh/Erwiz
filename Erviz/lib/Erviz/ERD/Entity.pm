package Erviz::ERD::Entity;
use Moose;

has name => ( is => 'ro', isa => 'Str' );
has attributes => (
  is      => 'ro',
  traits  => ['Array'],
  isa     => 'ArrayRef[Erviz::ERD::Attribute]',
  handles => { join_attributes => 'join' }
);
has options => ( is => 'ro', isa => 'ArrayRef[Erviz::ERD::Option]' );

sub visit {
  my ( $self, $g ) = @_;
  my $name = quotemeta $self->name;
  $g->add_node(
    $name,
    tooltip => $self->name,
    label   => "{ $name | " $self->join_attributes('|') . '}'
  );
}

1;
