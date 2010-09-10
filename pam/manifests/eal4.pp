# Class: pam::eal4
#
# Tweaks pam settings to comply to EAL4 guidelines
# Tested and supported on Redhat/Centos 5
#
# Usage:
# include pam::eal4
#
class pam::eal4 inherits pam {
# Load the variables used in this module. Check the params.pp file
    include pam::params

    File ["/etc/pam.d/other"] {
            source => "${pam::params::pam_source}/eal4/${pam::params::oslayout}/other",
    }

    File ["/etc/pam.d/system-auth-ac"] {
            source => "${pam::params::pam_source}/eal4/${pam::params::oslayout}/system-auth-ac",
    }

    File ["/etc/pam.d/login"] {
            source => "${pam::params::pam_source}/eal4/${pam::params::oslayout}/login",
    }

    File ["/etc/pam.d/sshd"] {
            source => "${pam::params::pam_source}/eal4/${pam::params::oslayout}/sshd",
    }

    File ["/etc/pam.d/su"] {
            source => "${pam::params::pam_source}/eal4/${pam::params::oslayout}/su",
    }

}
