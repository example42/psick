# Define puppi::info::instance
#
# This is a puppi info plugin specific for the tomcat::instance define
#
define puppi::info::instance (
    $servicename="",
    $processname="",
    $configdir="",
    $bindir="",
    $pidfile="",
    $datadir="",
    $logdir="",
    $httpport="",
    $controlport="",
    $ajpport="",
    $description="",
    $run="",
    $verbose="no",
    $templatefile="puppi/info/instance.erb" ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    file { "${puppi::params::infodir}/${name}":
        mode    => "750",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => "present",
        require => Class["puppi"],
        content => template("$templatefile"),
        tag     => 'puppi_info',
    }
}
