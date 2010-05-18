class munin::client::darwin {
    file { "/usr/share/snmp/snmpd.conf": 
        mode => 744,
        content => template("munin/darwin_snmpd.conf.erb"),
        group  => 0,
        owner  => root,
    }
    delete_matching_line{"startsnmpdno":
        file => "/etc/hostconfig",
        pattern => "SNMPSERVER=-NO-",
    }
    line { "startsnmpdyes":
        file => "/etc/hostconfig",
        line => "SNMPSERVER=-YES-",
        notify => Exec["/sbin/SystemStarter start SNMP"],
    }
    exec{"/sbin/SystemStarter start SNMP":
        noop => false,
    } 
    munin::register_snmp { $fqdn: }
}
