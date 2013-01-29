# == Class: megaraid::install::debian
#
# Setup MegaRAID on Debian
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
class megaraid::install::debian {

    File<| |> -> Exec['install MegaCli']

    file { '/opt/megacli_8.04.08-2_all.deb':
        ensure  => file,
        source  => 'puppet:///modules/megaraid/install/debian/megacli_8.04.08-2_all.deb',
        owner   => root,
        group   => root,
        mode    => '0664';
    }

    file { '/opt/lib-utils_1.00-10_all.deb':
        ensure  => file,
        source  => 'puppet:///modules/megaraid/install/debian/lib-utils_1.00-10_all.deb',
        owner   => root,
        group   => root,
        mode    => '0644';
    }

    $target = $::architecture ? {
        'amd64' => 'MegaCli64',
        default => 'MegaCli'
    }

    file { '/usr/sbin/MegaCli':
        ensure => link,
        target => "/opt/MegaRAID/MegaCLI/${target}"
    }

    exec { 'install MegaCli':
        command       => 'dpkg -i /opt/*deb'
    }
}
