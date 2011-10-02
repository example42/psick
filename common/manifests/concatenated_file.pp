# common/manifests/defines/concatenated_file.pp -- create a file from snippets
# stored in a directory
#
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.

# TODO:
# * create the directory in _part too

# Usage:
# concatenated_file { "/etc/some.conf":
#     dir => "/etc/some.conf.d",
# }
# Use Exec["concat_$name"] as Semaphor
define concatenated_file (
    # where the snippets are located
    $dir = '',
    # a file with content to prepend
    $header = '',
    # a file with content to append
    $footer = '',
    $mode = 0644, $owner = root, $group = 0
    )
{

    $dir_real = $dir ? { '' => "${name}.d", default => $dir }

    if defined(File[$dir_real]) {
        debug("${dir_real} already defined")
    } else {
        file {
            $dir_real:
                source => "puppet://$server/modules/common/empty",
                checksum => mtime,
                ignore => '\.ignore',
                recurse => true, purge => true, force => true,
                mode => $mode, owner => $owner, group => $group,
                notify => Exec["concat_${name}"];
        }
    }

    file {
        $name:
            ensure => present, checksum => md5,
            mode => $mode, owner => $owner, group => $group;
    }

    # if there is a header or footer file, add it
    $additional_cmd = $header ? {
        '' => $footer ? {
            '' => '',
            default => "| cat - '${footer}' "
        },
        default => $footer ? { 
            '' => "| cat '${header}' - ",
            default => "| cat '${header}' - '${footer}' "
        }
    }

    # use >| to force clobbering the target file
    exec { "concat_${name}":
        command => "/usr/bin/find ${dir_real} -maxdepth 1 -type f ! -name '*puppettmp' -print0 | sort -z | xargs -0 cat ${additional_cmd} >| ${name}",
        refreshonly => true,
        subscribe => [ File[$dir_real] ],
        before => File[$name],
        alias => [ "concat_${dir_real}"] ,
    }
}


# Add a snippet called $name to the concatenated_file at $dir.
# The file can be referenced as File["cf_part_${name}"]
define concatenated_file_part (
    $dir, $content = '', $ensure = present,
    $mode = 0644, $owner = root, $group = 0 
    )
{

    file { "${dir}/${name}":
        ensure => $ensure, content => $content,
        mode => $mode, owner => $owner, group => $group,
        alias => "cf_part_${name}",
        notify => Exec["concat_${dir}"],
    }

}
