file {
#    # Module programmers can use /var/lib/puppet/modules/$modulename to save
#    # module-local data, e.g. for constructing config files
    "/var/lib/puppet/modules":
        ensure => directory,
##        source => "puppet://$server/modules/common/modules/",
##        ignore => '\.ignore',
##        recurse => true, purge => true, force => true,
        mode => 0755, owner => root, group => 0;
}

import "*.pp"

class common {
# Some General Use Variables

# Calculate OS version (without using lsb facts)
    $ossplit=split($operatingsystemrelease, '[.]')
    $osver=$ossplit[0]

## FILE SERVING SOURCE
# Sets the correct source for static files
# In order to provide files from different sources without modifyingi a module
# you can override the default source path setting the variable $base_source
# Ex: $base_source="puppet://ip.of.fileserver" or $base_source="puppet://$servername/myprojectmodule"
# What follows automatically manages the source standard for Puppet versions pre and post 0.25
    case $base_source {
        '': {
            $source = $puppetversion ? {
                /(^0.25)/ => "puppet:///modules",
                /(^0.)/   => "puppet://$servername",
                default   => "puppet:///modules",
            }
        }
        default: { $source=$base_source }
    }
}
