class audit {

    service {
        "auditd":
        enable    => "true",
        ensure    => "running",
        name => $operatingsystem ? {
            default => "auditd",
            },
    }

    package {
        "audit":
        ensure => present,
        name => $operatingsystem ? {
            default => "audit",
            },
    }
    
}
