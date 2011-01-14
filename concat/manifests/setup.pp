# Sets up the concat system.
#
# $concatdir should point to a place where you wish the fragments to
# live. This should not be somewhere like /tmp since ideally these files
# should not be deleted ever, puppet should always manage them
#
# $puppetversion should be either 24 or 25 to enable a 24 compatible
# mode, in 24 mode you might see phantom notifies this is a side effect
# of the method we use to clear the fragments directory.
# 
# The regular expression below will try to figure out your puppet version
# but this code will only work in 0.24.8 and newer.
#
# It also copies out the concatfragments.sh file to /usr/local/bin
class concat::setup {
    $concatdir = "/var/lib/puppet/concat"
    $majorversion = regsubst($puppetversion, '^[0-9]+[.]([0-9]+)[.][0-9]+$', '\1')

    file{"/usr/local/bin/concatfragments.sh": 
            owner  => root,
            group  => root,
            mode   => 755,
            source => $majorversion ? {
                        24      => "puppet:///concat/concatfragments.sh",
                        default => "puppet:///modules/concat/concatfragments.sh"
                      };

         $concatdir: 
            ensure => directory,
            owner  => root,
            group  => root,
            mode   => 755;
    }
}

# vi:tabstop=4:expandtab:ai
