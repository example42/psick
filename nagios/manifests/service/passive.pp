define nagios::service::passive(
    $ensure = present,
    $notification_interval = '',
    $notification_period = '',
    $notification_options = '',
    $contact_groups = ''
) {

    nagios::service { $name:
        use                   => 'passive-service',
        check_command         => 'check_dummy!0',
        notification_interval => $notification_interval,
        notification_period   => $notification_period,
        notification_options  => $notification_options,
        contact_groups        => $contact_groups,
    }

}
