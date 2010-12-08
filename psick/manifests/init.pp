class psick {

    require psick::params

    # Main configuration file
    file { "psick.conf":
        path    => "${psick::params::confdir}/psick.conf",
        mode    => "644",
        owner   => "${psick::params::user}",
        group   => "${psick::params::user}",
        ensure  => present,
        content => template("psick/psick.conf.erb"),
        require => File["psick_confdir"],
    }

    # psick static page build command
    file { "psick-build.sh":
        path    => "/usr/sbin/psick-build.sh",
        mode    => "750",
        owner   => "${psick::params::user}",
        group   => "${psick::params::user}",
        ensure  => present,
        source  => "${psick::params::general_base_source}/psick/psick-build.sh",
    }

    exec { "psick-build.sh":
        command => "/usr/sbin/psick-build.sh",
        unless  => "ls ${psick::params::outputdir}/index.html",
    }

    # psick templatedis
    file { "psick_templatesdir":
        path    => "${psick::params::confdir}/templates",
        mode    => "755",
        owner   => "${psick::params::user}",
        group   => "${psick::params::user}",
        ensure  => present,
        source  => "${psick::params::general_base_source}/psick/templates/",
        recurse => true,
        # purge   => true,
	ignore  => ".svn",
        require => File["psick_confdir"],
    }

    file { "psick_confdir":
        path    => "${psick::params::confdir}",
        mode    => "755",
        owner   => "${psick::params::user}",
        group   => "${psick::params::user}",
        ensure  => directory,
    }

    file { "psick_workdir":
        path    => "${psick::params::workdir}",
        mode    => "755",
        owner   => "${psick::params::user}",
        group   => "${psick::params::user}",
        ensure  => directory,
    }

    file { "psick_outputdir":
        path    => "${psick::params::outputdir}",
        mode    => "755",
        owner   => "${psick::params::user}",
        group   => "${psick::params::user}",
        ensure  => directory,
    }

    File <<| tag == 'psick_link' |>>

}
