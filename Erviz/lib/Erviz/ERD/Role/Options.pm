package Erviz::ERD::Role::Options;
use Moose::Role;

has options => (
  is      => 'ro',
  isa     => 'HashRef',
  traits  => ['Hash'],
  handles => {
    has_option => 'exists',
    get_option => 'get',
    all_options => 'elements',
    remove_option => 'delete'
  }
  
);

1;
