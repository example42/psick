class oracle {
        file {  
                "/root/install_oracle_dependency.sh":
                        mode => 750, owner => root, group => root,
                        source => "puppet://$servername/oracle/install_oracle_dependency.sh",
        }

        exec {
                "/root/install_oracle_dependency.sh":
                        subscribe   => File["/root/install_oracle_dependency.sh"],
                        refreshonly => true
        }

        group {
                "dba":
                        ensure  => "present",
                        gid     => "900"
        }

        user {
                "oemagent":
                        ensure  => "present",
                        uid     => "905",
                        gid     => "900",
                        comment => "Oracle Agent",
                        home    => "/home/oemagent",
                        shell   => "/bin/bash",
                        require => Group["dba"];
        }

        file {
                "/home/oemagent":
                        owner   => "oemagent",
                        group   => "dba",
                        mode    => "700",
                        ensure  => "directory",
                        require => [
                                User["oemagent"],
                                Group["dba"]
                        ];
        }
}

class oracle-as-commons inherits oracle {
        user {
                "ias10g":
                        ensure  => "present",
                        uid     => "901",
                        gid     => "900",
                        comment => "Oracle Software Owner User (AS)",
                        home    => "/home/ias10g",
                        shell   => "/bin/bash",
                        require => Group["dba"]
        }


        file {
                "/home/ias10g":
                        owner   => "ias10g",
                        group   => "900",
                        mode    => "700",
                        ensure  => "directory",
                        require => User["ias10g"]
        }

        file {
                "/usr/ias10g":
                        owner   => "ias10g",
                        group   => "900",
                        mode    => "755",
                        ensure  => "directory",
                        require => User["ias10g"]
        }

        file {
                "/usr/oemagent":
                        owner   => "oemagent",
                        group   => "dba",
                        mode    => "755",
                        ensure  => "directory",
                        require => [
                                User["oemagent"],
                                Group["dba"]
                        ];
        }
}

class oracle-as inherits oracle-as-commons {
        file {
                 "/etc/security/limits.conf": 
                        owner  => "root",
                        group  => "root",
                        mode   => "644",
                        source => "puppet://$servername/oracle/limits.conf-oracle-as",
        }

}
class oracle-oid-commons inherits oracle {
        user {
                "ias10g":
                        ensure  => "present",
                        uid     => "901",
                        gid     => "900",
                        comment => "Oracle Software Owner User (AS)",
                        home    => "/home/ias10g",
                        shell   => "/bin/bash",
                        require => Group["dba"]
        }


        file {
                "/home/ias10g":
                        owner   => "ias10g",
                        group   => "900",
                        mode    => "700",
                        ensure  => "directory",
                        require => User["ias10g"]
        }

        file {
                "/usr/ias10g":
                        owner   => "ias10g",
                        group   => "900",
                        mode    => "755",
                        ensure  => "directory",
                        require => User["ias10g"]
        }

        file {
                "/usr/oemagent":
                        owner   => "oemagent",
                        group   => "dba",
                        mode    => "755",
                        ensure  => "directory",
                        require => [
                                User["oemagent"],
                                Group["dba"]
                        ];
        }
}
class oracle-oid inherits oracle-oid-commons {
        file {
                 "/etc/security/limits.conf": 
                        owner  => "root",
                        group  => "root",
                        mode   => "644",
                        source => "puppet://$servername/oracle/limits.conf-oracle-oid",
        }
        file {
                 "/etc/sysctl.conf": 
                        owner  => "root",
                        group  => "root",
                        mode   => "644",
                        source => "puppet://$servername/oracle/sysctl.conf-oracle-oid",
        }


}

