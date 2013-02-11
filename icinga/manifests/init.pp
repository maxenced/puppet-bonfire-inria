# The main icinga monitor class
class icinga {
    include icinga::commands
    include icinga::templates
    include icinga::timeperiods
    include icinga::contacts
    include icinga::itarget
    include apache

    package { 'icinga':
        ensure => installed;
    }

    service { 'icinga':
        ensure     => running,
        hasstatus  => true,
        hasrestart => false,
        subscribe  => [ File [ '/etc/icinga/icinga.cfg' ], File['/var/lib/icinga/rw/icinga.cmd'] ],
        start      => 'chmod 644 /etc/icinga/*.cfg;icinga -v /etc/icinga/icinga.cfg && service icinga start',
    }

    file { '/etc/apache2/conf.d/icinga.conf':
        ensure  => file,
        content => template('icinga/apache2.conf.erb'),
        notify  => Service['apache2']
    }

    file { '/etc/nagios':
        ensure  => link,
        require => Package['icinga'],
        target  => '/etc/icinga';
# disable default debian configurations
        [ '/etc/icinga/localhost.cfg',
          '/etc/icinga/timeperiods.cfg',
          '/etc/icinga/services.cfg' ]:
        ensure => present,
        mode   => '0644',
        owner  => 'nagios',
        notify => Service[icinga];
        '/etc/icinga/hostgroups.cfg':
        source => 'puppet:///modules/icinga/hostgroups_nagios.cfg',
        mode   => '0644',
        owner  => nagios,
        group  => nagios,
        notify => Service[icinga];
# permit external commands from the CGI
        '/etc/icinga':
        ensure => directory,
        mode   => '2755',
        owner  => nagios,
        group  => nagios,
        notify => Service[icinga];
        '/etc/icinga/stylesheets':
        ensure  => directory,
        mode    => '0755',
        require => File['/etc/icinga'],
        recurse => true,
        purge   => true,
        source  => 'puppet:///modules/icinga/stylesheets';
        '/var/cache/icinga':
        ensure  => directory,
        mode    => '0750',
        owner   => nagios,
        group   => www-data,
        recurse => true,
        notify  => Service[icinga];
        '/var/lib/icinga/rw':
        ensure => directory,
        mode   => '2775',
        owner  => nagios,
        group  => www-data,
        notify => Service[icinga];
        ['/var/lib/icinga/', '/var/lib/icinga/spool']:
        ensure => directory,
        mode   => '0750',
        owner  => nagios,
        group  => www-data,
        notify => Service[icinga];
        '/var/lib/icinga/rw/icinga.cmd':
        ensure => present,
        mode   => '0660',
        owner  => nagios,
        group  => www-data;
        '/etc/icinga/resource.cfg':
        ensure => file,
        source => 'puppet:///modules/icinga/resource.cfg',
        owner  => nagios,
        group  => nagios,
        mode   => '0644';
        '/etc/icinga/generic.cfg':
        ensure => file,
        source => 'puppet:///modules/icinga/generic.cfg',
        owner  => nagios,
        group  => nagios,
        mode   => '0644';
        '/etc/icinga/cgi.cfg':
        ensure  => file,
        content => template('icinga/cgi.cfg.erb'),
        owner   => nagios,
        group   => nagios,
        mode    => '0644';
        '/etc/icinga/icinga.cfg':
        ensure => file,
        source => 'puppet:///modules/icinga/icinga.cfg',
        owner  => nagios,
        group  => nagios,
        mode   => '0644';
        '/var/lib/nagios/.ssh/id_rsa':
        ensure  => present,
        mode    => '0600',
        owner   => nagios,
        group   => nagios,
        content => file('/etc/puppet/secrets/icinga.priv');
    }

    nagios_contactgroup { 'admins':
        ensure            => present,
        alias             => 'admins',
        contactgroup_name => 'admins',
    }

    file { '/etc/icinga/contactgroups.cfg':
        ensure  => present,
        owner   => nagios,
        group   => nagios,
        mode    => '0644',
        require => [User['nagios'], Nagios_contactgroup['admins']]
    }

    file { '/etc/icinga/commands.cfg':
        ensure  => present,
        owner   => nagios,
        mode    => '0644',
        require => [User['nagios'], Nagios_contactgroup['admins']]
    }


# import the various definitions
    Nagios_host    <<| |>> { notify +> Service['icinga'] }
    Nagios_service <<| |>> { notify +> Service['icinga'] }
    Nagios_contact  <| |> { notify +> Service['icinga'] }

}

