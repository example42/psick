# This profile manages ntp client on Windows
# Derived from https://github.com/ncorrare/windowstime
class profile::time::windows (
  Array $ntp_servers = $::profile::time::servers,
  Array $fallback_servers,
  String $timezone = $::profile::settings::timezone,
) {

  $servers_ntp = inline_template("<% @ntp_servers.each do |s| -%><%= s %>,0x01 <% end -%>")
  $servers_fallback = inline_template("<% @fallback_servers.each do |s| -%><%= s %>,0x02 <% end -%>")
  $servers_registry = "${servers_ntp} ${servers_fallback}"
  $system32dir = $facts['os']['windows']['system32']

  registry_value { 'HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\Type':
    ensure => present,
    type   => string,
    data   => 'NTP',
  }
  registry_value { 'HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\NtpServer':
    ensure => present,
    type   => string,
    data   => $servers_registry,
    notify => Service['w32time'],
  }

  exec { 'c:/Windows/System32/w32tm.exe /resync':
    refreshonly => true,
  }

  service { 'w32time':
    ensure => running,
    enable => true,
    notify => Exec['c:/Windows/System32/w32tm.exe /resync'],
  }

  if $timezone {
    if $timezone != $facts['timezone'] {
      exec { "tzutil.exe /s ${timezone}":
        #   command    => "${system32dir}\\tzutil.exe /s \"${timezone}\"",
        command => "tzutil.exe /s \"${timezone}\"",
        unless  => 'echo',
        # unless  => "tzutil.exe /g | findstr /R /C:\"${timezone}\"",
        path => $::path, 
      }
    }
  }

}
