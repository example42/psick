# common/manifests/defines/line.pp -- a trivial mechanism to ensure a line exists in a file
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.

# Ensures that a specific line is present or absent in a file. This can
# be very brittle, since even small changes can throw this off.
#
# If the line is not present yet, it will be appended to the file.
# 
# The name of the define is not used. Just keep it (globally) unique and
# descriptive.
#
# Use this only for very trivial stuff. Usually replacing the whole file
# is a more stable solution with less maintenance headaches afterwards.
#
# Usage:
#  line {
#      description:
#             file => "filename",
#          line => "content",
#             ensure => {absent,*present*}
#  }
#
# Example:
# The following ensures that the line "allow ^$munin_host$" exists in
# /etc/munin/munin-node.conf, and if there are any changes notify the
# service for a restart
#
#  line {
#      allow_munin_host:
#          file => "/etc/munin/munin-node.conf",
#          line => "allow ^$munin_host$",
#          ensure => present,
#          notify => Service[munin-node],
#          require => Package[munin-node];
#  }
define line(
    $source = 'Default',
    $file,
    $line,
    $ensure = 'present'
) {
    case $ensure {
        default : { err ( "unknown ensure value '${ensure}'" ) }
        present: {
            exec { "'${source} echo '${line}' >> '${file}'":
                command => "echo '${line}' >> '${file}'",
                unless => "grep -qFx '${line}' '${file}'"
            }
        }
        absent: {
            exec { "'${source}' perl -ni -e 'print if \$_ ne \"${line}\n\";' '${file}'":
                command => "perl -ni -e 'print if \$_ ne \"${line}\n\";' '${file}'",
                onlyif => "grep -qFx '${line}' '${file}'"
            }
        }
    }
}


