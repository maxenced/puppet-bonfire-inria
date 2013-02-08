# == Class: icinga::itarget
#
# Configure hosts to be checked by icinga
#
# === Variables
#
# === Authors
#
# Author Name Maxence Dunnewind (<maxence@dunnewind.net>)
#
# === Copyright
#
# Copyright '0201'3 Maxence Dunnewind
#
class icinga::itarget {

    include sudo

    user { 'nagios':
        ensure   => 'present',
        uid      => '366',
        gid      => '366',
        home     => '/var/lib/nagios',
        shell    => '/bin/bash',
        require  => Group['nagios']
    }

    group { 'nagios':
        ensure => 'present',
        gid    => '366'
    }

    case $::operatingsystem {
        debian: {
            package {
                [ 'nagios-plugins', 'nsca', 'nagios-plugins-basic']:
                    ensure => installed,
            }
        }
        ubuntu: {
            package {
                [ 'nagios-plugins-basic', 'nsca', 'nagios-plugins-extra','nagios-plugins-standard']:
                    ensure => installed,
            }
        }
        default: {
            fail('Distribution not supported')
        }
    }

    file {
        '/var/lib/nagios/':
            ensure  => directory,
            mode    => '0755',
            owner   => nagios,
            group   => nagios,
            require => User['nagios'];
        '/var/lib/nagios/.ssh':
            ensure => directory,
            mode   => '0700',
            owner  => nagios,
            group  => nagios;
        '/var/lib/nagios/.ssh/authorized_keys':
            ensure  => present,
            mode    => '0600',
            owner   => nagios,
            group   => nagios,
            content => file('/etc/puppet/secrets/icinga.pub');
        '/usr/local/bin/check_md_raid':
            ensure => file,
            source => 'puppet:///modules/icinga/bin/check_md_raid',
            mode   => '0755';
    }
    @@nagios_host { $::fqdn:
        ensure         => present,
        alias          => $::fqdn,
        address        => $::fqdn,
        use            => 'generic-host', ##
        contact_groups => 'admins'
    }
    @@nagios_service { "check_ping_${::fqdn}":
        check_command       => 'check_ping!250.0,20%!500.0,60%',
        use                 => 'generic-service',
        host_name           => $::fqdn,
        notification_period => '24x7',
        service_description => 'check_ping',
    }
    @@nagios_service { "check_ssh_${::fqdn}":
        check_command       => 'check_ssh',
        use                 => 'generic-service',
        host_name           => $::fqdn,
        notification_period => '24x7',
        service_description => 'check_ssh',
    }
    @@nagios_service { "check_disk_${::fqdn}":
        check_command       => "check_ssh_disk!5%!2%!${::ssh_port}",
        use                 => 'generic-service',
        host_name           => $::fqdn,
        notification_period => '24x7',
        service_description => "check_disk_${::fqdn}",
    }
    @@nagios_service { "check_puppet_last_run_${::fqdn}":
        check_command       => "check_puppet_last_run!${::ssh_port}",
        use                 => 'generic-service',
        host_name           => $::fqdn,
        notification_period => '24x7',
        service_description => 'Status of last puppet run',
    }

    sudo::directive { '00_nagios_sudo':
        ensure  => present,
        content => 'Cmnd_Alias NAGIOS_CMDS = /usr/lib/nagios/plugins/check_mysql, /usr/local/bin/check_nullmailer, /usr/local/bin/check_backuppc, /usr/lib/nagios/plugins/check_file_age, /bin/grep, /usr/lib/nagios/plugins/check_swap, /usr/local/bin/check_md_raid\nnagios ALL=(root) NOPASSWD: NAGIOS_CMDS'
    }
}
