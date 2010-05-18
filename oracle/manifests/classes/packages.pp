class oracle::packages {

    require oracle::params

    file { "install_oracle_dependency.sh":
        mode    => 750, owner => root, group => root,
        content => $operatingsystem ? { 
            centos => template("oracle/install_oracle_dependency.sh-redhat"),
            redhat => template("oracle/install_oracle_dependency.sh-redhat"),
            debian => template("oracle/install_oracle_dependency.sh-debian"),
            ubuntu => template("oracle/install_oracle_dependency.sh-debian"),
            suse   => template("oracle/install_oracle_dependency.sh-suse"),
            },
        path    => "${oracle::params::workdir}/install_oracle_dependency.sh",
    }

    exec { "install_oracle_dependency.sh":
        subscribe   => File["install_oracle_dependency.sh"],
        refreshonly => true,
        timeout     => 3600,
        command     => "${oracle::params::workdir}/install_oracle_dependency.sh",
    }

}
