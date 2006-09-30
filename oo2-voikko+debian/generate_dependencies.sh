#!/bin/sh
# This script generates "Depends" and "Conflicts" fields to binary package's
# control file.

substvars=debian/openoffice.org-voikko.substvars

current_version=$(dpkg-query --showformat='${Version}\n' --show openoffice.org-dev)
current_upstream_version=$(echo $current_version | sed -e 's/-[^-]*$//;s/~[^~]*$//')

dpkg-shlibdeps -O build/pkg/Linux_x86/*.so >$substvars 2>/dev/null
cat <<EOF >>$substvars
misc:Depends=openoffice.org-core (>= $current_version)
misc:Conflicts=openoffice.org-core (>= $current_upstream_version.1)
EOF
