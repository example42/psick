class samba::ldap inherits samba::server {
# Note: This class can't cohexist with a OpenLdap class

    File["smb.conf"] {
            content => template("samba/smb.conf-ldap.erb"),
    }


    package { smbldap-tools:
        name => $operatingsystem ? {
            default => "smbldap-tools",
            },
        ensure => present,
    }

    file {
        "smbldap.conf":
            mode => 644, owner => root, group => root,
            ensure => present,
            content => template("samba/smbldap.conf.erb"),
            require => Package["smbldap-tools"],
            path => $operatingsystem ?{
                default => "/etc/smbldap-tools/smbldap.conf",
            },
    }

    file {
        "smbldap_bind.conf":
            mode => 600, owner => root, group => root,
            ensure => present,
            content => template("samba/smbldap_bind.conf.erb"),
            require => Package["smbldap-tools"],
            path => $operatingsystem ?{
                default => "/etc/smbldap-tools/smbldap_bind.conf",
            },
    }

# Openldap setup

    package { openldap:
        name => $operatingsystem ? {
            CentOS  => "openldap-servers",
            default => "openldap",
            },
        ensure => present,
    }

    service { ldap:
        name => $operatingsystem ? {
            default => "ldap",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => File["slapd.conf"],
    }

    file {  
        "slapd.conf":
            mode => 640, owner => root, group => ldap,
            require => Package["openldap"],
            ensure => present,
            content => template("samba/slapd.conf-samba.erb"),
            path => $operatingsystem ?{
                default => "/etc/openldap/slapd.conf",
            },
    }

    file {
        "samba.schema":
            mode => 644, owner => root, group => root,
            ensure => present,
            source => "puppet://$servername/samba/samba.schema",
            require => Package["openldap"],
            path => $operatingsystem ?{
                default => "/etc/openldap/schema/samba.schema",
            },
    }

}

