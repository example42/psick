#
# Class: rsyslog::client
#
# Manages rsyslog client
#
class rsyslog::client inherits rsyslog {

    # Load the variables used in this module. Check the params.pp file 
    require rsyslog::params

    File["rsyslog.conf"] { 
        content => template("rsyslog/client/rsyslog.conf.erb"),
    }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "rsyslog::${my_project}::client" }

}
