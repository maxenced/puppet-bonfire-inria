# == Class: icinga::raid
#
# Setup raid monitoring
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
class icinga::raid {
    @@nagios_service { "check_md_raid_${::fqdn}":
        check_command       => "check_ssh_md_raid!${::ssh_port}",
        use                 => 'generic-service',
        host_name           => $::fqdn,
        notification_period => '24x7',
        service_description => "check_md_raid_${::fqdn}",
    }
}

