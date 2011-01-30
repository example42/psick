# Define: iptables::rule
#
# Adds a custom iptables rule 
#
define iptables::rule (
    $command="-A",
    $table="filter",
    $chain="INPUT",
    $target="ACCEPT",
    $source="0/0",
    $destination="0/0",
    $protocol="tcp",
    $port="",
    $order="",
    $rule="",
    $enable="yes" ) {

    include iptables::params
    include concat::setup

    # If (concat) order is not defined we find out the right one
    $true_order = $order ? { 
        ""      => $table ? {
            "filter" => $chain ? {
                 "INPUT"   => "15",
                 "OUTPUT"  => "25",
                 "FORWARD" => "35",
            },
            "nat"    => "50",
            "mangle" => "60",
        },
        default => $order,
    }

    # We build the rule if not explicitely set
    $true_rule = $rule ? {
         ""      => "-p $protocol --dport $port -s $source -d $destination",
         default => $rule,
    }

    $ensure = $enable ? {
        "false" => "absent",
        "no"    => "absent",
        "true"  => "present",
        "yes"   => "present",
    }

    concat::fragment{ "iptables_rule_$name":
        target  => "${iptables::params::configfile}",
        content => "$command $chain $true_rule -j $target\n",
        order   => $true_order,
        ensure  => $ensure,
        notify  => Service["iptables"],
    }

}
