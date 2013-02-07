# == Class: icinga::nagircbot
#
# Configure IRC bot for Icinga
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
class icinga::nagircbot {
    include monit::service::nagircbot
    file { '/usr/local/bin/nagircbot':
        ensure => present,
        source => 'puppet:///modules/icinga/nagircbot',
        mode   => '0755'
    }

    file { '/etc/init.d/nagircbot':
        ensure => present,
        source => 'puppet:///modules/icinga/nagircbot.init',
        mode   => '0755'
    }

    service { 'nagircbot':
        ensure  => running,
        require => [ File['/etc/init.d/nagircbot'], File['/usr/local/bin/nagircbot']],
    }

    package { 'libssl0.9.8':
        ensure => present
    }
}

