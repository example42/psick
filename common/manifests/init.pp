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



import "classes/*"
import "defines/*"

