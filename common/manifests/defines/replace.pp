# common/manifests/defines/replace.pp -- replace a pattern in a file with a string
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# See LICENSE for the full license granted to you.

# A hack to replace all ocurrances of a regular expression in a file with a
# specified string. Sometimes it can be less effort to replace only a single
# value in a huge config file instead of creating a template out of it. Still,
# creating a template is often better than this hack.
#
# This define uses perl regular expressions.
#
# Use this only for very trivial stuff. Usually replacing the whole file is a
# more stable solution with less maintenance headaches afterwards. 
# 
# Usage:
#
# replace { description: 
#       file => "filename",
#       pattern => "regexp",
#       replacement => "replacement"
#
# Example:
# To replace the current port in /etc/munin/munin-node.conf
# with a new port, but only disturbing the file when needed:
#
#  replace {
#      set_munin_node_port:
#          file => "/etc/munin/munin-node.conf",
#          pattern => "^port (?!$port)[0-9]*",
#          replacement => "port $port"
#  }  
define replace($file, $pattern, $replacement) {
    $pattern_no_slashes = regsubst($pattern, '/', '\\/', 'G', 'U')
    $replacement_no_slashes = regsubst($replacement, '/', '\\/', 'G', 'U')

    exec { "replace_${pattern}_${file}":
        command => "/usr/bin/perl -pi -e 's/${pattern_no_slashes}/${replacement_no_slashes}/' '${file}'",
        onlyif => "/usr/bin/perl -ne 'BEGIN { \$ret = 1; } \$ret = 0 if /${pattern_no_slashes}/ && ! /\\Q${replacement_no_slashes}\\E/; END { exit \$ret; }' '${file}'",
        alias => "exec_$name",
    }
}
