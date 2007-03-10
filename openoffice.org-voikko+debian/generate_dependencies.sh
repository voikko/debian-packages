#!/bin/sh
# This script generates "Depends" and "Conflicts" fields to binary package's
# control file.

substvars=debian/openoffice.org-voikko.substvars

current_version=$(dpkg-query --showformat='${Version}\n' --show openoffice.org-dev)
depends=${current_version%-*}
conflicts=${depends%~*}.1

LD_LIBRARY_PATH="/usr/lib/openoffice/program" dpkg-shlibdeps -O build/oxt/*.so >$substvars 2>/dev/null
echo "misc:Conflicts=openoffice.org-core (>= $conflicts)" >>$substvars
