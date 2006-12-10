#!/bin/sh
# This script generates "Depends" and "Conflicts" fields to binary package's
# control file.

substvars=debian/openoffice.org-voikko.substvars

current_version=$(dpkg-query --showformat='${Version}\n' --show openoffice.org-dev)
depends=${current_version%-*}
conflicts=${depends%%.dfsg*}
conflicts=${conflicts%~*}.1

#LD_LIBRARY_PATH="/usr/lib/openoffice/program" dpkg-shlibdeps -O build/pkg/Linux_*/*.so >$substvars 2>/dev/null
# In Ubuntu Dapper LD_LIBRARY_PATH does not help us to get correct dependencies
# for openoffice.org-core. We must insert it manually.
dpkg-shlibdeps -O build/pkg/Linux_*/*.so >$substvars 2>/dev/null
cat <<EOF >>$substvars
misc:Depends=openoffice.org-core (>= $depends)
misc:Conflicts=openoffice.org-core (>= $conflicts)
EOF
