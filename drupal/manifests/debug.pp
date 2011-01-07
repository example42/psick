#
# Class: drupal::debug
#
# This class is used only for debugging purposes
#
# Usage:
# This class is autoloaded if you set $debug=yes
#
class drupal::debug {

    # Load the variables used in this module. Check the params.pp file 
    require drupal::params
    include puppet::debug
    include puppet::params

    file { "puppet_debug_variables_drupal":
        path    => "${puppet::params::debugdir}/variables/drupal",
        mode    => "${drupal::params::configfile_mode}",
        owner   => "${drupal::params::configfile_owner}",
        group   => "${drupal::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("drupal/variables_drupal.erb"),
    }

}
