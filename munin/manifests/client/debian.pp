class munin::client::debian inherits munin::client::package {
    # the plugin will need that
    package { "iproute": ensure => installed }

    Service["munin-node"]{
        # sarge's munin-node init script has no status
        hasstatus => $lsbdistcodename ? { sarge => false, default => true }
    }
    File["/etc/munin/munin-node.conf"]{
            content => template("munin/munin-node.conf.$operatingsystem.$lsbdistcodename"),
    }
    # workaround bug in munin_node_configure
    plugin { "postfix_mailvolume": ensure => absent }
    include munin::plugins::debian
}
