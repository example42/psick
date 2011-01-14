#
# Class bind::concat
#
# This class builds named.conf using RIPienaar's concat module
# We replace the OS default named.conf with a concatenamed file:
# - First path contains general options and logging info
# - Second part contains the default zones and root hints
#   (The default distro config file is used)
# - Third part contains the custom zones. These can be all placed
#   in the bind/named.conf_custom.erb template AND/OR populated
#   with the bind::zone define
#
class bind::concat {

    include bind::params
    include concat::setup

    concat { "${bind::params::configfile}":
        mode    => "${bind::params::configfile_mode}",
        owner   => "${bind::params::configfile_owner}",
        group   => "${bind::params::configfile_group}",
    }

    concat::fragment{ "named_conf_general":
        target  => "${bind::params::configfile}",
        content => template("bind/concat/named.conf.erb"),
        order   => 01,
        notify  => Service["bind"],
    }

    concat::fragment{ "named_conf_default_zones":
        target  => "${bind::params::configfile}",
        content => $operatingsystem ? {
            ubuntu => template("bind/concat/named_default_zones-debian.erb"),
            debian => template("bind/concat/named_default_zones-debian.erb"),
            redhat => template("bind/concat/named_default_zones-redhat.erb"),
            centos => template("bind/concat/named_default_zones-redhat.erb"),
        },
        order   => 03,
        notify  => Service["bind"],
    }

    concat::fragment{ "named_conf_custom_zones":
        target  => "${bind::params::configfile}",
        content => template("bind/concat/named.conf_custom.erb"),
        order   => 05,
        notify  => Service["bind"],
    }

}

