class nagios::target::fqdn inherits nagios::target {

    Nagios_host["${fqdn}"] { address => "${fqdn}" }

}
