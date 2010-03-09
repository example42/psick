class nagios::headless {
    $nagios_httpd = 'absent'
    include nagios
}
