class munin::client::package inherits munin::client::base {
    package { 'munin-node': ensure => installed }
    Service['munin-node']{
    require => Package[munin-node],
    }
    File['/etc/munin/munin-node.conf']{
        # this has to be installed before the package, so the postinst can
        # boot the munin-node without failure!
        before => Package['munin-node'],
    }
}
