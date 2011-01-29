# Define: lighttpd::dotconf
#
# General lighttpd define to be used to create generic custom .conf files 
# Very simple wrapper to a normal file type
# Use source or template to define the source
#
# Usage:
# lighttpd::dotconf { "sarg": source => 'puppet://$servername/sarg/sarg.conf' }
# or
# lighttpd::dotconf { "trac": content => 'template("trac/lighttpd.conf.erb")' }
#
define lighttpd::dotconf ( $source='' , $content='' ) {

# Silly if statement to manage source|content 
# TODO To be optimized

    require lighttpd::params

    file { "lighttpd_$name.conf":
        mode  => 644,
        owner => "${lighttpd::params::configfile_owner}",
        group => "${lighttpd::params::configfile_group}",
        require => Package["lighttpd"],
        ensure => present,
        path   => "${lighttpd::params::configdir}/$name.conf",
        notify => Service["lighttpd"],
        source => $source ? {
            ''  => undef,
            default  => $source,
        },
        content => $content ? {
            ''  => undef,
            default  => $content,
        },
    }

}
