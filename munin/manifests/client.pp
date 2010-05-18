# client.pp - configure a munin node
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.
# Adapted and improved by admin(at)immerda.ch

class munin::client inherits munin {

    $munin_port_real = $munin_port ? { '' => 4949, default => $munin_port } 
    $munin_host_real = $munin_host ? {
        '' => '*',
        'fqdn' => '*',
        default => $munin_host
    }

    case $operatingsystem {
    openbsd: { include munin::client::openbsd }
    darwin: { include munin::client::darwin }
    debian,ubuntu: { include munin::client::debian }
    gentoo: { include munin::client::gentoo }
    centos: { include munin::client::package }
    default: { include munin::client::base }
    }
    if $use_shorewall {
    include shorewall::rules::munin
    }
}
