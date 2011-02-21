#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Erviz' ) || print "Bail out!
";
}

diag( "Testing Erviz $Erviz::VERSION, Perl $], $^X" );
