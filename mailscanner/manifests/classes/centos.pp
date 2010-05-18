# Class: mailscanner::redhat
#
# Centos/RedHat fix for clamd installed via Epel
#
class mailscanner::redhat {

# Pork Around to manage EPEL multiple instances clamd delirium
    file {
        "clamd.socket":
        ensure  => "/var/run/clamd.default/clamd.sock",
        path    => "/tmp/clamd.socket",
    }
}

