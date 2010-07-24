class puppet::dashboard inherits puppet::master {

# Puppet Base directory

$puppet_basedir = $operatingsystem ? {
    default => "/usr/lib/ruby/1.8/puppet",
    "CentOs" => "/usr/lib/ruby/site_ruby/1.8/puppet",
    "RedHat" => "/usr/lib/ruby/site_ruby/1.8/puppet",
}


    include mysql
    
    $puppet_dashboard_basedir = "/opt" 

    File["puppet.conf"] {
            content => template("puppet/dashboard/puppet.conf.erb"),
            notify  => Service["puppetmaster"],
    }

    git::clone {
        "puppet-dashboard":
            url => "git://github.com/reductivelabs/puppet-dashboard.git",
            path => $puppet_dashboard_basedir,
    }
    
# Note: puppet-dashboard report lib is installed directory in $puppet_basedir/reports for 0.24 compliance
    file {
        "puppet-dashboard.rb":
            ensure => "$puppet_dashboard_basedir/puppet-dashboard/lib/puppet/puppet_dashboard.rb",
            path   => "$puppet_basedir/reports/puppet_dashboard.rb",
    }

    exec {
        "install-puppet-dashboard":
            command => "rake install",
            cwd => "$puppet_dashboard_basedir/puppet-dashboard",
            creates => "$puppet_dashboard_basedir/puppet-dashboard/config/database.yml",
    }

}

class puppet::dashboard::externalnodes inherits puppet::dashboard {

    File["puppet.conf"] {
            content => template("puppet/dashboard/externalnodes/puppet.conf.erb"),
            notify  => Service["puppetmaster"],
    }

}

