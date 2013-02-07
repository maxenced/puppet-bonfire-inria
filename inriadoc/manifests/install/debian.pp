# == Class: inriadoc::install::debian
#
# Setup Sphinx for Debian
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
class inriadoc::install::debian {
    package {'python-sphinx':
        ensure => present
    }
    file { '/srv/inriadoc/':
        ensure => directory
    }
}
