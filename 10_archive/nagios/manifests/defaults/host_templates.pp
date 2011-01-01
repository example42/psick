class nagios::defaults::host_templates {

    # this inoperative for the moment, see :
    # http://projects.reductivelabs.com/issues/1180

    nagios_host {
    'generic-host':
        notifications_enabled       => '1',
        event_handler_enabled       => '1',
        flap_detection_enabled      => '1',
        failure_prediction_enabled      => '1',
        process_perf_data           => '1',
        retain_status_information       => '1',
        retain_nonstatus_information    => '1',
            check_command           => 'check-host-alive',
            max_check_attempts          => '10',
            notification_interval       => '0',
            notification_period         => '24x7',
            notification_options        => 'd,u,r',
            contact_groups          => 'admins',
        register            => '0',
    }

}
