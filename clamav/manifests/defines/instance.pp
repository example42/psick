# Define clamav::instance
#
# Specific Clamav define to manage different clamd instances.
# Based on the (questionable) logic used in EPEL clamav packages.
# Use this only for Clamav installations based on EPEL packages for RedHat/Centos
# Note that every call to this define by default creates a new service and a new user
#
# Usage:
# clamav::instance    { "mailscanner": }
# The above creates a clamd.mailscanner user, if you want to define your own user
# (eventually the one of the application that uses this instance) specify it:
# clamav::instance    { "mailscanner":  user => "postfix" }

define clamav::instance ($user='') {

case $user {
	'': { $clamd_user = "clamd" }
	default:  { $clamd_user = $user }
}

        service {
                "clamd.$name":
                enable    => "true",
                ensure    => "running",
                require => File["clamd.sysconfig-$name"],
        }

        user {
                "$clamd_user":
                        ensure  => "present",
#                        comment => "Clamd user for instance $name",
#                        shell   => "/sbin/nologin",
        }

        file { "clamd.conf-$name":
                mode => 644, owner => root, group => root,
                require => [Package["clamav-daemon"],Package["clamav"]],
                ensure => present,
                path => "/etc/clamd.d/$name.conf",
		content => template("clamav/instance/clamd.conf.erb"),
        }

        file { "clamd.log-$name":
                mode => 664, owner => root, group => $clamd_user,
                require => [Package[clamav-daemon],User[$clamd_user]],
                ensure => present,
                path => $operatingsystem ?{
                        default => "/var/log/clamd.$name",
                },
        }

        file { "clamd.logrotate-$name":
                mode => 644, owner => root, group => root,
                require => Package[clamav-daemon],
                ensure => present,
                path => $operatingsystem ?{
                        default => "/etc/logrotate.d/clamd.$name",
                },
		content => template("clamav/instance/clamd.logrotate.erb"),
        }

        file { "clamd.sysconfig-$name":
                mode => 644, owner => root, group => root,
                require => File["clamd.conf-$name"],
                ensure => present,
                path => $operatingsystem ?{
                        default => "/etc/sysconfig/clamd.$name",
                },
		content => template("clamav/instance/clamd.sysconfig.erb"),
        }

        file { "clamd.init-$name":
                mode => 755, owner => root, group => root,
                require => Package[clamav-daemon],
                ensure => present,
                path => $operatingsystem ?{
                        default => "/etc/init.d/clamd.$name",
                },
		content => template("clamav/instance/clamd.init.erb"),
        }

        file { "clamd.link-$name":
                ensure => "/usr/sbin/clamd",
                path  => "/usr/sbin/clamd.$name",
        }

        file { "clamd.sockdir-$name":
                ensure => directory,
                path  => "/var/run/clamd.$name",
                mode => 775, owner => $clamd_user, group => root,
        }

}
