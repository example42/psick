# Define: monit::checkpid
#
# Basic PID service checking define
#
# Usage:
# With standard template:
# monit::checkpid    { "name": }
#
define monit::checkpid ( $templatefile="", $pidfile="", $startprogram="", $stopprogram="", $restarts="", $cycles="", $failaction="" ) {

    require monit::params

    # Check name, required
    $name_checkpid = "$name"

    # Template file
    $templatefile_checkpid = $templatefile ? {
        ''      => "checkpid.erb",
	default => $templatefile,
    }

    # Pid file path
    $pidfile_checkpid = $pidfile ? {
        ''      => "/var/run/$name.pid",
	default => $pidfile,
    }

    # How to start the service
    $startprogram_checkpid = $startprogram ? {
        ''      => "/etc/init.d/$name start",
	default => $startprogram,
    }

    # How to stop the service
    $stopprogram_checkpid = $stopprogram ? {
        ''      => "/etc/init.d/$name stop",
	default => $stopprogram,
    }

    # Restarts
    $restarts_checkpid = $restarts ? {
        ''      => "5",
	default => $restarts,
    }

    # Cycles
    $cycles_checkpid = $cycles ? {
        ''      => "5",
	default => $cycles,
    }

    # Emergency fail action
    $failaction_checkpid = $failaction ? {
        ''      => "timeout",
	default => $failaction,
    }

    file { "MonitCheckPid_${name}":
        path    => "${monit::params::pluginsdir}/${name}",
        mode    => "${monit::params::pluginfile_mode}",
        owner   => "${monit::params::pluginfile_owner}",
        group   => "${monit::params::pluginfile_group}",
        require => Package["monit"],
	notify  => Service["monit"],
        ensure  => present,
        content => template("monit/plugins/$templatefile_checkpid"),
    }

}
