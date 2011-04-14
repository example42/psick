# Define: openvpn::tunnel
#
# Manages openvpn tunnels creating an openvpn .conf file
# Availabla variables:
# $mode="server" - Sets general openvpn mode: client or server,
# $remote=""  - Sets remote host/IP. Neeed is client mode
# $port="1194"  - Default is 1194, change with multiple tunnels  
# $proto="udp" - Transport protocol: tcp or udp
# $auth_type  - Authentication method: key, ca
# $auth_key  - Statif Key to use with  $auth_type=key
# $dev="tun"  - tun for Ip routing , tap for bridging mode
# $ifconfig="" 
# $route="",
# $templatefile='' ,
# $enable=true ) {
#
#
define openvpn::tunnel (
    $mode="server",
    $remote="",
    $port="1194",
    $auth_type,
    $auth_key="",
    $proto="tcp",
    $dev="tun",
    $ifconfig="",
    $route="",
    $templatefile="openvpn/default.conf.erb" , 
    $enable=true ) {

    require openvpn::params

    $real_proto = $proto ? {
         udp => "udp",
         tcp => $mode ? {
             "server" => "tcp-server",
             "client" => "tcp-client",
         },
    }

    file { "openvpn_${name}.conf":
        path    => "${openvpn::params::configdir}/${name}.conf",
        mode    => "${openvpn::params::configfile_mode}",
        owner   => "${openvpn::params::configfile_owner}",
        group   => "${openvpn::params::configfile_group}",
        ensure  => present,
        require => Package["openvpn"],
        notify  => Service["openvpn"],
        content => template("${templatefile}"),
    }

if $authkey != "" {
    file { "openvpn_${name}.key":
        path    => "${openvpn::params::configdir}/${name}.key",
        mode    => "644",
        owner   => "${openvpn::params::configfile_owner}",
        group   => "${openvpn::params::configfile_group}",
        ensure  => present,
        require => Package["openvpn"],
        notify  => Service["openvpn"],
        content => "${auth_key}",
    }
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
