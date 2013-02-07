# == Class: inriadoc
#
# Module to generate infrastructure documentation at INRIA
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
class inriadoc {
    case $::operatingsystem {
        /Debian/ : { include inriadoc::install::debian }
        default  : { err('Distribution not supported yet.') }
    }

    file { '/srv/inriadoc/':
        ensure => directory
    }

    file { '/srv/inriadoc/src':
        source  => 'puppet:///modules/inriadoc/src',
        recurse => true
    }

    file { '/srv/inriadoc/src/source':
        source  => 'puppet:///modules/inriadoc/src',
        recurse => true
    }

}
