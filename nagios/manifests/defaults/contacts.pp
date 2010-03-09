class nagios::defaults::contacts {

    nagios_contact {
        'root':
            alias                           => 'Root',
            service_notification_period     => '24x7',
            host_notification_period        => '24x7',
            service_notification_options    => 'w,u,c,r',
            host_notification_options       => 'd,r',
            service_notification_commands   => 'notify-service-by-email',
            host_notification_commands      => 'notify-host-by-email',
            email                           => 'root@localhost',
    }

}
