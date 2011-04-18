# Class: dashboard::source
#
# Installs DashBoard from sources
#
class dashboard::source {

    require puppet::params
    require dashboard::params

    git::clone {
        "puppet-dashboard":
            url => "git://github.com/puppetlabs/puppet-dashboard.git",
            path => $dashboard::params::basedir,
    }
    
}

