#!/bin/sh
# postinst script for test
#
# see: dh_installdeb(1)

set -e

# summary of how this script can be called:
#        * <postinst> `configure' <most-recently-configured-version>
#        * <old-postinst> `abort-upgrade' <new version>
#        * <conflictor's-postinst> `abort-remove' `in-favour' <package>
#          <new-version>
#        * <postinst> `abort-remove'
#        * <deconfigured's-postinst> `abort-deconfigure' `in-favour'
#          <failed-install-package> <version> `removing'
#          <conflicting-package> <version>
# for details, see http://www.debian.org/doc/debian-policy/ or
# the debian-policy package

case "$1" in
    configure)
		groupadd openhab >/dev/null 2>&1
		useradd -s /sbin/nologin -g openhab -d /opt/openhab openhab >/dev/null 2>&1
		chown -R openhab:openhab /opt/openhab
        
        mkdir -p /var/log/openhab >/dev/null 2>&1
        chgrp -R openhab /var/log/openhab >/dev/null 2>&1
        chmod -R g+w /var/log/openhab >/dev/null 2>&1

        ln -s /var/log/openhab /opt/openhab/logs >/dev/null 2>&1
        ln -s /etc/openhab /opt/openhab/etc >/dev/null 2>&1
    ;;

    abort-upgrade|abort-remove|abort-deconfigure)

    ;;

    *)
        echo "postinst called with unknown argument \`$1'" >&2
        exit 1
    ;;
esac

# dh_installdeb will replace this with shell code automatically
# generated by other debhelper scripts.

#DEBHELPER#

exit 0