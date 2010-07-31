# Class: dashboard
#
# Manages dashboard.
# Include it to install and run dashboard with default settings
#
# Usage:
# include dashboard
#
# Variables:
# $dashboard_install - Defines the installation method.
#   Can be "source" or "package" (default)
#
class dashboard {

    # Load the variables used in this module. Check the params.pp file
    require dashboard::params
    require puppet::params

    case $dashboard::params::install {
        source: { include dashboard::source }
        package: { include dashboard::package }
    }

    case $dashboard::params::use_mysql {
        yes: {
             require mysql::params
             include mysql
        }
        no: {
        }
    }

    service { "dashboard":
        name       => "${dashboard::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => false,
        require    => Exec["populate-dashboard-db"],
    }

    file { "database.yml":
        path    => "${dashboard::params::configfile}",
        mode    => "${dashboard::params::configfile_mode}",
        owner   => "${dashboard::params::configfile_owner}",
        group   => "${dashboard::params::configfile_group}",
        require => $dashboard::params::install ? {
            source  => Class["dashboard::source"],
            package => Package["dashboard"],
        },
        ensure  => present,
        content => template("dashboard/database.yml.erb"),
    }

    # Note: puppet-dashboard report lib is installed directory in $puppet_basedir/reports for 0.24 compliance
    file {
        "puppet-dashboard.rb":
            ensure => "$dashboard::params::basedir/puppet-dashboard/lib/puppet/puppet_dashboard.rb",
            path   => "$puppet::params::basedir/reports/puppet_dashboard.rb",
    }

    exec {
        "create-dashboard-db":
            command => "rake RAILS_ENV=production db:create",
            cwd => "$dashboard::params::basedir/puppet-dashboard",
            require => File["database.yml"],
            creates => "$mysql::params::datadir/dashboard",
    }

    exec {
        "populate-dashboard-db":
            command => "rake RAILS_ENV=production db:migrate",
            cwd => "$dashboard::params::basedir/puppet-dashboard",
            require => Exec["create-dashboard-db"],
            creates => "$mysql::params::datadir/dashboard/nodes.frm",
    }

    case $operatingsystem {
        default: { }
    }

    if $backup == "yes" { include dashboard::backup }
    if $monitor == "yes" { include dashboard::monitor }
    if $firewall == "yes" { include dashboard::firewall }

}
