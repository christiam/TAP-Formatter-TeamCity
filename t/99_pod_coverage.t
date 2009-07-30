#!perl

##############################################################################
#     $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/TAP-Formatter-TeamCity-0.02/t/99_pod_coverage.t $
#    $Date: 2009-07-30 11:46:19 -0700 (Thu, 30 Jul 2009) $
#   $Author: thaljef $
# $Revision: 3450 $
##############################################################################

use strict;
use warnings;
use English qw< -no_match_vars >;
use Test::More;

#-----------------------------------------------------------------------------

our $VERSION = '0.01';

#-----------------------------------------------------------------------------

eval 'use Test::Pod::Coverage 1.04; 1'
    or plan skip_all => 'Test::Pod::Coverage 1.04 requried to test POD';

my @trusted_methods  = get_trusted_methods();
my $method_string = join ' | ', @trusted_methods;
my $trusted_rx = qr{ \A (?: $method_string ) \z }xms;
all_pod_coverage_ok( {trustme => [$trusted_rx]} );

#-----------------------------------------------------------------------------

sub get_trusted_methods {
    return qw(
        open_test
    );
}

##############################################################################
# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :
