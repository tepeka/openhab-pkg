openhab deb package
=======

This package ist hosted on the lxccu repostory.

== How to install

# install lxccu repo
wget -O ./lxccu-repo.deb http://www.lxccu.com/latest-repo.php
dpkg -i ./lxccu-repo.deb
apt-get update

# install openhab
apt-get install openhab

== Install without repository

== Requirements
FPM project from https://rubygems.org/gems/fpm

== Build package
git clone https://github.com/bullshit/openhab-deb.git
cd openhab-deb
bash build.sh
dpkg -i openhab_*.deb