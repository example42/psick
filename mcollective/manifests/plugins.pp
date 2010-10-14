# class mcollective::plugins
# 
# Installs plugins for mcollective
# The sources are based on http://github.com/ripienaar/mcollective-plugins.git
# 
# Usage:
# include mcollective::plugins
#
class mcollective::plugins {

##### AGENTS

    # Filemgr plugin
    mcollective::plugin { "agent/filemgr.rb": source => "agent/filemgr/filemgr.rb" } 

    # Iptables plugin
    mcollective::plugin { "agent/iptables.rb": source => "agent/iptables-junkfilter/iptables.rb" }
    mcollective::plugin { "agent/iptables.ddl": source => "agent/iptables-junkfilter/iptables.ddl" , type => "ddl" }
    if ( $mcollective_client == "yes" ) {
        mcollective::plugin { "mc-iptables": source => "agent/iptables-junkfilter/mc-iptables" , type => "client" }
    }

    # Nagger notify plugin
    mcollective::plugin { "agent/naggernotify.rb": source => "agent/naggernotify/naggernotify.rb" }
    mcollective::plugin { "agent/naggernotify.ddl": source => "agent/naggernotify/naggernotify.ddl" , type => "ddl" }

    # Net test plugin - See README in files directory
    mcollective::plugin { "agent/nettest.rb": source => "agent/nettest/nettest.rb" }
    mcollective::plugin { "agent/nettest.ddl": source => "agent/nettest/nettest.ddl" , type => "ddl" }

    # nrpe plugin
    mcollective::plugin { "agent/nrpe.rb": source => "agent/nrpe/nrpe.rb" }
    mcollective::plugin { "agent/nrpe.ddl": source => "agent/nrpe/nrpe.ddl" , type => "ddl" }
    if ( $mcollective_client == "yes" ) {
        mcollective::plugin { "mc-nrpe": source => "agent/nrpe/mc-nrpe" , type => "client" }
    }

    # package Plugin
    mcollective::plugin { "agent/package.rb": source => "agent/package/puppet-package.rb" }
    mcollective::plugin { "agent/package.ddl": source => "agent/package/package.ddl" , type => "ddl" }
    if ( $mcollective_client == "yes" ) {
        mcollective::plugin { "mc-package": source => "agent/package/mc-package" , type => "client" }
    }

    # process plugin
    mcollective::plugin { "agent/process.rb": source => "agent/process/process.rb" }
    if ( $mcollective_client == "yes" ) {
        mcollective::plugin { "mc-pgrep": source => "agent/process/mc-pgrep" , type => "client" }
    }

    # puppetca plugin
    mcollective::plugin { "agent/puppetca.rb": source => "agent/puppetca/puppetca.rb" }
    mcollective::plugin { "agent/puppetca.ddl": source => "agent/puppetca/puppetca.ddl" , type => "ddl" }

    # puppetd plugin
    mcollective::plugin { "agent/puppetd.rb": source => "agent/puppetd/puppetd.rb" }
    mcollective::plugin { "agent/puppetd.ddl": source => "agent/puppetd/puppetd.ddl" , type => "ddl" }
    if ( $mcollective_client == "yes" ) {
        mcollective::plugin { "mc-puppetd": source => "agent/puppetd/mc-puppetd" , type => "client" }
    }

    # service plugin
    mcollective::plugin { "agent/service.rb": source => "agent/service/puppet-service.rb" }
    mcollective::plugin { "agent/service.ddl": source => "agent/service/service.ddl" , type => "ddl" }
    if ( $mcollective_client == "yes" ) {
        mcollective::plugin { "mc-service": source => "agent/service/mc-service" , type => "client" }
    }

    # urltest plugin
    mcollective::plugin { "agent/urltest.rb": source => "agent/urltest/urltest.rb" }
    mcollective::plugin { "agent/urltest.ddl": source => "agent/urltest/urltest.ddl" , type => "ddl" }
    if ( $mcollective_client == "yes" ) {
        mcollective::plugin { "mc-urltest": source => "agent/urltest/mc-urltest" , type => "client" }
    }

    # vcsmgr plugin
    mcollective::plugin { "agent/vcsmgr.rb": source => "agent/vcsmgr/vcsmgr.rb" }
    mcollective::plugin { "agent/vcsmgr.ddl": source => "agent/vcsmgr/vcsmgr.ddl" , type => "ddl" }


##### Facter FACTS
    mcollective::plugin { "facts/facter.rb": source => "facts/facter/facter.rb" } 

#### MORE TO ADD 

}
