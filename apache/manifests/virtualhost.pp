# Define: apache::virtualhost
#
# Basic Virtual host management define
# You can use different templates for your apache virtual host files
# Default is virtualhost.conf.erb, adapt it to your needs or create your custom template
# You may need to customize and add variables to your define that are used in the template.
# In this case, add it to the define variables (as documentroot)
#
# Usage:
# With standard template:
# apache::virtualhost    { "www.example42.com": }
# With custom template (create it in MODULEPATH/apache/templates/virtualhost/)
# apache::virtualhost    { "webmail.example42.com": templatefile => "webmail.conf.erb" }
#
define apache::virtualhost ( $templatefile='virtualhost.conf.erb' , $documentroot='' , $enable=true ) {

    require apache::params

    # Defines the documentroot in case is not provided
    if $documentroot { 
        $documentroot_real = $documentroot
    }
    else {      
        $documentroot_real = "${apache::params::documentroot}/${name}"
    }

    file { "ApacheVirtualHost_$name":
        path    => $operatingsystem ? {
            freebsd => "/usr/local/etc/apache20/conf.d/$name.conf",
            ubuntu  => "/etc/apache2/sites-available/$name.conf",
            debian  => "/etc/apache2/sites-available/$name.conf",
            centos  => "/etc/httpd/conf.d/$name.conf",
            redhat  => "/etc/httpd/conf.d/$name.conf",
        },
        require => Package["apache"],
        ensure  => $operatingsystem ? {
            ubuntu  => present,
            debian  => present,
            default => $enable ? {
                true  => present,
                false => absent,
            },
        },
        mode    => "${apache::params::configfile_mode}",
        owner   => "${apache::params::configfile_owner}",
        group   => "${apache::params::configfile_group}",

        content => template("apache/virtualhost/$templatefile"),
    }


    # Some OS specific settings:
    # On Debian/Ubuntu manages sites-enabled 
    # On RedHat/Centos Creates the apache conf file with NameVirtualHost directive

    case $operatingsystem {
        ubuntu,debian: { 
            file { "ApacheVirtualHostEnabled_$name":
                path   => "/etc/apache2/sites-enabled/$name.conf",
                ensure => $enable ? { 
                    true  => "/etc/apache2/sites-available/$name.conf",
                    false => absent,
                },
                require => Package["apache"],
            }
        }
        redhat,centos: { 
            apache::dotconf { "00-NameVirtualHost": content => template("apache/00-NameVirtualHost.conf.erb") } 
        }
        default: { }
    }

}
