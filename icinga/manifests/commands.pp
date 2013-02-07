class icinga::commands {
###
# notification
###
    nagios_command { 'host-notify-by-email':
        command_line => "/usr/bin/printf '%b' \"\"\"***** Icinga *****\\n\\nNotification Type: \$NOTIFICATIONTYPE\$\\nHost: \$HOSTNAME\$\\nState: \$HOSTSTATE\$\\nAddress: \$HOSTADDRESS\$\\nInfo: \$HOSTOUTPUT\$\\n\\nDate/Time: \$LONGDATETIME\$\\n\"\"\" | /usr/bin/mail -s '** \$NOTIFICATIONTYPE\$ Host Alert: \$HOSTNAME\$ is \$HOSTSTATE\$ **' \$CONTACTEMAIL$",
        ensure       => present,
    }
    nagios_command { 'notify-by-email':
        command_line => "/usr/bin/printf '%b' \"\"\"***** Icinga *****\\n\\nNotification Type: \$NOTIFICATIONTYPE\$\\n\\nService: \$SERVICEDESC\$\\nHost: \$HOSTALIAS\$\\nAddress: \$HOSTADDRESS\$\\nState: \$SERVICESTATE\$\\n\\nDate/Time: \$LONGDATETIME\$\\n\\nAdditional Info:\\n\\n\$SERVICEOUTPUT\$\\n\"\"\" | /usr/bin/mail -s '** \$NOTIFICATIONTYPE\$ Service Alert: \$HOSTALIAS\$/\$SERVICEDESC\$ is \$SERVICESTATE\$ **' \$CONTACTEMAIL$",
        ensure       => present,
    }

###
# checks
###
    nagios_command { 'check_ssh_disk':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG3\$ -o 'StrictHostKeyChecking=no' -H \$HOSTADDRESS\$ -C '\$USER1$/check_disk -w \$ARG1\$ -c \$ARG2$'",
        ensure       => present,
    }

    nagios_command { 'check_ssh_process':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG4\$ -o 'StrictHostKeyChecking=no' -H \$HOSTADDRESS\$ -C '\$USER1$/check_procs -c \$ARG1\$:\$ARG2\$ -C \$ARG3\$'",
        ensure       => present,
    }

    nagios_command { 'check_ssh_swap':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG3\$ -o 'StrictHostKeyChecking=no' -H \$HOSTADDRESS\$ -C 'sudo \$USER1$/check_swap -w \$ARG1\$ -c \$ARG2\$'",
        ensure       => present,
    }

    nagios_command { 'check_ssh_mysql':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG1\$ -o 'StrictHostKeyChecking=no' -H \$HOSTADDRESS\$ -C 'sudo \$USER1$/check_mysql'",
        ensure       => present,
    }

    nagios_command { 'check_ssh_nullmailer':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG3\$ -o 'StrictHostKeyChecking=no' -H \$HOSTADDRESS\$ -C  'sudo /usr/local/bin/check_nullmailer \$ARG1\$ \$ARG2$'",
        ensure       => present,
    }

    nagios_command { 'check_ssh_backup':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG1\$ -o 'StrictHostKeyChecking=no'  -H \$HOSTADDRESS\$ -C 'sudo /usr/local/bin/check_backuppc'",
        ensure       => present,
    }

    nagios_command { 'check_puppet_last_run':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG1\$ -o 'StrictHostKeyChecking=no'  -H \$HOSTADDRESS\$ -C 'sudo  /bin/grep -qs changes: /var/lib/puppet/state/last_run_summary.yaml && exit 0 || exit 2'",
        ensure       => present,
    }

    nagios_command { 'check_ssh_md_raid':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG1\$ -o 'StrictHostKeyChecking=no'  -H \$HOSTADDRESS\$ -C 'sudo /usr/local/bin/check_md_raid'",
        ensure       => present,
    }

    nagios_command { 'check_tcp':
        command_line => "\$USER1\$/check_tcp -H \$HOSTADDRESS\$ -4 -p \$ARG1\$",
        ensure       => present
    }
}
