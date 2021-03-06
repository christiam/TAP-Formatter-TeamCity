#############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/TAP-Formatter-TeamCity-0.04/lib/TAP/Formatter/Session/TeamCity.pm $
#     $Date: 2009-09-09 13:03:47 -0700 (Wed, 09 Sep 2009) $
#   $Author: thaljef $
# $Revision: 3641 $
#############################################################################

package TAP::Formatter::Session::TeamCity;

use strict;
use warnings;

#-----------------------------------------------------------------------------

use base qw(TAP::Formatter::Session);

#-----------------------------------------------------------------------------

our $VERSION = '0.04';

#----------------------------------------------------------------------------
1;

=pod

=head1 NAME

TAP::Formatter::Session::TeamCity - A session of TeamCity service messages

=head1 DESCRIPTION

L<TAP::Formatter::Session::TeamCity> is the Session delegate used by
L<TAP::Formatter::TeamCity>.  Since TeamCity takes care of tabulating and
summarizing test results for you, there is no particular session-level
reporting that is required.  So this is basically just the minimal
L<TAP::Formatter::Session>.

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-sofrware.com>

=head1 COPYRIGHT   

Copyright (c) 2009 Imaginative Software Systems.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  The full text of this license
can be found in the LICENSE file included with this module.

=cut
