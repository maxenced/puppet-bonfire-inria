# == Class: icinga::timeperiods
#
# Define common time periods
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
class icinga::timeperiods {
    nagios_timeperiod { '24x7':
        name      => '24x7',
        alias     => '24 Hours A Day, 7 Days A Week',
        sunday    => '00:00-24:00',
        monday    => '00:00-24:00',
        tuesday   => '00:00-24:00',
        wednesday => '00:00-24:00',
        thursday  => '00:00-24:00',
        friday    => '00:00-24:00',
        saturday  => '00:00-24:00'
    }
    nagios_timeperiod { 'working_hours':
        name      => 'working_hours',
        alias     => 'Normal working hours',
        monday    => '09:00-17:00',
        tuesday   => '09:00-17:00',
        wednesday => '09:00-17:00',
        thursday  => '09:00-17:00',
        friday    => '09:00-17:00'
    }
    nagios_timeperiod { 'non_working_hours':
        name      => 'nonworkhours',
        alias     => 'Non-Work hours',
        sunday    => '00:00-24:00',
        monday    => '00:00-09:00:17:00-24:00',
        tuesday   => '00:00-09:00:17:00-24:00',
        wednesday => '00:00-09:00:17:00-24:00',
        thursday  => '00:00-09:00:17:00-24:00',
        friday    => '00:00-09:00:17:00-24:00',
        saturday  => '00:00-24:00'
    }
}
