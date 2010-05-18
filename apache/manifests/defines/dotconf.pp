# Define: apache::dotconf
#
# General Apache define to be used to create generic custom .conf files 
# Very simple wrapper to a normal file type
# Use source or template to define the source
#
# Usage:
# apache::dotconf { "sarg": source => 'puppet://$servername/sarg/sarg.conf' }
# or
# apache::dotconf { "trac": content => 'template("trac/apache.conf.erb")' }
#
define apache::dotconf ( $source='' , $content='' ) {

# Silly if statement to manage source|content 
# To be optimized

if $source  { 

    file { "Apache_$name.conf":
        mode => 644, owner => root,
        group => $operatingsystem ?{
            freebsd => "wheel",
            default => "root",
        },
        require => Package["apache"],
        ensure => present,
        path => $operatingsystem ?{
            freebsd => "/usr/local/etc/apache20/conf.d/$name.conf",
            ubuntu  => "/etc/apache2/conf.d/$name.conf",
            debian  => "/etc/apache2/conf.d/$name.conf",
            centos  => "/etc/httpd/conf.d/$name.conf",
            redhat  => "/etc/httpd/conf.d/$name.conf",
        },
              notify => Service["apache"],
               source => $source,
    }

} # End if source 


if $content  { 

    file { "Apache_$name.conf":
        mode => 644, owner => root,
        group => $operatingsystem ?{
            freebsd => "wheel",
            default => "root",
        },
        require => Package["apache"],
        ensure => present,
        path => $operatingsystem ?{
            freebsd => "/usr/local/etc/apache20/conf.d/$name.conf",
            ubuntu  => "/etc/apache2/conf.d/$name.conf",
            debian  => "/etc/apache2/conf.d/$name.conf",
            centos  => "/etc/httpd/conf.d/$name.conf",
            redhat  => "/etc/httpd/conf.d/$name.conf",
        },
        notify => Service["apache"],
               content => $content,
    }

} # End if content

}
