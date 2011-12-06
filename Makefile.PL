use strict;
use warnings FATAL => 'all';
use 5.008001;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'XenServer-API',
  AUTHOR  => 'Justin Hunter <justin.d.hunter@gmail.com>',
  VERSION_FROM => 'lib/XenServer/API.pm',
  LICENSE => 'perl',
  ABSTRACT_FROM => 'lib/XenServer/API.pm',
  MIN_PERL_VERSION => '5.008001',
  PREREQ_PM => {
    'XML::RPC' => 0,
    'Moose' => 0.93,
    'Moose::Util::TypeConstraints' => 0,
    'MooseX::Types::Moose' => 0,
    'MooseX::Types::UUID' => 0,
    'namespace::autoclean' => 0,
  },
  'BUILD_REQUIRES' => {
    'Test::More' => '0.88',
  },
  META_MERGE      => {
    resources => {
      license     => 'http://dev.perl.org/licenses/',
      repository  => 'https://github.com/arcanez/xenserver-api',
    },
  },
);
