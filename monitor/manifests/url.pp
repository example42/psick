define monitor::url (
    $url,
    $pattern="",
    $username="",
    $password="",
    $tool,
    $enable
    ) {

if ($enable != "false") and ($enable != "no") and ($enable != false) {

    if ( $debug == "yes" ) or ( $debug == true ) {
        require puppet::params
        require puppet::debug 
    }

    $urlq = regsubst($url , '/' , '-' , 'G') # Needed to create flag todo files seamlessly

    if ($tool =~ /munin/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-url-munin-$urlq": ensure => present } }
    }

    if ($tool =~ /collectd/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-url-collect-$urlq": ensure => present } }
    }

    if ($tool =~ /monit/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-url-monit-$urlq": ensure => present } }
#        monitor::url::monit { "$name":
#            url      => "$url",
#            pattern  => "$pattern",
#        }     
    }

    if ($tool =~ /nagios/) {
        if ( $debug == "yes" ) or ( $debug == true ) { file { "${puppet::params::debugdir}/todo/monitor-url-munin-$urlq": ensure => present } }
    }

} # End if $enable

}

