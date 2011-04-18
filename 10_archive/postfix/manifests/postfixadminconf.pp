# Define postfixadmin::conf
#
# General PostfixAdmin php configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# postfixadmin::conf    { "database_hostmynetworks":  value => "localhost" }
#
define postfix::postfixadminconf ($value,$quote="yes") {

    require postfix::params
    
    config { "postfixadmin_conf_$name":
        file    => "${postfix::params::postfixadminconf}",
        line    => $quote ? {
            no    => "\$CONF['${name}'] = ${value}; # Modified by Puppet",
            default => "\$CONF['${name}'] = '${value}'; # Modified by Puppet",
            },
        pattern   => "^\$CONF*${name}",
        # pattern   => "^\$CONF['${name}",
        engine    => "replaceline",
        require   => File["postfixadminconf"],
        source    => "postfixadmin::conf",
    }

}
