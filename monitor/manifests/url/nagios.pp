#
# Define monitor::url::nagios
#
# Nagios connector for monitor::url abstraction layer
# It's automatically used if "nagios" is present in the $monitor_tool array
# By default it uses Example42 nagios module, it can be adapted for third party modules
# Note that the url check is intended to be run via nrpe on the localhost
#
define monitor::url::nagios (
    $url,
    $target='127.0.0.1',
    $port='80',
    $pattern,
    $username,
    $password,
    $monitorgroup,
    $enable
    ) {

    $ensure = $enable ? {
        "false" => "absent",
        "no"    => "absent",
        "true"  => "present",
        "yes"   => "present",
    }

    # Use for Example42 service checks via nrpe 
    nagios::service { "$name":
        ensure      => $ensure,
        check_command => $username ? {
            undef   => "check_nrpe!check_url!${target}!${port}!${url}!${pattern}" ,
            ""      => "check_nrpe!check_url!${target}!${port}!${url}!${pattern}" ,
            default => "check_nrpe!check_url_auth!${target}!${port}!${url}!${pattern}!${username}:${password}" ,
        }
    }

}
