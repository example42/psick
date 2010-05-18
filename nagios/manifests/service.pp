define nagios::service (
    $ensure = present,
    $host_name = $fqdn,
    $check_command,
    $check_period = '',
    $normal_check_interval = '',
    $retry_check_interval = '',
    $max_check_attempts = '',
    $notification_interval = '',
    $notification_period = '',
    $notification_options = '',
    $contact_groups = '',
    $use = 'absent',
    $service_description = 'absent' )
{

    # TODO: this resource should normally accept all nagios_host parameters

    $real_name = "${hostname}_${name}"

    @@nagios_service { "${real_name}":
    ensure => $ensure,
    check_command => $check_command,
    host_name => $host_name,
    notify => Service[nagios],
    }

    if ($check_period != '') {
    Nagios_service["${real_name}"] { check_period => $check_period }
    }

    if ($normal_check_interval != '') {
    Nagios_service["${real_name}"] { normal_check_interval => $normal_check_interval }
    }

    if ($retry_check_interval != '') {
    Nagios_service["${real_name}"] { retry_check_interval => $retry_check_interval }
    }

    if ($max_check_attempts != '') {
    Nagios_service["${real_name}"] { max_check_attempts => $max_check_attempts }
    }

    if ($notification_interval != '') {
    Nagios_service["${real_name}"] { notification_interval => $notification_interval }
    }

    if ($notification_period != '') {
    Nagios_service["${real_name}"] { notification_period => $notification_period }
    }

    if ($notification_options != '') {
    Nagios_service["${real_name}"] { notification_options => $notification_options }
    }

    if ($use == 'absent') {
    Nagios_service["${real_name}"] { use => 'generic-service' }
    } else {
    Nagios_service["${real_name}"] { use => $use }
    }

    if ($service_description == 'absent') {
    Nagios_service["${real_name}"] { service_description => $name }
    } else {
    Nagios_service["${real_name}"] { service_description => $service_description }
    }

}

