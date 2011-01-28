# Class: mailx
#
# Manages mailx.
# Include it to install mailx
#
# Usage:
# include mailx
#
class mailx {

    # Load the variables used in this module. Check the params.pp file
    require mailx::params

     # Package installation. mailx it's really simple package so, install only
    package { mailx:
        name   => "${mailx::params::packagename}",
        ensure => present,
    }
}
