# Define: iptables::rule
#
# Adds a custom iptables rule 
# Supported arguments:
# $command - The iptables command to issue (default -A)
# $table - The iptables table to work on (default filter)
# $chain - The iptables chain to work on (default INPUT). Write it UPPERCASE
#          coherently with iptables syntax
# $target - The iptables target for the rule (default ACCEPT)
# $source - The packets source address (in iptables -s supported syntax, default 0/0)
# $destination - The packets destination (in iptables -d supported syntax, default 0/0)
# $protocol - The transport protocol (tcp/udp, default tcp)
# $port - The DESTINATION port 
# $order - The CONCAT order where to place your rule. By default this is automatically calculated
#          if you want to set it be sure of what you're doing and check iptables::concat to see
#          current order numbers in order to avoid building a wrong iptables rule file
# $rule - A custom iptables rule (in whatever iptables supported format). Use this as an alternative to
#         the use of the above $protocol, $port, $source and $destination parameters.
# 
# Note that s single call to iptables::rule creates a rule with the following content:
# $command $chain $true_rule -j $target       in the $table you define.
# Note that $true_rule is built in this way:
# - If $rule is defined, $true_rule == $rule
# - If not, $true_rule is "-p $protocol --dport $port -s $source -d $destination" 
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
