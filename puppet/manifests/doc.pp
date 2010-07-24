# Class: puppet::doc
#
# Installs rdoc for puppetdoc
#
class puppet::doc {
    package {
        rdoc:
        name => $operatingsystem ? {
            Debian  => "rdoc",
            CentOS  => "ruby-rdoc",
            SuSE    => "ruby",
            default => "ruby-rdoc",
            },
        ensure => present,
    }
}

