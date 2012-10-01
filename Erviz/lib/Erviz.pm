package Erviz;
use warnings;
use strict;

use Exporter 'import';
our @EXPORT_OK = qw(process);


use Erviz::Parser qw(parse);
use Erviz::Render qw(render);



=head1 NAME

Erviz 

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

=head1 SUBROUTINES/METHODS

=head2 process

=cut

sub process {
  my $input = shift;
  print render(parse($input));
}

=head1 AUTHOR

Gabriel Andrade, C<< <gabiruh at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-erviz at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Erviz>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Erviz


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Erviz>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Erviz>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Erviz>

=item * Search CPAN

L<http://search.cpan.org/dist/Erviz/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Gabriel Andrade.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1;    # End of Erviz
