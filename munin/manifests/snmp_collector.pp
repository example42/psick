class munin::snmp_collector{
    file { 
        "/var/lib/puppet/modules/munin/create_snmp_links":
            source => "puppet://$server/modules/munin/create_snmp_links.sh",
            mode => 755, owner => root, group => 0;
    }

    exec { "create_snmp_links":
        command => "/var/lib/puppet/modules/munin/create_snmp_links /var/lib/puppet/modules/munin/nodes",
        require => File["snmp_links"],
        timeout => "2048",
        schedule => daily
    }
}
