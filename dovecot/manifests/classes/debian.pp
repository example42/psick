# Class: dovecot::debian
#
# Debian/Ubuntu addons for Dovecot
#
class dovecot::debian {

    package { "dovecot-ipop3d":
        name   =>"dovecot-pop3d",
        ensure => present,
    }

}
