# snmp_testplugin: the plugin we use to test if it's set
define munin::register_snmp(
    $snmpd_testplugin = 'load'
)
{
    $munin_port_real = $munin_port ? { '' => 4949, default => $munin_port } 
    $munin_host_real = $munin_host ? {
        '' => '*',
        'fqdn' => '*',
        default => $munin_host
    }
    exec{"register_snmp_munin_for_${name}":
    command => "munin-node-configure-snmp ${name} | sh",
    unless => "test -e /etc/munin/plugins/snmp_${name}_${snmpd_testplugin}",
    }
    @@file { "munin_snmp_${name}": path => "/var/lib/puppet/modules/munin/nodes/${name}",
    ensure => present,
    content => template("munin/snmpclient.erb"),
    tag => 'munin',
    }
}
