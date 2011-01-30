# Class: iptables::params
#
# Sets internal variables and defaults for iptables module
# This class is loaded in all the classes that use the values set here 
#
class iptables::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

# Define how you want to manage iptables configuration:
# "file" - To provide iptables rules as a normal file
# "concat" - To build them up using different fragments
#          - This option, set as default, permits the use of the iptables::rule define
#          - and many other funny things
    $config = $iptables_config ? {
        "file"  => "file",
        default => "concat",
    }

# Define what to do with unknown packets
    $block_policy = $iptables_block_policy ? {
        "drop"    => "DROP",
        "DROP"    => "DROP",
        "reject"  => "REJECT --reject-with icmp-host-prohibited",
        "REJECT"  => "REJECT --reject-with icmp-host-prohibited",
        "accept"  => "ACCEPT",
        "ACCEPT"  => "ACCEPT",
        default   => "DROP",
    }

# Define what to do with icmp packets (quick'n'dirty approach)
    $icmp_policy = $iptables_icmp_policy ? {
        "drop"    => "-j DROP",
        "DROP"    => "-j DROP",
        "safe"    => "-m icmp --icmp-type ! echo-request -j ACCEPT",
        "accept"  => "-j ACCEPT",
        "ACCEPT"  => "-j ACCEPT",
        default   => "-j ACCEPT",
    }

# Define what to do with output packets 
    $output_policy = $iptables_output_policy ? {
        "drop"    => "drop",
        "DROP"    => "drop",
        default   => "accept",
    }

## Define what packets to log
    $log = $iptables_log ? {
        "all"     => "all",
        "dropped" => "drop",
        "none"    => "no",
        "no"      => "no",
        default   => "drop",
    }

# Define the Level of logging (numeric or see syslog.conf(5)) 
    $log_level = $iptables_log_level ? {
        ""      => "4",
        default => $iptables_log_level,
    }

# Define if you want to open SSH port by default
    $safe_ssh = $iptables_safe_ssh ? {
        "no"    => "no",
        "false" => "no",
        false   => "no",
        default => "yes",
    }

## EXTRA MODULE INTERNAL VARIABLES
#(add here module specific internal variables)


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "iptables",
    }

    $servicename = $operatingsystem ? {
        debian  => "iptables-persistent",
        ubuntu  => "iptables-persistent",
        default => "iptables",
    }

    $hasstatus = $operatingsystem ? {
        default => true,
    }

    $configfile = $operatingsystem ? {
        debian  => "/etc/iptables/rules",
        ubuntu  => "/etc/iptables/rules",
        redhat  => "/etc/sysconfig/iptables",
        centos  => "/etc/sysconfig/iptables",
    }

    $configfile_mode = $operatingsystem ? {
        default => "640",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }


    # If iptables process monitoring is enabled 
    $monitor_process_enable = $iptables_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        },
        default => $iptables_monitor_process,
    }

    # If iptables plugin monitoring is enabled 
    $monitor_plugin_enable = $iptables_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => false,
           default => $monitor_plugin,
        },
        default => $iptables_monitor_plugin,
    }


    ## FILE SERVING SOURCE
    case $base_source {
        '': {
            $general_base_source = $puppetversion ? {
                /(^0.25)/ => "puppet:///modules",
                /(^0.)/   => "puppet://$servername",
                default   => "puppet:///modules",
            }
        }
        default: { $general_base_source=$base_source }
    }

}
