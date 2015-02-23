# hl

Highlights lines in a terminal--like an unfiltered grep.

## USAGE 

hl.pl [-i] <regexp> [FILE]\*

Reads the contents of (one or more) FILEs and colorizes the matching regexp.
Essentially, this is like running a highlighter through your console.  When
FILE is omitted, colorize STDIN.

This is mostly useful for picking out interesting text from really dense
logfiles.

## EXAMPLE

Highlight all lines containing WARN:

  # tail -f some-app.log | hl.pl WARN

Highlight some major event in a particular lifecycle:

  # some-app-with-really-dense-output | hl.pl "Switching nodes"

## INSTALLATION

Just make a link to hl.pl in your ~/bin directory (wherever that may be), e.g.:

  ln hl.pl ~/bin/hl

Also, you may need to install Term::ANSIColor through CPAN.  Have fun with
that.

