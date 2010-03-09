# manifests/target.pp

class nagios::target {

    @@nagios_host { "${fqdn}":
        address => $ipaddress,
        alias => $hostname,
        use => 'generic-host',
    }

    if ($nagios_parents != '') {
        Nagios_host["${fqdn}"] { parents => $nagios_parents }
    }

}
