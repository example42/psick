#
# Class: puppet::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is used if you set $debug=yes
#
class puppet::debug {

    # Load the variables used in this module. Check the params.pp file 
    include puppet::params

    file { "puppet_debug":
        path    => "${puppet::params::debugdir}",
        mode    => "755",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        ensure  => directory,
    }

    file { "puppet_debug_variables":
        path    => "${puppet::params::debugdir}/variables",
        mode    => "750",
        owner   => "root",
        group   => "root",
        ensure  => directory,
        require => File["puppet_debug"],
    }

    file { "puppet_debug_todo":
        path    => "${puppet::params::debugdir}/todo",
        mode    => "755",
        owner   => "root",
        group   => "root",
        ensure  => directory,
        require => File["puppet_debug"],
    }

    file { "puppet_debug_variables_puppet":
        path    => "${puppet::params::debugdir}/variables/puppet",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("puppet/variables_puppet.erb"),
    }

# This file contains the whole scope with facts and user variables
# Since it contains mutable data (uptime, datetime, free mem) is not 
# provided by default. ensure => present to do it
# Source: http://www.puppetcookbook.com/posts/see-all-client-variables.html

    file { "puppet_debug_scope":
        path    => "${puppet::params::debugdir}/variables/scope",
        mode    => "640",
        owner   => "root",
        group   => "root",
        ensure  => absent,
        # ensure  => present,
        require => File["puppet_debug_variables"],
        content => inline_template("<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>"),
    }

}
