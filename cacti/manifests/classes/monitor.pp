# Class: cacti::monitor
#
# Monitors cacti process and port using custom Monitor wrapper
# It's automatically included if $monitor=yes
#
# Usage:
# include cacti::monitor
#
class cacti::monitor {

    monitor::url {
        "$fqdn_cacti_url":
        url    => "http://${fqdn}/cacti",
        username => '',
        password => '',
        enabl => false,
    }

}
