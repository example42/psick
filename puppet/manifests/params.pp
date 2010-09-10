class puppet::params  {

# Settings that User can define (if not defined, defaults set here apply).
# They are mostly related to PuppetMaster functionality.

# Full hostname of Puppet server
    $server = $puppet_server ? {
        ''      => "puppet",
        default => "$puppet_server",
    }

# Access lists for Puppetmaster access (can be an array)
# You should SET IT 
    $allow = $puppet_allow ? {
        ''      => [ "*.$domain" , "127.0.0.0" ],
        default => $puppet_allow,
    }


# Use a node tool ($puppet_nodetool). Default: undef
    $nodetool = $puppet_nodetool ? {
        dashboard => "dashboard",
        foreman   => "foreman",
        default   => undef,
    }

# Use external nodes qualifiers to manage nodes ($puppet_externalnodes). Default: no
# Note that you can still define a $puppet_nodetool and leave $puppet_externalnodes=no
# But if you set $puppet_externalnodes=yes you MUST define a valid $puppet_nodetool
    $externalnodes = $puppet_externalnodes ? {
        yes  => "yes",
        no   => "no",
        default => "no",
    }

# Use passenger (Apache's mod_ruby) instead of default WebBrick ($puppet_passenger). Default: no
    $passenger = $puppet_passenger ? {
        yes  => "yes",
        no   => "no",
        default => "no",
    }

# Use storeconfigs, needed for exported resources ($puppet_storeconfigs). Default: no
    $storeconfigs = $puppet_storeconfigs ? {
        yes  => "yes",
        no   => "no",
        default => "no",
    }

# Define Puppet DB backend for storeconfigs, needed only if $puppet_storeconfigs=yes ($puppet_db). Default: sqlite
    $db = $puppet_db ? {
        sqlite  => "sqlite",
        mysql   => "mysql",
#        postgresql   => "postgresql", # Not yet supported
        default => "sqlite",
    }

# Define Puppet DB server ($puppet_db_server). Default: localhost
    $db_server = $puppet_db_server ? {
        ''      => "localhost",
        default => "$puppet_db_server",
    }

# Define Puppet DB user ($puppet_db_user). Default: root
    $db_user = $puppet_db_user ? {
        ''      => "root",
        default => "$puppet_db_user",
    }

# Define Puppet DB password ($puppet_db_password). Default: blank
    $db_password = $puppet_db_password ? {
        ''      => "",
        default => "$puppet_db_password",
    }

# Define Puppet version. Autocalculated: "0.2" for 0.24/0.25 "old" versions, 2.x for new 2.6.x branch.
    $version =  $puppetversion ? {
        /(^0.)/   => "0.2",
        default   => "2.x",
    }



# Module's internal variables
    $packagename = $operatingsystem ? {
        solaris => "CSWpuppet",
        default => "puppet",
    }

    $servicename = $operatingsystem ? {
        solaris => "puppetd",
        default => "puppet",
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/puppet/puppet.conf",
        default => "/etc/puppet/puppet.conf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $configdir = $operatingsystem ? {
        freebsd => "/usr/local/etc/puppet/",
        default => "/etc/puppet",
    }

    $basedir = $operatingsystem ? {
        redhat  => "/usr/lib/ruby/site_ruby/1.8/puppet",
        centos  => "/usr/lib/ruby/site_ruby/1.8/puppet",
        default => "/usr/lib/ruby/1.8/puppet",
    }

# Sets the correct source for static files
# In order to provide files from different sources without modifying the module
# you can override the default source path setting the variable $base_source
# Ex: $base_source="puppet://ip.of.fileserver" or $base_source="puppet://$servername/myprojectmodule"
# What follows automatically manages the new source standard (with /modules/) from 0.25 

    case $base_source {
        '': { $general_base_source="puppet://$servername" }
        default: { $general_base_source=$base_source }
    }

    $puppet_source = $puppetversion ? {
        /(^0.25)/ => "$general_base_source/modules/puppet",
        /(^0.)/   => "$general_base_source/puppet",
        default   => "$general_base_source/modules/puppet",
    }

}

