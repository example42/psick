class oracle::redhat {

$oracle_workdir="/var/tmp"

        file { "install_oracle_dependency.sh":
		mode   => 750, owner => root, group => root,
		source => "puppet://$servername/oracle/install_oracle_dependency.sh",
		path   => "$oracle_workdir/install_oracle_dependency.sh",	
        }

        exec { "install_oracle_dependency.sh":
		subscribe   => File["install_oracle_dependency.sh"],
		refreshonly => true,
		command     => "$oracle_workdir/install_oracle_dependency.sh",	
        }

        group { "dba":
		ensure  => "present",
        }
        
	group { "oinstall":
		ensure  => "present",
        }

        user { "oracle":
                        ensure  => "present",
                        comment => "Oracle User",
                        gid	=> "oinstall",
                        groups	=> "dba",
			require => [ Group["dba", Group["oinstall"] ],
        }

        file { 
		"/u01":
			owner   => "oracle", group   => "oinstall", mode    => "775", ensure  => "directory";
		"/u01/app":
			owner   => "oracle", group   => "oinstall", mode    => "775", ensure  => "directory";
		"/u01/app/oracle":
			owner   => "oracle", group   => "oinstall", mode    => "775", ensure  => "directory";
	}

        file { "/home/oracle/.bash_profile": 
		mode   => 750, owner => oracle, group => dba,
		source => "puppet://$servername/oracle/bash_profile-redhat",
        }


# Oracle reccomended Sysctl tunings

	augeas { "sysctl-kernel.shmall":
		context => "/files/etc/sysctl.conf",
		changes =>  "set kernel.shmall 2097152",
                onlyif  =>  "get kernel.shmall != 2097152" 
	}
	
	augeas { "sysctl-kernel.shmmax":
		context => "/files/etc/sysctl.conf",
		changes =>  "set kernel.shmmax 526870912",
                onlyif  =>  "get kernel.shmmax != 526870912" 
	}
	
	augeas { "sysctl-kernel.shmmni":
		context => "/files/etc/sysctl.conf",
		changes =>  "set kernel.shmmni 4096",
                onlyif  =>  "get kernel.shmmni != 4096" 
	}
	
	augeas { "sysctl-kernel.sem":
		context => "/files/etc/sysctl.conf",
		changes =>  "set kernel.sem 250 32000 100 128",
                onlyif  =>  "get kernel.sem != 250 32000 100 128" 
	}
	
	augeas { "sysctl-fs.file-max":
		context => "/files/etc/sysctl.conf",
		changes =>  "set fs.file-max 65536",
                onlyif  =>  "get fs.file-max != 65536" 
	}
	
	augeas { "sysctl-net.ipv4.ip_local_port_range":
		context => "/files/etc/sysctl.conf",
		changes =>  "set net.ipv4.ip_local_port_range 1024 65000",
                onlyif  =>  "get net.ipv4.ip_local_port_range != 1024 65000" 
	}
	
	augeas { "sysctl-net.core.rmem_default":
		context => "/files/etc/sysctl.conf",
		changes =>  "set net.core.rmem_default 262144",
                onlyif  =>  "get net.core.rmem_default != 262144" 
	}
	
	augeas { "sysctl-net.core.wmem_default":
		context => "/files/etc/sysctl.conf",
		changes =>  "set net.core.wmem_default 262144",
                onlyif  =>  "get net.core.wmem_default != 262144" 
	}

	augeas { "sysctl-net.core.rmem_max":
		context => "/files/etc/sysctl.conf",
		changes =>  "set net.core.rmem_max 262144",
                onlyif  =>  "get net.core.rmem_max != 262144" 
	}

	augeas { "sysctl-net.core.wmem_max":
		context => "/files/etc/sysctl.conf",
		changes =>  "set net.core.wmem_max 262144",
                onlyif  =>  "get net.core.wmem_max != 262144" 
	}

}
