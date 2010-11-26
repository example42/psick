#
# Class puppi::extra
# Extra reources needed for some uppi functionaility
# You might have them defined somewhere else. In this case do not include this class in init.pp
#
class puppi::extra {

    package { curl:
        ensure => present,
    }

}

