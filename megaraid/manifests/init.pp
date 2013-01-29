# == Class: megaraid
#
# Install and configure megaraid
#
# === Variables
#
# === Authors
#
# Author Name Maxence Dunnewind (<maxence@dunnewind.net>)
#
# === Copyright
#
# Copyright 2013 Maxence Dunnewind
#
class megaraid {
    case $::operatingsystem {
        /Debian/ : { include megaraid::install::debian }
        default  : { warn('Distribution not supported by megaraid module') }
    }
}
