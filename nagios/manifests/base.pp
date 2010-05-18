class nagios::base {

    package { 'nagios':
    alias => 'nagios',
    ensure => present,   
    }

    service { 'nagios':
    ensure => running,
    enable => true,
    #hasstatus => true, #fixme!
    require => Package['nagios'],
    }

    # this file should contain all the nagios_puppet-paths:
    file { 'nagios_main_cfg':
        path => "${nagios_cfgdir}/nagios.cfg",
#        source => [ "puppet://$server/modules/site-nagios/configs/${fqdn}/nagios.cfg",
#            "puppet://$server/modules/site-nagios/configs/${operatingsystem}/nagios.cfg",
#            "puppet://$server/modules/site-nagios/configs/nagios.cfg",
#            "puppet://$server/modules/nagios/configs/${operatingsystem}/nagios.cfg",
#            "puppet://$server/modules/nagios/configs/nagios.cfg" ],
        notify => Service['nagios'],
        mode => 0644, owner => root, group => root;
    }    

    file { 'nagios_cgi_cfg':
    path => "${nagios_cfgdir}/cgi.cfg",
#    source => [ "puppet://$server/modules/site-nagios/configs/${fqdn}/cgi.cfg",
#            "puppet://$server/modules/site-nagios/configs/${operatingsystem}/cgi.cfg",
#            "puppet://$server/modules/site-nagios/configs/cgi.cfg",
#            "puppet://$server/modules/nagios/configs/${operatingsystem}/cgi.cfg",
#            "puppet://$server/modules/nagios/configs/cgi.cfg" ],
    mode => '0644', owner => 'root', group => 0,
    notify => Service['apache'],
    }

    file { 'nagios_htpasswd':
    path => "${nagios_cfgdir}/htpasswd.users",
#    source => [ "puppet://$server/modules/site-nagios/htpasswd.users",
#            "puppet://$server/modules/nagios/htpasswd.users" ],
    mode => 0640, owner => root, group => apache;
    }

    file { 'nagios_private':
    path => "${nagios_cfgdir}/private/",
    source => "puppet://$server/modules/common/empty",
    ensure => directory,
    purge => true,
    recurse => true,
    notify => Service['nagios'],
    mode => '0750', owner => root, group => nagios;
    }

    file { 'nagios_private_resource_cfg':
    path => "${nagios_cfgdir}/private/resource.cfg",
#    source => "puppet://$server/nagios/configs/${operatingsystem}/private/resource.cfg.${architecture}",
    notify => Service['nagios'],
    owner => root, group => nagios, mode => '0640';
    }

    file { 'nagios_confd':
    path => "${nagios_cfgdir}/conf.d/",
    source => "puppet://$server/modules/common/empty",
    ensure => directory,
    purge => true,
    recurse => true,
    notify => Service['nagios'],
    mode => '0750', owner => root, group => nagios;
    }

    Nagios_command <<||>>
    Nagios_contact <<||>>
    Nagios_contactgroup <<||>>
    Nagios_host <<||>>
    Nagios_hostextinfo <<||>>
    Nagios_hostgroup <<||>>
    Nagios_hostgroupescalation <<||>>
    Nagios_service <<||>>
    Nagios_servicedependency <<||>>
    Nagios_serviceescalation <<||>>
    Nagios_serviceextinfo <<||>>
    Nagios_timeperiod <<||>>

    Nagios_command <||> {
    target => "${nagios_cfgdir}/conf.d/nagios_command.cfg",
    notify => Service['nagios'],
    }
    Nagios_contact <||> {
    target => "${nagios_cfgdir}/conf.d/nagios_contact.cfg",
    notify => Service['nagios'],
    }
    Nagios_contactgroup <||> {
    target => "${nagios_cfgdir}/conf.d/nagios_contactgroup.cfg",
    notify => Service['nagios'],
    }
    Nagios_host <||> {
    target => "${nagios_cfgdir}/conf.d/nagios_host.cfg",
    notify => Service['nagios'],
    }
    Nagios_hostextinfo <||> {
    target => "${nagios_cfgdir}/conf.d/nagios_hostextinfo.cfg",
    notify => Service['nagios'],
    }
    Nagios_hostgroup <||> {
    target => "${nagios_cfgdir}/conf.d/nagios_hostgroup.cfg",
    notify => Service['nagios'],
    }
    Nagios_hostgroupescalation <||> {
    target => "${nagios_cfgdir}/conf.d/nagios_hostgroupescalation.cfg",
    notify => Service['nagios'],
    }
    Nagios_service <||> {
    target => "${nagios_cfgdir}/conf.d/nagios_service.cfg",
    notify => Service['nagios'],
    }
    Nagios_servicedependency <||> {
    target => "${nagios_cfgdir}/conf.d/nagios_servicedependency.cfg",
    notify => Service['nagios'],
    }
    Nagios_serviceescalation <||> {
    target => "${nagios_cfgdir}/conf.d/nagios_serviceescalation.cfg",
    notify => Service['nagios'],
    }
    Nagios_serviceextinfo <||> {
    target => "${nagios_cfgdir}/conf.d/nagios_serviceextinfo.cfg",
    notify => Service['nagios'],
    }
    Nagios_timeperiod <||> {
    target => "${nagios_cfgdir}/conf.d/nagios_timeperiod.cfg",
    notify => Service['nagios'],
    }

    file{[ "${nagios_cfgdir}/conf.d/nagios_command.cfg", 
       "${nagios_cfgdir}/conf.d/nagios_contact.cfg", 
       "${nagios_cfgdir}/conf.d/nagios_contactgroup.cfg",
       "${nagios_cfgdir}/conf.d/nagios_host.cfg",
       "${nagios_cfgdir}/conf.d/nagios_hostextinfo.cfg",
       "${nagios_cfgdir}/conf.d/nagios_hostgroup.cfg",
       "${nagios_cfgdir}/conf.d/nagios_hostgroupescalation.cfg",
       "${nagios_cfgdir}/conf.d/nagios_service.cfg",
       "${nagios_cfgdir}/conf.d/nagios_servicedependency.cfg",
       "${nagios_cfgdir}/conf.d/nagios_serviceescalation.cfg",
       "${nagios_cfgdir}/conf.d/nagios_serviceextinfo.cfg",
       "${nagios_cfgdir}/conf.d/nagios_timeperiod.cfg" ]:
    ensure => file,
    replace => false,
    notify => Service['nagios'],
    mode => 0644, owner => root, group => 0;
    }

    # manage nagios cfg files
    # must be defined after exported resource overrides and cfg file defs
    file { 'nagios_cfgdir':
    path => "${nagios_cfgdir}/",
    source => "puppet://$server/modules/common/empty",
    ensure => directory,
    recurse => true,
    purge => true,
    notify => Service['nagios'],
    mode => 0755, owner => root, group => root;
    }


}
