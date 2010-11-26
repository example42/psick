#
# Class: rsyslog::client
#
# Manages rsyslog client
#
class rsyslog::client inherits rsyslog {

    # Load the variables used in this module. Check the params.pp file 
    require rsyslog::params

#    File["rsyslog.conf"] { 
#        content => template("rsyslog/client/rsyslog.conf.erb"),
#    }

    # Include project specific class for client if $my_project is set
    if $my_project { 
        case $my_project_onmodule {
            yes,true: { include "${my_project}::rsyslog::client" }
            default: { include "rsyslog::${my_project}::client" }
        }
    }

}

