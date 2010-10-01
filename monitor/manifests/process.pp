define monitor::process (
    $process,
    $service,
    $pidfile,
    $tool,
    $enable
    ) {

if ($enable != "false") and ($enable != "no") and ($enable != false) {

    if ( $debug == "yes" ) or ( $debug == true ) {
        require puppet::params
        require puppet::debug 
    }

    if ($tool =~ /munin/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-process-munin-$process": ensure => present } }
    }

    if ($tool =~ /collectd/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-process-collectd-$process": ensure => present } }
    }

    if ($tool =~ /monit/) {
        monitor::process::monit { "$name":
            pidfile => "$pidfile",
            process => "$process",
            service => "$service",
        }
    }

    if ($tool =~ /nagios/) {
        monitor::process::nagios { "$name":
            process => $process,
        }
    }

} # End if $enable


if ($debug != "false") and ($debug != "no") and ($debug != false) {

    include puppet::params
    file { "puppet_debug_variables_monitor-$name":
        path    => "${puppet::params::debugdir}/variables/monitor-$name",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("monitor/variables_process.erb"),
    }

} # End if $debug

}

