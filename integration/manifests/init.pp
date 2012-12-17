# == Class: integration
#
# Manage some scripts for integration platform
# Setup libvirt with KVM
#
# === Variables
#
# === Authors
#
# Author Name Maxence Dunnewind (<maxence@dunnewind.net>)
#
# === Copyright
#
# Copyright 2012 Maxence Dunnewind
#
class integration {

    package { ['libvirt-bin','virt-manager','qemu-kvm']:
        ensure => present
    }

    file { '/usr/local/bin/reset_vm.sh':
        ensure => present,
        source => 'puppet:///modules/integration/reset_vm.sh',
        mode   => '0755'
    }
}
