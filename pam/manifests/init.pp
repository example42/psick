# Class: pam
#
# Manages pam configuration files 
#
class pam {

# Load the variables used in this module. Check the params.pp file
    include pam::params

# PAM FILES WITH VARIABLE NAMING ACCORDING TO OS
case $users::params::oslayout {

    debian5,ubuntu104: {

        file { "/etc/pam.d/common-account":
            path    => "${pam::params::configdir}/common-account",
            mode    => "${pam::params::configfile_mode}",
            owner   => "${pam::params::configfile_owner}",
            group   => "${pam::params::configfile_group}",
            ensure  => present,
        }

        file { "/etc/pam.d/common-auth":
            path    => "${pam::params::configdir}/common-auth",
            mode    => "${pam::params::configfile_mode}",
            owner   => "${pam::params::configfile_owner}",
            group   => "${pam::params::configfile_group}",
            ensure  => present,
        }

        file { "/etc/pam.d/common-password":
            path    => "${pam::params::configdir}/common-password",
            mode    => "${pam::params::configfile_mode}",
            owner   => "${pam::params::configfile_owner}",
            group   => "${pam::params::configfile_group}",
            ensure  => present,
        }

        file { "/etc/pam.d/common-session":
            path    => "${pam::params::configdir}/common-session",
            mode    => "${pam::params::configfile_mode}",
            owner   => "${pam::params::configfile_owner}",
            group   => "${pam::params::configfile_group}",
            ensure  => present,
        }

    }

    redhat5: {

        file { "/etc/pam.d/system-auth-ac":
            path    => "${pam::params::configdir}/system-auth-ac",
            mode    => "${pam::params::configfile_mode}",
            owner   => "${pam::params::configfile_owner}",
            group   => "${pam::params::configfile_group}",
            ensure  => present,
        }

    }

} # End case



# PAM FILES WITH STANDARD NAMING
    file { "/etc/pam.d/other":
        path    => "${pam::params::configdir}/other",
        mode    => "${pam::params::configfile_mode}",
        owner   => "${pam::params::configfile_owner}",
        group   => "${pam::params::configfile_group}",
        ensure  => present,
    }

    file { "/etc/pam.d/login":
        path    => "${pam::params::configdir}/login",
        mode    => "${pam::params::configfile_mode}",
        owner   => "${pam::params::configfile_owner}",
        group   => "${pam::params::configfile_group}",
        ensure  => present,
    }

    file { "/etc/pam.d/sshd":
        path    => "${pam::params::configdir}/sshd",
        mode    => "${pam::params::configfile_mode}",
        owner   => "${pam::params::configfile_owner}",
        group   => "${pam::params::configfile_group}",
        ensure  => present,
    }

    file { "/etc/pam.d/su":
        path    => "${pam::params::configdir}/su",
        mode    => "${pam::params::configfile_mode}",
        owner   => "${pam::params::configfile_owner}",
        group   => "${pam::params::configfile_group}",
        ensure  => present,
    }

}
