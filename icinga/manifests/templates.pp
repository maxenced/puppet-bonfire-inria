# == Class: icinga::templates
#
# Common templates for Incinga (host and services)
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
class icinga::templates {
# Generic service definition template
    nagios_service{ 'generic-service':
        register                     => '0',
        name                         => 'generic-service',
        active_checks_enabled        => '1',
        passive_checks_enabled       => '1',
        parallelize_check            => '1',
        obsess_over_service          => '1',
        check_freshness              => '1',
        notifications_enabled        => '1',
        event_handler_enabled        => '1',
        flap_detection_enabled       => '1',
        process_perf_data            => '1',
        retain_status_information    => '1',
        retain_nonstatus_information => '1',
        notification_interval        => '1440',
        notification_period          => '24x7',
        notification_options         => 'w,u,c,r',
        contact_groups               => 'admins',
        check_period                 => '24x7',
        max_check_attempts           => '3',
        retry_check_interval         => '1'
    }

    nagios_host { 'generic-host':
        name                  => 'generic-host',
        check_command         => 'check-host-alive',
        active_checks_enabled => '1',
        max_check_attempts    => '10',
        notification_interval => '1440',
        notification_period   => '24x7',
        notification_options  => 'd',
        register              => '0',
    }
}

