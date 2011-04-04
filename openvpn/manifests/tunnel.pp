# Define: openvpn::tunnel
#
# Manages openvpn tunnels creating an openvpn .conf file
# Availabla variables:
# $mode="p2p" - Sets general openvpn mode: p2p or server,
# $remote=""  - Sets remote host/IP
# $port       - Required. 
# $proto="tcp" - Transport protocol: tcp or udp
# $auth_type  - Authentication method: secret, tls-server, or tls-client
# $dev="tun"  - Device to use
# $ifconfig="" 
# $route="",
# $templatefile='' ,
# $enable=true ) {
#
#
define openvpn::tunnel (
    $mode="p2p",
    $remote="",
    $port,
    $auth_type,
    $proto="tcp",
    $dev="tun",
    $ifconfig="",
    $route="",
    $templatefile="openvpn/default.conf.erb" , 
    $enable=true ) {

    require openvpn::params

    file { "${name}.conf":
        path    => "${openvpn::params::configdir}/${name}.conf",
        mode    => "${openvpn::params::configfile_mode}",
        owner   => "${openvpn::params::configfile_owner}",
        group   => "${openvpn::params::configfile_group}",
        ensure  => present,
        require => Package["openvpn"],
        notify  => Service["openvpn"],
        content => template("${templatefile}"),
    }

# Automatic monitoring of port and service
  if $monitor == "yes" { 
    # Port monitoring
    monitor::port { "openvpn_${name}_${proto}_${port}": 
        protocol => "${proto}",
        port     => "${port}",
        target   => "${openvpn::params::monitor_target_real}",
        enable   => "${enable}",
        tool     => "${monitor_tool}",
    }
    
    # Process monitoring 
    monitor::process { "openvpn_${name}_process":
        process  => "${openvpn::params::processname}",
        service  => "${openvpn::params::servicename}",
        pidfile  => "${openvpn::params::pidfile}/${name}.pid",
        argument => "${name}.conf",
        enable   => "${enable}",
        tool     => "${monitor_tool}",
    }
  }
  
# Automatic Firewalling
  if $firewall == "yes" {
    firewall { "openvpn_${name}_${proto}_${port}":
        source      => "${openvpn::pafirewall_source_real}",
        destination => "${openvpn::params::firewall_destination_real}",
        protocol    => "${proto}",
        port        => "${port}",
        action      => "allow",
        direction   => "input",
        enable      => "${enable}",
    }
  }

}
