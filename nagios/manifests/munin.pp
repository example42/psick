class nagios::munin inherits munin::plugins::base {

    munin::plugin::deploy {
        nagios_hosts:
            source => 'nagios/munin/nagios_hosts',
            config => 'user root';
        nagios_svc:
            source => 'nagios/munin/nagios_svc',
            config => 'user root';
        nagios_perf_hosts:
            source => 'nagios/munin/nagios_perf',
            config => 'user root';
        nagios_perf_svc:
            source => 'nagios/munin/nagios_perf',
            config => 'user root';
    }

    exec { 'munin_nagios2stats_link':
        command => 'ln -s /usr/sbin/nagios2stats /usr/local/sbin/nagiostats',
        onlyif => ["test ! -e /usr/local/sbin/nagiostats", "test -e /usr/sbin/nagios2stats"],
    }

    exec { 'munin_nagios3stats_link':
        command => 'ln -s /usr/sbin/nagios3stats /usr/local/sbin/nagiostats',
        onlyif => ["test ! -e /usr/local/sbin/nagiostats", "test -e /usr/sbin/nagios3stats"],
    }

}
