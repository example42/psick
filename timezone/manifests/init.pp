# Defaults to setting up the timezone to match what it's already set to. If you
# set the timezone variable for the class it will use that timezone instead.
class timezone(
  $timezone = params_lookup('timezone', 'global'),
  $hw_utc = false
  ) {

     file {
        "timezone":
#            mode => 644, owner => root, group => root,
            ensure => present,
            path => $operatingsystem ?{
                debian  => "/etc/timezone",
                ubuntu  => "/etc/timezone",
                redhat  => "/etc/sysconfig/clock",
                centos  => "/etc/sysconfig/clock",
                scientific => "/etc/sysconfig/clock",
                suse    => "/etc/sysconfig/clock",
                freebsd => "/etc/timezone-puppet",
            },

            content => $operatingsystem ?{
                  default => template("timezone/timezone-${operatingsystem}"),
            },
#            notify => Exec["set-timezone"],
    }
     
    exec {
        "set-timezone":
            command => $operatingsystem ?{
                debian  => "dpkg-reconfigure -f noninteractive tzdata",
                ubuntu  => "dpkg-reconfigure -f noninteractive tzdata",
                redhat  => "tzdata-update",
                centos  => "tzdata-update",
                scientific  => "tzdata-update",
                suse    => "FIX ME",
                freebsd => "cp /usr/share/zoneinfo/${timezone} /etc/localtime && adjkerntz -a",
            },
            require => File["timezone"],
            subscribe => File["timezone"],
            refreshonly => true,
    }

}
