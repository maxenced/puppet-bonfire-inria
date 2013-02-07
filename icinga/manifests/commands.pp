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
        command_line => "\$USER1\$/check_by_ssh -p \$ARG4\$ -o 'StrictHostKeyChecking=no' -H \$HOSTADDRESS\$ -C '\$USER1$/check_procs -c \$ARG1$:\$ARG2\$ -C \$ARG3$'",
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

    nagios_command { 'check_ssh_mysql_sync':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG1\$ -o 'StrictHostKeyChecking=no' -H \$HOSTADDRESS\$ -C 'sudo \$USER1$/check_mysql -S -w 10 -c 120'",
        ensure       => present,
    }

    nagios_command { 'ping_palo_vpn':
        command_line => "\$USER1\$/check_ping -H 10.42.69.1 -w 100,20% -c 500,60%",
        ensure       => present,
    }

    nagios_command { 'check_ssh_nullmailer':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG3\$ -o 'StrictHostKeyChecking=no' -H \$HOSTADDRESS\$ -C  'sudo /usr/local/bin/check_nullmailer \$ARG1\$ \$ARG2$'",
        ensure       => present,
    }

    nagios_command { 'check_forum':
        command_line => "/usr/bin/wget -qO- http://forum.ubuntu-fr.org/viewtopic.php?id=385689 |/bin/grep -qs '<p><strong>Introduction</strong><br />Le'",
        ensure       => present,
    }

    nagios_command { 'check_doc':
        command_line => "\$USER1\$/check_http -H doc.ubuntu-fr.org -u 'http://doc.ubuntu-fr.org/Accueil?do=recent' -s 'Les pages suivantes ont '",
        ensure       => present,
    }

    nagios_command { 'check_www':
        command_line => "\$USER1\$/check_http -H www.ubuntu-fr.org -u 'http://www.ubuntu-fr.org/' -s 'les serveurs, les netbooks'",
        ensure       => present,
    }

    nagios_command { 'check_ssh_backup':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG1\$ -o 'StrictHostKeyChecking=no'  -H \$HOSTADDRESS\$ -C 'sudo /usr/local/bin/check_backuppc'",
        ensure       => present,
    }

    nagios_command { 'check_doc_sync':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG1\$ -o 'StrictHostKeyChecking=no'  -H \$HOSTADDRESS\$ -C 'sudo  \$USER1$/check_file_age -w 600 -c 1200 /srv/www/doc.ubuntu-fr.org/data/doc_timestamp'",
        ensure       => present,
    }

    nagios_command { 'check_forum_sync':
        command_line => "\$USER1\$/check_by_ssh -p \$ARG1\$ -o 'StrictHostKeyChecking=no'  -H \$HOSTADDRESS\$ -C 'sudo  \$USER1$/check_file_age -w 600 -c 1200 /srv/www/forum.ubuntu-fr.org/htdocs/img/avatars/forum_timestamp'",
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
}
