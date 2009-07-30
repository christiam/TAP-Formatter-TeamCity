#############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/tags/TAP-Formatter-TeamCity-0.02/lib/TAP/Formatter/TeamCity.pm $
#     $Date: 2009-07-30 13:54:49 -0700 (Thu, 30 Jul 2009) $
#   $Author: thaljef $
# $Revision: 3453 $
#############################################################################

package TAP::Formatter::TeamCity;

use strict;
use warnings;

use TeamCity::BuildMessages qw(:all);
use TAP::Formatter::Session::TeamCity;

#-----------------------------------------------------------------------------

use base qw(TAP::Formatter::Base);

#-----------------------------------------------------------------------------

our $VERSION = '0.02';

#-----------------------------------------------------------------------------

sub open_test {
    my ($self, $test, $parser) = @_;

    my $session = TAP::Formatter::Session::TeamCity->new(
        {   name       => $test,
            formatter  => $self,
            parser     => $parser,
            show_count => 0,
        }
    );


    teamcity_emit_build_message('testSuiteStarted', name => $test);

    while ( defined( my $result = $parser->next() ) ) {
        $self->_emit_teamcity_messages($result) if $result->is_test();
        $session->result($result);
        exit 1 if $result->is_bailout();
    }

    teamcity_emit_build_message('testSuiteFinished', name => $test);

    return $session;
}

#-----------------------------------------------------------------------------

sub _emit_teamcity_messages {
    my ($self, $result) = @_;

    my $test_name = $result->description() || 'No test name given';
    $test_name =~ s{\A \s* - \s+}{}mx;

    teamcity_emit_build_message('testStarted', captureStandardOutput => 'true', name => $test_name);
    $self->_emit_teamcity_test_results($test_name, $result);
    teamcity_emit_build_message('testFinished', name => $test_name);

    return;
}

#-----------------------------------------------------------------------------

sub _emit_teamcity_test_results {
    my ($self, $test_name, $result) = @_;

    my $expl = $result->explanation() || 'No explanation given';

    if ( $result->has_todo() ) {
        teamcity_emit_build_message('testIgnored', name => $test_name,  message => $expl);
    }
    elsif ( $result->has_skip() ) {
        teamcity_emit_build_message('testIgnored', name => $test_name,  message => $expl);
    }
    elsif ( $result->is_unknown() ) {
        teamcity_emit_build_message('testFailed', name => $test_name,  message => $expl);
    }
    elsif ( not $result->is_ok() ) {
        teamcity_emit_build_message('testFailed', name => $test_name,  message => $expl);
    }

    return;
}

#-----------------------------------------------------------------------------
1;

=pod

=head1 NAME

TAP::Formatter::TeamCity

=head1 SYNOPSIS

   # When using prove(1):
   prove -formatter TAP::Formatter::TeamCity my_test.t

   # From within a Module::Build subclass:
   sub tap_harness_args { return {formatter_class => 'TAP::Formatter::TeamCity'} }

=head1 DESCRIPTION

L<TAP::Formatter::TeamCity> is a plugin for L<TAP::Harness> that emits TeamCity
service messages to the console, rather than the usual output.  The TeamCity build
server is able to process these messages in the build log and present your test
results in its web interface (along with some nice statistics and graphs).

This is very much alpha code, and is subject to change.

=head1 SEE IT IN ACTION

If you're not familiar with continuous integration systems (in general) or
TeamCity (in particular), you're welcome to explore the TeamCity build server
we use for the L<Perl::Critic> project.  Just go to
L<http://perlcritic.com:8111> and click on the "Login as a Guest" link.  From
there, you can browse the build history, review test results, and examine the
artifacts (such as test coverage reports and performance profiles).  All the
information you see there was generated from TAP-based tests using this module
to communicate the results to the TeamCity server.

=head1 SUGGESTED USAGE

The TeamCity service messages are generally not human-readable, so you
probably only want to use this Formatter when the tests are being run by a
TeamCity build agent and the L<TAP::Formatter::TeamCity> module is available.
I suggest using an environment variable to activate the Formatter.  If you're
using a recent version of L<Module::Build> you might do something like this in
your F<Build.PL> file:

  # Regular build configuration here:
  my $builder = Module::Build->new( ... )

  # Specify this Formatter, if the environment variable is set:
  $builder->tap_harness_args( {formatter_class => 'TAP::Formatter::TeamCity'} )
    if $ENV{RUNNING_UNDER_TEAMCITY} && eval {require TAP::Formatter::TeamCity};

  # Generate build script as ususal:
  $builder->create_build_script();

And then set the C<RUNNING_UNDER_TEAMCITY> environment variable to a true value
in your TeamCity build configuration.

TODO: Figure out if/how to do this with L<ExtUtils::MakeMaker>.

=head1 LIMITATIONS

TeamCity comes from a jUnit culture, so it doesn't understand SKIP and TODO 
tests in the same way that Perl testing harnesses do.  Therefore, this formatter
simply instructs TeamCity to ignore tests that are marked SKIP or TODO.

Also, I haven't yet figured out how to transmit test diagnostic messages, so
those probably won't appear in the TeamCity web interface.  But I'm working
on it :)

=head1 SOME EXTRA CANDY

TeamCity, CruiseControl, and some other continuous integration systems are
oriented towards Java code.  As such, they don't have native support for
Perl's customary build tools like L<Module::Build>.  But they do have nice
support for running Ant.  This distribution contains an Ant build script at
F<build.xml> which wraps L<Module::Build> actions in Ant targets.  This makes
it easier to configure TeamCity and CruiseControl to build your Perl code.  If
you're using the EPIC plug-in with Eclipse, you can also use this Ant script
to build your code from within the IDE.  Feel free to copy the F<build.xml>
into your own projects.

=head1 SEE ALSO

L<TeamCity::BuildMessages>

=head1 AUTHOR

Jeffrey Thalhammer <thaljef@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2009 Jeffrey Ryan Thalhammer.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  The full text of this license
can be found in the LICENSE file included with this module.

=cut


##############################################################################
# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :
