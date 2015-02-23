#!/usr/bin/env perl

# Kind of like "grep", only every line is displayed.  So it's more like vim
# with the "highlight matches" option set.

use strict;
use warnings;

use Term::ANSIColor;

# Setup defaults for our options
my $rx = '';
my ($fg, $bg) = ('black', 'bright_yellow');
my $insensitive = 0;

# Read the commandline options
while ($rx = shift @ARGV) {
  if ($rx eq '-i') {
    $insensitive = 1;
  }
  else {
    last;
  }
}

# We only have one required argument...
unless ($rx) {
  print <<HELP;
$0 [-i] <regexp> [FILE]*

Reads the contents of (one or more) FILEs and colorizes the matching regexp.
Essentially, this is like running a highlighter through your console.  When
FILE is omitted, colorize STDIN.

  -i ... Case insensitive matches

Example:

Highlight warnings from a logfile, while still showing the full contents:

 # tail -f some-app.log | $0 -i WARN
  
HELP
  exit(1);
}

$rx = "(?i:$rx)" if $insensitive;

while (my $line = <>) {
  chomp $line;

  # Matched lines get highlighted, with the matching expression
  # reverse-highlighted.

  if ($line =~ m/$rx/) {
    while ($line =~ m/$rx/) {
      print color("$fg on_$bg"), $`;
      print color("$bg on_$fg"), $&;
      $line = $';
    }
    print color("$fg on_$bg"), $line;
    print color('reset'), "\n";
  }

  # Non-matched lines just get printed normally.

  else {
    print $line, "\n";
  }
}

