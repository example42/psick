class nagios::defaults::service_templates {

    # this inoperative for the moment, see :
    # http://projects.reductivelabs.com/issues/1180

    nagios_service {
    'generic-service':
        active_checks_enabled       => '1',
        passive_checks_enabled      => '1',
        parallelize_check           => '1',
        obsess_over_service         => '1',
        check_freshness         => '0',
        notifications_enabled       => '1',
        event_handler_enabled       => '1',
        flap_detection_enabled      => '1',
        failure_prediction_enabled      => '1',
        process_perf_data           => '1',
        retain_status_information       => '1',
        retain_nonstatus_information    => '1',
            notification_interval       => '0',
            is_volatile             => '0',
            check_period            => '24x7',
            normal_check_interval       => '5',
            retry_check_interval        => '1',
            max_check_attempts          => '4',
            notification_period         => '24x7',
            notification_options        => 'w,u,c,r',
            contact_groups          => 'admins',
        register            => '0',
    }

}
