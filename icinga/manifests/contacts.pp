# == Class: icinga::contacts
#
# Add Inria Contacts for Icinga
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
class icinga::contacts {
    @nagios_contact { 'contact_maxence':
        ensure                        => present,
        alias                         => 'maxence',
        can_submit_commands           => 1,
        contactgroups                 => 'admins',
        email                         => 'maxence.dunnewind@inria.fr',
        register                      => 1,
        service_notification_period   => '24x7',
        host_notification_period      => '24x7',
        service_notification_options  => 'w,u,c,r',
        service_notification_commands => 'notify-by-email',
        host_notification_commands    => 'host-notify-by-email'
    }
    @nagios_contact { 'contact_julien':
        ensure                        => present,
        alias                         => 'julien',
        can_submit_commands           => 1,
        contactgroups                 => 'admins',
        email                         => 'julien.lefeuvre@inria.fr',
        register                      => 1,
        service_notification_period   => '24x7',
        host_notification_period      => '24x7',
        service_notification_options  => 'w,u,c,r',
        service_notification_commands => 'notify-by-email',
        host_notification_commands    => 'host-notify-by-email'
    }
} # icinga::contacts
