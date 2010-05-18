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
define apache::virtualhost ( $templatefile='virtualhost.conf.erb' , $documentroot='' ) {

# Defines the documentroot in case is not provided
if $documentroot  { 
    $documentroot_real = $documentroot
}
else {      
    case $operatingsystem {
    ubuntu: { $documentroot_real = "/var/www/$name" }
    debian: { $documentroot_real = "/var/www/$name" }
    redhat: { $documentroot_real = "/var/www/html/$name" }
    centos: { $documentroot_real = "/var/www/html/$name" }
        }
}

# Creates the apache conf file with NameVirtualHost directive
case $operatingsystem {
    ubuntu: { }
    debian: { }
    redhat: { apache::dotconf { "00-NameVirtualHost": content => template("apache/00-NameVirtualHost.conf.erb") } }
    centos: { apache::dotconf { "00-NameVirtualHost": content => template("apache/00-NameVirtualHost.conf.erb") } }
}

    file { "ApacheVirtualHost_$name":
        mode => 644, owner => root,
        group => $operatingsystem ?{
            freebsd => "wheel",
            default => "root",
        },
        require => Package["apache"],
        ensure => present,
        path => $operatingsystem ?{
              freebsd => "/usr/local/etc/apache20/conf.d/$name.conf",
            ubuntu  => "/etc/apache2/sites-enabled/$name.conf",
            debian  => "/etc/apache2/sites-enabled/$name.conf",
            centos  => "/etc/httpd/conf.d/$name.conf",
            redhat  => "/etc/httpd/conf.d/$name.conf",
        },
               notify => Service["apache"],
        content => template("apache/virtualhost/$templatefile"),
    }

}
