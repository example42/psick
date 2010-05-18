class oracle::user {

    require oracle::params

# Quick fix to use these variables in the template
$oraclebase = "${oracle::params::oraclebase}"
$version = "${oracle::params::version}"
$sid = "${oracle::params::sid}"

    group { "${oracle::params::group}":
        ensure  => "present",
    }
    
    group { "${oracle::params::groups}":
        ensure  => "present",
    }

    user { "${oracle::params::user}":
            ensure  => "present",
            comment => "Oracle User",
            managehome => true,
            password => "${oracle::params::password}",
            gid     => "${oracle::params::group}",
            groups  => "${oracle::params::groups}",
    }

    file { "oracle_bash_profile":
        mode   => 750,
        owner  => "${oracle::params::user}",
        group  => "${oracle::params::groups}",
        path   => "/home/${oracle::params::user}/.bash_profile",
        content => template("oracle/bash_profile"),
        require => User["${oracle::params::user}"],
    }

    exec { "oracle_base_parents":
        command => "mkdir -p ${oracle::params::oraclebase}",
        unless  => "ls ${oracle::params::oraclebase}",
    }

#    exec { "oracle_base_parents_perms":
#        command => "chown -${oracle::params::user}:${oracle::params::group} mkdir -p ${oracle::params::oraclebase}",
#        unless  => "ls ${oracle::params::oraclebase}",
#    }


    file { "oracle_base":
        mode   => 775,
        owner  => "${oracle::params::user}",
        group  => "${oracle::params::group}",
        path   => "${oracle::params::oraclebase}",
        ensure => directory,
        recurse => true,
        require => Exec["oracle_base_parents"],
    }

}
