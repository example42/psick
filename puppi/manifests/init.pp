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

    # puppi common scripts
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

    # Create Puppi workdirs
    include puppi::skel

    # Some extra packages we use in Puppi scripts
    # This class might conflict with your existing classes
    # Just be sure to provide the requested packages
    if $puppi::params::extra != "no" { include puppi::extra }

    # Define standard systemwide log paths for puppi log
    include puppi::logs

    # Define standard systemwide information sources
    include puppi::infos

    # Some default checks
    include puppi::checks    

}
