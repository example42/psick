define trac::initenv (
    $trac_templatepath = '/usr/share/trac/templates',
    $trac_basepath = '/srv/trac',
    $trac_dbtype = 'sqlite',
    $trac_dbpath = 'db/trac.db',
    $trac_repotype = 'git',
    $trac_repopath = '/srv/git'
    ){

    include trac

    file {
        "${trac_basepath}":
            mode => 755, owner => root, group => root,
            ensure => directory,
    }

#    file {
#        "${trac_basepath}/$name":
#            mode => 755, owner => root, group => root,
#            require => File["${trac_basepath}"],
#            ensure => directory,
#    }

    exec {
        "trac_init_$name":
            command => "trac-admin ${trac_basepath}/$name initenv $name ${trac_dbtype}:${trac_dbpath} ${trac_repotype} ${trac_repopath} ${trac_templatepath}",
            creates => "${trac_basepath}/${name}/conf/trac.ini",
            logoutput => false,
            require => [ File["${trac_basepath}"] , Package["trac"] ],
    }

# Trac Based on Apache + Mod_python
    file {
        "${trac_basepath}/$name/.htpasswd":
            mode => 644, owner => root, group => root,
            require => Exec["trac_init_$name"],
            ensure => present,
            # content => template("trac/htpasswd"),
    }


    file {
        "${trac_basepath}/$name/db":
            mode => 755,
            owner => apache,
            group => root,
            ensure => directory,
            require => Exec["trac_init_${name}"],
    }
    file {
        "${trac_basepath}/$name/db/trac.db":
            mode => 644,
            owner => apache,
            group => root,
            require => Exec["trac_init_${name}"],
    }

    augeas { "/files${trac_basepath}/$name/conf/trac.ini":
        context => "/files${trac_basepath}/$name/trac.ini/components/",
        changes => "set components/gitplugin enabled",
        changes => "set gugin dfsnabled",
     }

    file {
        "/etc/httpd/conf.d/trac-$name.conf":
            mode => 644, owner => root, group => root,
            ensure => present,
            content => template("trac/httpd.conf"),
    }



}

