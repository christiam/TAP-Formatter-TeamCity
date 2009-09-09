#!perl

##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/TAP-Formatter-TeamCity-0.04/xt/author/00_perlcritic.t $
#     $Date: 2009-07-30 11:46:19 -0700 (Thu, 30 Jul 2009) $
#   $Author: thaljef $
# $Revision: 3450 $
##############################################################################


use strict;
use warnings;
use File::Spec;
use Test::Perl::Critic (profile => File::Spec->catfile( qw(xt author 00_perlcriticrc) ));

#-----------------------------------------------------------------------------

our $VERSION = '0.01';

#-----------------------------------------------------------------------------

all_critic_ok();

#-----------------------------------------------------------------------------
# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :
