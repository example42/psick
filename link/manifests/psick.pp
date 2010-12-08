define link::psick (
    $title,
    $description='',
    $url,
    $host,
    $priority,
    $type='admin',
    $private='no',
    $linktags='',
    $login='',
    $password='',
    $enable='true'
    ) {

    $ensure = $enable ? {
        "false" => "absent",
        false   => "absent",
        "no"    => "absent",
        "true"  => "present",
        true    => "present",
        "yes"   => "present",
    }

    include psick::params
    include psick::node

    @@file { "${psick::params::workdir}/${host}/${priority}-${name}":
        mode    => "644",
        owner   => "${psick::params::user}",
        group   => "${psick::params::user}",
        ensure  => "${ensure}",
        require => File["${psick::params::workdir}"],
        content => template('psick/link.erb'),
        tag     => 'psick_link',
        notify  => Exec["psick-build.sh"],
    }

}
