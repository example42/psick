class trac {

    package { trac:
        name => $operatingsystem ? {
            default    => "trac",
            },
        ensure => present,
    }

    package { 
        trac-webadmin:    ensure => present;
        trac-ticketdelete-plugin: ensure => present;
        trac-iniadmin-plugin: ensure => present;
        trac-privateticketsplugin: ensure => present;
    }
}

class trac::git inherits trac {

    package { 
        trac-git-plugin:
        ensure => present,
    }

    file {
        "/var/cache/trac-git":
            mode => 755,
            owner => apache,
            group => root,
            require => Package["trac-git-plugin"],
            ensure => directory,
    }


}
