use strict;
use warnings;

use lib 'inc';
use ExtUtils::MakeMaker::Dist::Zilla::Develop;

# keep this code consistent with the [MakeMaker::Awesome] arguments in dist.ini
use ExtUtils::Depends;
my $pkg = ExtUtils::Depends->new('XS::Object::Magic');
$pkg->install('xs_object_magic.h');
$pkg->add_xs('Magic.xs');
$pkg->add_pm('lib/XS/Object/Magic.pm' => '$(INST_LIB)/XS/Object/Magic.pm');
$pkg->add_typemaps('typemap');

mkdir 'build';
$pkg->save_config('build/IFiles.pm');

WriteMakefile(
    NAME => 'XS::Object::Magic',
    VERSION_FROM => 'lib/XS/Object/Magic.pm',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
    NORECURS => 1,
    $pkg->get_makefile_vars,
    DL_FUNCS => { 'XS::Object::Magic' => [] },
    TYPEMAPS => [qw(typemap test_typemap)],
);

use Devel::PPPort;
Devel::PPPort::WriteFile();
system("$^X ppport.h --compat-version=5.008001 --quiet *.xs *.[hc]");
