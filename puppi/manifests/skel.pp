#
# Class puppi::skel
# Creates the base Puppi dirs
#
class puppi::skel {

    require puppi::params

    file { "puppi_basedir":
        path    => "${puppi::params::basedir}",
        mode    => "755",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => directory,
    }

    file { "puppi_checksdir":
        path    => "${puppi::params::checksdir}",
        mode    => "755",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => directory,
        require => File["puppi_basedir"],
        recurse => true, purge => true, force => true,
    }

    file { "puppi_logsdir":
        path    => "${puppi::params::logsdir}",
        mode    => "755",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => directory,
        require => File["puppi_basedir"],
        recurse => true, purge => true, force => true,
    }

    file { "puppi_infodir":
        path    => "${puppi::params::infodir}",
        mode    => "755",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => directory,
        require => File["puppi_basedir"],
        recurse => true, purge => true, force => true,
    }

    file { "puppi_tododir":
        path    => "${puppi::params::tododir}",
        mode    => "755",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => directory,
        require => File["puppi_basedir"],
        recurse => true, purge => true, force => true,
    }

    file { "puppi_projectsdir":
        path    => "${puppi::params::projectsdir}",
        mode    => "755",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => directory,
        require => File["puppi_basedir"],
        recurse => true, purge => true, force => true,
    }

    file { "puppi_workdir":
        path    => "${puppi::params::workdir}",
        mode    => "755",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => directory,
        require => File["puppi_basedir"],
    }

    file { "puppi_archivedir":
        path    => "${puppi::params::archivedir}",
        mode    => "755",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => directory,
        require => File["puppi_libdir"],
    }

    file { "puppi_readmedir":
        path    => "${puppi::params::readmedir}",
        mode    => "755",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => directory,
        require => File["puppi_libdir"],
    }

    file { "puppi_libdir":
        path    => "${puppi::params::libdir}",
        mode    => "755",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => directory,
        require => File["puppi_basedir"],
    }

    file { "puppi_logdir":
        path    => "${puppi::params::logdir}",
        mode    => "755",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => directory,
        require => File["puppi_basedir"],
    }

}
