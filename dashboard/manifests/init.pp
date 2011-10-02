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

    case $dashboard::params::db {
        mysql: {
             require mysql::params
             include mysql
             include dashboard::mysql
        }
        sqlite: {
             include dashboard::sqlite
        }
        no: {
        }
    }

    service { "dashboard":
        name       => "${dashboard::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${dashboard::params::hasstatus}",
        pattern    => "${dashboard::params::processname}",
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

    file { "settings.yml":
        path    => "${dashboard::params::configfilesettings}",
        mode    => "${dashboard::params::configfile_mode}",
        owner   => "${dashboard::params::configfile_owner}",
        group   => "${dashboard::params::configfile_group}",
        require => $dashboard::params::install ? {
            source  => Class["dashboard::source"],
            package => Package["dashboard"],
        },
        ensure  => present,
        content => template("dashboard/settings.yml.erb"),
    }

    # Note: puppet-dashboard report lib is installed directory in $puppet_basedir/reports for 0.24 compliance
    file {
        "puppet-dashboard.rb":
            ensure => "$dashboard::params::basedir/puppet-dashboard/ext/puppet/puppet_dashboard.rb",
            # ensure => "$dashboard::params::basedir/puppet-dashboard/lib/puppet/puppet_dashboard.rb",
            path   => "$puppet::params::basedir/reports/puppet_dashboard.rb",
    }

    # For ENC 
    file {
        "dashboard-node.rb":
            ensure => "$dashboard::params::basedir/puppet-dashboard/ext/puppet/puppet_dashboard.rb",
            # ensure => "$dashboard::params::basedir/puppet-dashboard/lib/puppet/puppet_dashboard.rb",
            path   => "/etc/puppet/node.rb",
    }

    exec {
        "create-dashboard-db":
            command => "rake RAILS_ENV=production db:create",
            cwd => "$dashboard::params::basedir/puppet-dashboard",
            require => $dashboard::params::db ? {
                sqlite => [ File["database.yml"] , Class["dashboard::sqlite"] ],
                mysql  => [ File["database.yml"] , Class["dashboard::mysql"] ],
            },
            creates => $dashboard::params::db ? {
                sqlite => "$dashboard::params::basedir/puppet-dashboard/db/production.sqlite3",
                mysql  => "$mysql::params::datadir/dashboard",
            },
    }

    exec {
        "populate-dashboard-db":
            command => "rake RAILS_ENV=production db:migrate",
            cwd => "$dashboard::params::basedir/puppet-dashboard",
            require => Exec["create-dashboard-db"],
            creates => $dashboard::params::db ? {
                sqlite => "$dashboard::params::basedir/puppet-dashboard/db/schema.rb",
                mysql  => "$mysql::params::datadir/dashboard/nodes.frm",
            },
    }

    case $operatingsystem {
        centos : { package { "rubygem-json": ensure => present , } }
        redhat : { package { "rubygem-json": ensure => present , } }
        ubuntu : { package { "libjson-ruby": ensure => present , } }
        debian : { package { "libjson-ruby": ensure => present , } }
        default: { }
    }

    if $puppi == "yes" { include dashboard::puppi }
    if $backup == "yes" { include dashboard::backup }
    if $monitor == "yes" { include dashboard::monitor }
    if $firewall == "yes" { include dashboard::firewall }

    # Include project specific class if $my_project is set
    if $my_project { include "dashboard::${my_project}" }

    # Include debug class is debugging is enabled ($debug=yes)
    if ( $debug == "yes" ) or ( $debug == true ) { include dashboard::debug }

}
