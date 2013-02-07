# == Class: icinga::web
#
# Setup Icinga Web interface
# This is not the default nagios-like interface, but the much more complex one.
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
class icinga::web {
    apache2::server
    include mysql::server
    package {
        ['php5', 'php5-mysql', 'libapache2-mod-php5', 'php-pear','wget', 'build-essential']:
        ensure => latest
    }

    mysql_database { 'icinga' :
        ensure => present
    }

    mysql_user { 'icinga@%':
        ensure        => present,
        password_hash => mysql_password('Ifeexie5'),
    }

    mysql_grant {
        'icinga@127.0.0.1/icinga':
            privileges => all
    }

    exec { 'dl icingaweb':
        command => 'wget -O icinga-web.tgz http://downloads.sourceforge.net/project/icinga/icinga-web/1.5.1/icinga-web-1.5.1.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Ficinga%2Ffiles%2Ficinga-web%2F1.5.1%2F&ts=1314631835&use_mirror=garr',
        unless  => '[ -f "/tmp/icinga-web.tgz" ]',
        cwd     => '/tmp',
        require => Package['wget']
    }
    exec { 'extract icingaweb':
        require => Exec['dl icingaweb'],
        command => '/bin/tar -C /tmp -xzf icinga-web.tgz',
        cwd     => '/tmp',
        creates => '/tmp/icinga-web-1.5.1'
    }
    exec { 'configure icingaweb':
        require => Exec ['extract icingaweb'],
        command => "echo 0 ||./configure --with-db-user=icinga --with-db-name=icinga --with-db-pass='Ifeexie5' --with-db-socket=/var/run/mysqld/mysql.sock --with-api-cmd-file=/var/lib/icinga/rw/icinga.cmd --prefix=/var/www/icinga-web",
        cwd     => '/tmp/icinga-web-1.5.1'
    }
    exec { 'make':
        require => Exec['configure icingaweb'],
        command => 'make install',
        cwd     => '/tmp/icinga-web-1.5.1'
    }
    exec { 'make db-initialize':
        require => [Mysql_grant['icinga@127.0.0.1/icinga'], Mysql_user['icinga@%'], Mysql_database['icinga'],Exec['make']],
        cwd     => '/tmp/icinga-web-1.5.1'
    }

}
