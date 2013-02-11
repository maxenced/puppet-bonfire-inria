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
        ensure              => present,
        alias               => 'maxence',
        can_submit_commands => 1,
        contactgroups       => 'admins',
        email               => 'maxence.dunnewind@inria.fr',
        register            => 1,
    }
    @nagios_contact { 'contact_julien':
        ensure              => present,
        alias               => 'julien',
        can_submit_commands => 1,
        contactgroups       => 'admins',
        email               => 'julien.lefeuvre@inria.fr',
        register            => 1,
    }
} # icinga::contacts
