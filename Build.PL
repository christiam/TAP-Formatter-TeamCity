#!perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/TAP-Formatter-TeamCity-0.03/Build.PL $
#     $Date: 2009-07-30 13:54:49 -0700 (Thu, 30 Jul 2009) $
#   $Author: thaljef $
# $Revision: 3453 $
##############################################################################



use strict;
use warnings;
use Module::Build;


my $builder = Module::Build->new(
    module_name         => 'TAP::Formatter::TeamCity',
    dist_author         => 'Jeffrey Thalhammer <thaljef@cpan.org>',
    dist_abstract       => 'Emit test results as TeamCity service messages.',
    license             => 'perl',
    requires            => {
                            'TeamCity::BuildMessages'  => 0,
                            'TAP::Formatter::Base'     => 3.17,
                            'TAP::Formatter::Session'  => 3.17,
                           },
    build_requires      => {
                            'Test::More'               => 0,
                           },
    create_packlist     => 1,
    sign                => 0,
    create_readme       => 1,
    create_makefile_pl  => 'traditional',

    add_to_cleanup      => [
        qw<
            MANIFEST.bak
            Makefile
            Makefile.old
            pod2htm?.tmp
            pm_to_blib
            nytprof*
            TAP-Formatter-TeamCity*
        >,
    ],
);

$builder->tap_harness_args( {formatter_class => 'TAP::Formatter::TeamCity'} )
    if $ENV{RUNNING_UNDER_TEAMCITY}  && eval {require TAP::Formatter::TeamCity};

$builder->create_build_script();

##############################################################################
# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :
