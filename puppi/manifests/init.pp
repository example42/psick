class puppi {

    require puppi::params

    # Main configuration file
    file { "puppi.conf":
        path    => "${puppi::params::basedir}/puppi.conf",
        mode    => "644",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => present,
        content => template("puppi/puppi.conf.erb"),
        require => File["puppi_basedir"],
    }

    # puppi command
    file { "puppi":
        path    => "/usr/sbin/puppi",
        mode    => "750",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => present,
        content => template('puppi/puppi.erb'),
        require => File["puppi_basedir"],
    }

    # puppi scripts
    file { "puppi.scripts":
        path    => "${puppi::params::scriptsdir}/",
        mode    => "755",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => present,
        source  => "${puppi::params::general_base_source}/puppi/scripts/",
        recurse => true,
        # purge   => true,
	ignore  => ".svn",
        require => File["puppi_basedir"],
    }

    include puppi::skel

    # Some extra stuff we use in Puppi scrips
    include puppi::extra

    
}
