define monitor::url (
    $url="http://127.0.0.1",
    $target="",
    $port='80',
    $pattern="",
    $username="",
    $password="",
    $monitorgroup="",
    $useragent="",
    $tool,
    $checksource='remote',
    $enable=true
    ) {

    if ( $debug == "yes" ) or ( $debug == true ) {
        require puppet::params
        require puppet::debug 
    }

    # If target is not provided we get it from the Url
    $computed_target = $target ? {
        ''      => urlhostname("$url"),
        default => "${target}",
    }

    $ensure = $enable ? {
        false   => "absent",
        "false" => "absent",
        "no"    => "absent",
        true    => "present",
        "true"  => "present",
        "yes"   => "present",
    }

    $urlq = regsubst($url , '/' , '-' , 'G') # Needed to create flag todo files seamlessly

    if ($tool =~ /munin/) {
    }

    if ($tool =~ /collectd/) {
    }

    if ($tool =~ /monit/) {
    }

    if ($tool =~ /nagios/) {
        # Use for Example42 service checks (note: are used custom Nagios and nrpe commands)  
            nagios::service { "$name":
            ensure      => $ensure,
            check_command => $checksource ? {
                local   => $username ? { # CHECK VIA NRPE STILL DOESN'T WORK WITH & and ? in URLS!
                    undef   => "check_nrpe!check_url!${computed_target}!${port}!${url}!${pattern}!${useragent}" ,
                    ""      => "check_nrpe!check_url!${computed_target}!${port}!${url}!${pattern}!${useragent}" ,
                    default => "check_nrpe!check_url_auth!${computed_target}!${port}!${url}!${pattern}!${username}:${password}!${useragent}" ,
                }, 
                default => $username ? { 
                    undef   => "check_url!${computed_target}!${port}!${url}!${pattern}!${useragent}" ,
                    ""      => "check_url!${computed_target}!${port}!${url}!${pattern}!${useragent}" ,
                    default => "check_url_auth!${computed_target}!${port}!${url}!${pattern}!${username}:${password}!${useragent}" ,
                },
            },
        }
    }

    if ($tool =~ /puppi/) {
        # Use for Example42 puppi checks
        puppi::check { "$name":
            enable   => $enable,
            hostwide => $monitorgroup ? {
                undef   => "yes" ,
                ""      => "yes" ,
                default => "no" ,
            },
            project  => $monitorgroup ,
            command  => $username ? {
                undef   => "check_http -I '${computed_target}' -p '${port}' -u '${url}' -s '${pattern}' -A '${useragent}'" ,
                ""      => "check_http -I '${computed_target}' -p '${port}' -u '${url}' -s '${pattern}' -A '${useragent}'" ,
                default => "check_http -I '${computed_target}' -p '${port}' -u '${url}' -s '${pattern}' -a ${username}:${password} -A '${useragent}'" ,
            }
        }
    }

}

