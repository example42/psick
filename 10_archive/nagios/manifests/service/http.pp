# ssl_mode:
#   - false: only check http
#   - true: check http and https
#   - force: http is permanent redirect to https
#   - only: check only https
define nagios::service::http(
    $ensure = present,
    $check_domain = 'absent',
    $check_url = '/',
    $check_code = 'OK',
    $ssl_mode = false
){
    $real_check_domain = $check_domain ? {
    'absent' => $name,
    default => $check_domain
    }
    case $ssl_mode {
    'force',true,'only': {
        nagios::service{"https_${name}_${check_code}":
        ensure => $ensure,
        check_command => "check_https_url_regex!${real_check_domain}!${check_url}!'${check_code}'",
        }
        case $ssl_mode {
        'force': {
            nagios::service{"httprd_${name}":
            ensure => $ensure,
            check_command => "check_http_url_regex!${real_check_domain}!${check_url}!'301'",
            }
        }
        }
    }
    }
    case $ssl_mode {
    false,true: {
        nagios::service{"http_${name}_${check_code}":
        ensure => $ensure,
        check_command => "check_http_url_regex!${real_check_domain}!${check_url}!'${check_code}'",
        }
    }
    }
}
