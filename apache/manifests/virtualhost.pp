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
define apache::virtualhost ( $templatefile='virtualhost.conf.erb' , $documentroot='' , $enable=true , $filename='', $aliases='') {

    require apache::params

    # Defines the documentroot in case is not provided
    if $filename { 
        $filename_real = $filename
    }
    else {      
        $filename_real = "${name}"
    }

    # Defines the documentroot in case is not provided
    if $documentroot {
        $documentroot_real = $documentroot
    }
    else {
        $documentroot_real = "${name}"
    }

    file { "ApacheVirtualHost_$name":
        path    => $operatingsystem ? {
            freebsd => "/usr/local/etc/apache20/conf.d/$filename_real.conf",
            ubuntu  => "/etc/apache2/sites-available/$filename_real",
            debian  => "/etc/apache2/sites-available/$filename_real",
            centos  => "/etc/httpd/conf.d/$filename_real.conf",
            redhat  => "/etc/httpd/conf.d/$filename_real.conf",
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
                path   => "/etc/apache2/sites-enabled/$filename_real",
                ensure => $enable ? { 
                    true  => "/etc/apache2/sites-available/$filename_real",
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

    # This define manage different roles and projects
    apache::virtualhost::custom { "$name":
        templatefile => $templatefile,
        documentroot => $documentroot,
        enable => $enable,
        filename => $filename,
	aliases => $aliases,
    }

}
