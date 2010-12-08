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
#    priority => '20',
#    port => '80',
#    docroot => '/path/to/docroot',
#  }
#
define apache::vhost( $port, $docroot, $ssl=true, $template='apache/virtualhosts/virtualhost.conf.erb', $priority, $serveraliases = '' , $enable=true) {

    include apache
    include apache::params

    file {"${apache::params::vdir}/${priority}-${name}.conf":
        content => template($template),
        mode    => "${apache::params::configfile_mode}",
        owner   => "${apache::params::configfile_owner}",
        group   => "${apache::params::configfile_group}",
        require => Package['apache'],
        notify => Service['apache'],
    }

    # Some OS specific settings:
    # On Debian/Ubuntu manages sites-enabled 
    # On RedHat/Centos Creates the apache conf file with NameVirtualHost directive
    case $operatingsystem {
        ubuntu,debian: {
            file { "ApacheVHostEnabled_$name":
                path   => "/etc/apache2/sites-enabled/${priority}-${name}",
                ensure => $enable ? {
                    true  => "/etc/apache2/sites-available/${priority}-${name}",
                    false => absent,
                },
                require => Package["apache"],
            }
            apache::ports { "81": https => "8143" }
        }
        redhat,centos: {
            apache::dotconf { "00-NameVirtualHost": content => template("apache/00-NameVirtualHost.conf.erb") }
        }
        default: { }
    }
}

