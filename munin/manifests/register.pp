define munin::register()
{
    $munin_port_real = $munin_port ? { '' => 4949, default => $munin_port } 
    $munin_host_real = $munin_host ? {
        '' => $fqdn,
        'fqdn' => $fqdn,
        default => $munin_host
    }

    @@file { "/var/lib/puppet/modules/munin/nodes/${name}_${munin_port_real}":
        ensure => present,
        content => template("munin/defaultclient.erb"),
        tag => 'munin',
    }
}


