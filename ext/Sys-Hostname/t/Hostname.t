#!./perl

BEGIN {
    require Config; import Config;
    if ($Config{'extensions'} !~ /\bSys\/Hostname\b/) {
      print "1..0 # Skip: Sys::Hostname was not built\n";
      exit 0;
    }
}

use Sys::Hostname;

use Test::More tests => 2;

SKIP:
{
    eval {
        $host = hostname;
    };
    skip "No hostname available", 1
      if $@ =~ /Cannot get host name/;
    isnt($host, undef, "got a hostname");
}

{
    local $@;
    eval { hostname("dummy"); };
    like($@, qr/hostname\(\) no longer accepts arguments/,
        "hostname no longer accepts arguments");
}
