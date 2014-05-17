#!/bin/bash
PACKAGENAME="openhab"
MAINTAINER="Oskar Holowaty <me@oskarholowaty.com>"
VENDOR="openHAB UG (haftungsbeschraenkt) <info@openhab.org>"
VERSION="1.4-1"
URL="http://www.openhab.org"
LICENSE="EPL v1"
DESCRIPTION="openHAB is a software for integrating different home automation systems and technologies into one single solution that allows over-arching automation rules and that offers uniform user interfaces."


ROOT=`pwd`

cd ./src
fpm -f -s dir -t deb -a all \
	-n "$PACKAGENAME" \
	-m "$MAINTAINER" \
	--vendor "$VENDOR" \
	--category "misc" \
	--license "$LICENSE" \
	-d "java7-runtime-headless | java7-runtime" \
	--url $URL \
	--description "$DESCRIPTION" \
	--after-install "${ROOT}/debian/postinst.sh" \
	--pre-uninstall "${ROOT}/debian/prerm.sh" \
	-v "$VERSION" \
	--config-files "/etc/openhab/" \
	-p "${ROOT}/${PACKAGENAME}_${VERSION}_all.deb" \
	--deb-compression "xz" \
	.
