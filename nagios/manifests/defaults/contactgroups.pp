class nagios::defaults::contactgroups {

    nagios_contactgroup {
        'admins':
            alias   => 'Nagios Administrators',
            members => 'root',
    }

}
