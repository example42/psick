class psick::node {
    @@file { "${psick::params::workdir}/${host}":
        mode    => "755",
        owner   => "${psick::params::user}",
        group   => "${psick::params::user}",
        ensure  => directory,
        tag     => 'psick_link',
    }
}
