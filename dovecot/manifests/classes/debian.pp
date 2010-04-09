# Class: dovecot::debian
#
# Debian/Ubuntu addons for Dovecot

class dovecot::debian {

        package { "dovecot":
                name   =>"dovecot-pop3d",
                ensure => present,
        }

}
