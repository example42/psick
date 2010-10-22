class nagios::defaults::templates {
    case $operatingsystem {
    'debian': {
        $nagios_cfgdir = '/etc/nagios3'
    }
    default: { $nagios_cfgdir = '/etc/nagios' }
    }

    file { 'nagios_templates':
        path => "${nagios_cfgdir}/conf.d/nagios_templates.cfg",
        source => [ "puppet://$server/modules/nagios/configs/${operatingsystem}/nagios_templates.cfg",
            "puppet://$server/modules/nagios/configs/nagios_templates.cfg" ],
        notify => Service['nagios'],
        mode => 0644, owner => root, group => root;
    }

}
