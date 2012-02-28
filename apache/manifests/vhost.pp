# Definition: apache::vhost
#
# This class installs Apache Virtual Hosts
#
# Parameters:
# - The $port to configure the host on
# - The $docroot provides the DocumentationRoot variable
# - The $ssl option is set true or false to enable SSL for this Virtual Host
# - The $template option specifies whether to use the default template or override
# - The $priority of the site
# - The $serveraliases of the site
#
# Actions:
# - Install Apache Virtual Hosts
#
# Requires:
# - The apache class
#
# Sample Usage:
#  apache::vhost { 'site.name.fqdn':
#  priority => '20',
#  port => '80',
#  docroot => '/path/to/docroot',
#  }
#
define apache::vhost (
  $docroot,
  $port          = '80',
  $ssl           = false,
  $template      = 'apache/virtualhost/virtualhost.conf.erb',
  $priority      = '50',
  $serveraliases = '',
  $enable        = true ) {

  include apache
  include apache::params

  file { "${apache::params::vdir}/${priority}-${name}.conf":
    content => template($template),
    mode    => $apache::params::configfile_mode,
    owner   => $apache::params::configfile_owner,
    group   => $apache::params::configfile_group,
    require => Package['apache'],
    notify  => Service['apache'],
  }

  # Some OS specific settings:
  # On Debian/Ubuntu manages sites-enabled 
  case $operatingsystem {
    ubuntu,debian,mint: {
      file { "ApacheVHostEnabled_$name":
        path   => "/etc/apache2/sites-enabled/${priority}-${name}.conf",
        ensure => $enable ? {
          true  => "${apache::params::vdir}/${priority}-${name}.conf",
          false => absent,
        },
        require => Package["apache"],
      }
    }
    redhat,centos,scientific,fedora: {
      include apache::redhat
    }
    default: { }
  }

}
