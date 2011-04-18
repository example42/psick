# Class ntp::cron
#
# Runs a ntpdate every hours
#
class ntpdate::cron {

    # Load the variables used in this module. Check the params.pp file 
    require ntp::params

    package { "ntp":
        name   => "${ntp::params::packagename}",
        ensure => present,
    }

    service { "ntp":
        name       => "${ntp::params::servicename}",
        ensure     => stopped,
        enable     => false,
        require    => Package["ntp"],
    }

    file {    
             "/etc/cron.hourly/ntpdate":
            mode => 755, owner => root, group => root,
            require => Package[ntp],
            content => template("ntp/ntpdate.erb"),
    }
    
}

