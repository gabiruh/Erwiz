package Erviz::Render;

use strict;
use warnings;

use GraphViz;
use Data::Visitor::Callback;

sub render {
  my $erd     = shift;
  my $g       = GraphViz->new();
  my $visitor = Data::Visitor::Callback->new(
    'Erviz::ERD::Entity'       => sub { $_[1]->visit($g) },
    'Erviz::ERD::Relationship' => sub { $_[1]->visit($g) },
  );
  return $g->as_canon;
}
1;
