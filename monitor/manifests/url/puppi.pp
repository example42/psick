#
# Define monitor::url::puppi
#
# Connector for Nagios plugins based local checks for monitor::url abstraction layer
# It's automatically used if "puppi" is present in the $monitor_tool array
# Local checks based on Nagios plugins are included in Example42 puppi module
#
define monitor::url::puppi (
    $url,
    $target='127.0.0.1',
    $port='80',
    $pattern,
    $username,
    $password,
    $monitorgroup,
    $enable
    ) {

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
            undef   => "check_http -I '${target}' -p '${port}' -u '${url}' -s '${pattern}'" ,
            ""      => "check_http -I '${target}' -p '${port}' -u '${url}' -s '${pattern}'" ,
            default => "check_http -I '${target}' -p '${port}' -u '${url}' -s '${pattern}' -a ${username}:${password}" ,
        }
    }

}
