class munin::host::cgi {
    exec{'set_modes_for_cgi':
    command => 'chgrp apache /var/log/munin /var/log/munin/munin-graph.log && chmod g+w /var/log/munin /var/log/munin/munin-graph.log && find /var/www/html/munin/* -maxdepth 1 -type d -exec chgrp -R apache {} \; && find /var/www/html/munin/* -maxdepth 1 -type d -exec chmod -R g+w {} \;',
    refreshonly => true,
    subscribe => File['/etc/munin/munin.conf.header'],
    }

    file{'/etc/logrotate.d/munin':
    source => [ "puppet://$server/modules/site-munin/config/host/${fqdn}/logrotate",
            "puppet://$server/modules/site-munin/config/host/logrotate.$operatingsystem",
            "puppet://$server/modules/site-munin/config/host/logrotate",
            "puppet://$server/modules/munin/config/host/logrotate.$operatingsystem",
            "puppet://$server/modules/munin/config/host/logrotate" ],
    owner => root, group => 0, mode => 0644;
    }
}
