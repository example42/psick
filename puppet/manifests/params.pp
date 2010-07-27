class puppet::params  {

# Basic settings
    $packagename = $operatingsystem ? {
        solaris => "CSWpuppet",
        default => "puppet",
    }

    $servicename = $operatingsystem ? {
        solaris => "puppetd",
        default => "puppet",
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/puppet/puppet.conf",
        default => "/etc/puppet/puppet.conf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $configdir = $operatingsystem ? {
        freebsd => "/usr/local/etc/puppet/",
        default => "/etc/puppet",
    }

    $basedir = $operatingsystem ? {
        redhat  => "/usr/lib/ruby/site_ruby/1.8/puppet",
        centos  => "/usr/lib/ruby/site_ruby/1.8/puppet",
        default => "/usr/lib/ruby/1.8/puppet",
    }


}
