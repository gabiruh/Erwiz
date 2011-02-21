use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Erviz',
    AUTHOR              => q{Gabriel Andrade <gabiruh@gmail.com>},
    VERSION_FROM        => 'lib/Erviz.pm',
    ABSTRACT_FROM       => 'lib/Erviz.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Erviz-*' },
);
