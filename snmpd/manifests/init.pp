class snmpd {
    service {
        "snmpd":
        enable    => "true",
        ensure    => "running",
        require   => File["snmpd.conf"],
        subscribe => File["snmpd.conf"],
        name => $operatingsystem ? {
            default => "snmpd",
            },
    }

    package {
        "net-snmp":
        ensure => present,
        name => $operatingsystem ? {
            debian => "snmpd",
            ubuntu => "snmpd",
            default => "net-snmp",
            },
    }
    
    file {
        "snmpd.conf":
#         owner  => root,
#        group  => root,
#        mode   => 644,
        require   => Package["net-snmp"],
        path    => $operatingsystem ?{
               default => "/etc/snmp/snmpd.conf",
               },
    }
}
