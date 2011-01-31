# Experimental firewall define to abstract firewalling rules from the actual 
# firewalling tool to use.
# Currently only the "iptables# tool is supported, which makes use of Example42's
# iptables module for host based local firewalling
#
define firewall (
    $source="",
    $destination="",
    $protocol="",
    $port="",
    $action="",
    $direction="",
    $tool="iptables",
    $enable="true"
    ) {

    if ( $debug == "yes" ) or ( $debug == true ) {
        require puppet::params
        require puppet::debug 
    }

    if ($tool =~ /iptables/) {
        iptables::rule { "$name":
            chain   => $direction ? {
                "output" => "OUTPUT",             
                default  => "INPUT",
            },
            target  => $action ? {
                "deny"  => "DROP",             
                default => "ACCEPT",
            }, 
            source      => $source,
            destination => $destination,
            protocol    => $protocol,
            port        => $port,
            enable      => $enable,
        }
    }

}
