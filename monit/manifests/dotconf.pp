# Define: monit::dotconf
#
# General monit define to be used to create generic custom .conf files 
# Very simple wrapper to a normal file type
# Use source or template to define the source
#
# Usage:
# monit::dotconf { "sarg": source => 'puppet://$servername/sarg/sarg.conf' }
# or
# monit::dotconf { "trac": content => 'template("trac/monit.conf.erb")' }
#
define monit::dotconf ( $source='' , $content='' ) {

# Silly if statement to manage source|content 
# TODO To be optimized

if $source  { 

    file { "Monit_$name":
        mode => 600,
	owner => root,
        group => $operatingsystem ?{
            default => "root",
        },
        require => Package["monit"],
        ensure => present,
        path => $operatingsystem ?{
            default => "/etc/monit.d/$name",
        },
        notify => Service["monit"],
        source => $source,
    }

} # End if source 


if $content  { 

    file { "Monit_$name":
        mode => 600,
	owner => root,
        group => $operatingsystem ?{
            default => "root",
        },
        require => Package["monit"],
        ensure => present,
        path => $operatingsystem ?{
            default => "/etc/monit.d/$name",
        },
        notify => Service["monit"],
        content => $content,
    }

} # End if content

}
