# A system to construct files using fragments from other files or templates.
#
# This requires at least puppet 0.25 to work correctly as we use some 
# enhancements in recursive directory management and regular expressions
# to do the work here.
#
# USAGE:
# The basic use case is as below:
#
# concat{"/etc/named.conf": 
#    notify => Service["named"]
# }
#
# concat::fragment{"foo.com_config":
#    target  => "/etc/named.conf",
#    order   => 10,
#    content => template("named_conf_zone.erb")
# }
#
# # add a fragment not managed by puppet so local users 
# # can add content to managed file
# concat::fragment{"foo.com_user_config":
#    target  => "/etc/named.conf",
#    order   => 12,
#    ensure  => "/etc/named.conf.local"
# }
#
# This will use the template named_conf_zone.erb to build a single 
# bit of config up and put it into the fragments dir.  The file
# will have an number prefix of 10, you can use the order option
# to control that and thus control the order the final file gets built in.
#
# SETUP:
# The class concat::setup defines a variable $concatdir - you should set this
# to a directory where you want all the temporary files and fragments to be
# stored.  Avoid placing this somewhere like /tmp since you should never
# delete files here, puppet will manage them.
#
# There's some regular expression magic to figure out the puppet version but
# if you're on an older 0.24 version just set $puppetversion = 24
#
# Before you can use any of the concat features you should include the 
# class concat::setup somewhere on your node first.
#
# DETAIL:
# We use a helper shell script called concatfragments.sh that gets placed
# in /usr/local/bin to do the concatenation.  While this might seem more 
# complex than some of the one-liner alternatives you might find on the net
# we do a lot of error checking and safety checks in the script to avoid 
# problems that might be caused by complex escaping errors etc.
# 
# LICENSE:
# Apache Version 2
#
# LATEST:
# http://github.com/ripienaar/puppet-concat/
#
# CONTACT:
# R.I.Pienaar <rip@devco.net> 
# Volcane on freenode
# @ripienaar on twitter
# www.devco.net


# Sets up so that you can use fragments to build a final config file, 
#
# OPTIONS:
#  - mode       The mode of the final file
#  - owner      Who will own the file
#  - group      Who will own the file
#  - force      Enables creating empty files if no fragments are present
#  - warn       Adds a normal shell style comment top of the file indicating
#               that it is built by puppet
#  - backup     Controls the filebucketing behavior of the final file and
#               see File type reference for its use.  Defaults to 'puppet'
#
# ACTIONS:
#  - Creates fragment directories if it didn't exist already
#  - Executes the concatfragments.sh script to build the final file, this script will create
#    directory/fragments.concat.   Execution happens only when:
#    * The directory changes 
#    * fragments.concat != final destination, this means rebuilds will happen whenever 
#      someone changes or deletes the final file.  Checking is done using /usr/bin/cmp.
#    * The Exec gets notified by something else - like the concat::fragment define
#  - Copies the file over to the final destination using a file resource
#
# ALIASES:
#  - The exec can notified using Exec["concat_/path/to/file"] or Exec["concat_/path/to/directory"]
#  - The final file can be referened as File["/path/to/file"] or File["concat_/path/to/file"]  
define concat($mode = 0644, $owner = "root", $group = "root", $warn = "false", $force = "false", $backup = "puppet", $gnu = "true", $order="alpha") {
    $safe_name   = regsubst($name, '/', '_', 'G')
    $concatdir   = $concat::setup::concatdir
    $version     = $concat::setup::majorversion
    $fragdir     = "${concatdir}/${safe_name}"
    $concat_name = "fragments.concat.out"
    $default_warn_message = '# This file is managed by Puppet. DO NOT EDIT.'

    case $warn {
        'true',true,yes,on:   { $warnmsg = "$default_warn_message" }
        'false',false,no,off: { $warnmsg = "" }
        default:              { $warnmsg = "$warn" }
    }

    $warnmsg_escaped = regsubst($warnmsg, "'", "'\\\\''", 'G')
    $warnflag = $warnmsg_escaped ? {
        ''      => '',
        default => "-w '$warnmsg_escaped'"
    }

    case $force {
        'true',true,yes,on: { $forceflag = "-f" }
        'false',false,no,off: { $forceflag = "" }
        default: { fail("Improper 'force' value given to concat: $force") }
    }

    case $gnu {
        'true',true,yes,on: { $gnuflag = "" }
        'false',false,no,off: { $gnuflag = "-g" }
        default: { fail("Improper 'gnu' value given to concat: $gnu") }
    }

    case $order {
        numeric: { $orderflag = "-n" }
        alpha: { $orderflag = "" }
        default: { fail("Improper 'order' value given to concat: $order") }
    }

    File{
        owner  => root,
        group  => root,
        mode   => $mode,
        backup => $backup
    }

    file{$fragdir:
            ensure   => directory;

         "${fragdir}/fragments":
            ensure   => directory,
            recurse  => true,
            purge    => true,
            force    => true,
            ignore   => [".svn", ".git", ".gitignore"],
            source   => $version ? {
                            24      => "puppet:///concat/null",
                            default => undef,
                        },
            notify   => Exec["concat_${name}"];

         "${fragdir}/fragments.concat":
            ensure   => present;

         "${fragdir}/${concat_name}":
            ensure   => present;

         $name:
            source   => "${fragdir}/${concat_name}",
            owner    => $owner,
            group    => $group,
            checksum => md5,
            mode     => $mode,
            ensure   => present,
            alias    => "concat_${name}";
    }

    exec{"concat_${name}":
        user      => root,
        group     => root,
        notify    => File[$name],
        subscribe => File[$fragdir],
        alias     => "concat_${fragdir}",
        require   => [ File["/usr/local/bin/concatfragments.sh"], File[$fragdir], File["${fragdir}/fragments"], File["${fragdir}/fragments.concat"] ],
        unless    => "/usr/local/bin/concatfragments.sh -o ${fragdir}/${concat_name} -d ${fragdir} -t ${warnflag} ${forceflag} ${orderflag} ${gnuflag}",
        command   => "/usr/local/bin/concatfragments.sh -o ${fragdir}/${concat_name} -d ${fragdir} ${warnflag} ${forceflag} ${orderflag} ${gnuflag}",
    }
}
