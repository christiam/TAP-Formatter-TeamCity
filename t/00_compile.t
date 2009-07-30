#!/usr/bin/env perl

#############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/TAP-Formatter-TeamCity-0.02/t/00_compile.t $
#     $Date: 2009-07-30 11:46:19 -0700 (Thu, 30 Jul 2009) $
#   $Author: thaljef $
# $Revision: 3450 $
#############################################################################

use strict;
use warnings;
use Test::More (tests => 6);

#-----------------------------------------------------------------------------

our $VERSION = '0.01';

#-----------------------------------------------------------------------------

use_ok('TAP::Formatter::TeamCity');
my $formatter = TAP::Formatter::TeamCity->new();
isa_ok($formatter, 'TAP::Formatter::TeamCity');
isa_ok($formatter, 'TAP::Formatter::Base');

use_ok('TAP::Formatter::Session::TeamCity');
my $formatter_session = TAP::Formatter::Session::TeamCity->new( {formatter => $formatter} );
isa_ok($formatter_session, 'TAP::Formatter::Session::TeamCity');
isa_ok($formatter_session, 'TAP::Formatter::Session');

# Yes, I know.  Much work to be done here!
