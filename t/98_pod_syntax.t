#!perl

##############################################################################
#     $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/TAP-Formatter-TeamCity-0.01/t/98_pod_syntax.t $
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

eval 'use Test::Pod 1.00';
plan skip_all => 'Test::Pod 1.00 required for testing POD' if $EVAL_ERROR;
all_pod_files_ok();

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :
