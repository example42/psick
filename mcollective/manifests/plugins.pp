# class mcollective::plugins
# 
# This class selects and installs mcollective-plugins from various sources 
#
# The sources are based on
# puppetlabs repo : http://github.com/puppetlabs/mcollective-plugins.git
# ripienaar repo : http://github.com/ripienaar/mcollective-plugins.git
# example42 repo : http://github.com/example42/mcollective-plugins-puppi.git
# extra repo : Various sources
# 
# Usage:
# include mcollective::plugins
#
class mcollective::plugins {

    include mcollective::params

#### puppetlabs repo
#    git::clone {"puppetlabs-mcollective-plugins":
#        url => "http://github.com/puppetlabs/mcollective-plugins.git",
#        path => "${mcollective::params::libdir}/mcollective/",
#    }

#### Example42 Experiments 
    mcollective::plugin { "agent/puppi.rb": source => "agent/puppi/puppi.rb" , repo => "example42" }
    mcollective::plugin { "agent/puppi.ddl": source => "agent/puppi/puppi.ddl" , type => "ddl" , repo => "example42" }
    if ( $mcollective_client == "yes" ) {
        mcollective::plugin { "mc-puppi": source => "agent/puppi/mc-puppi" , type => "client" , repo => "example42" }
    }


    mcollective::plugin { "agent/nrpe.rb": source => "agent/nrpe/nrpe.rb" , repo => "example42" }
    mcollective::plugin { "agent/nrpe.ddl": source => "agent/nrpe/nrpe.ddl" , type => "ddl" , repo => "example42" }
    if ( $mcollective_client == "yes" ) {
        mcollective::plugin { "mc-nrpe": source => "agent/nrpe/mc-nrpe" , type => "client" , repo => "example42" }
    }
 
#### Extra repo
    mcollective::plugin { "agent/apt.rb": source => "agent/apt/apt.rb" , repo => "extra" }
    mcollective::plugin { "agent/apt.ddl": source => "agent/apt/apt.ddl" , type => "ddl" , repo => "extra" }
    if ( $mcollective_client == "yes" ) {
        mcollective::plugin { "mc-apt": source => "agent/apt/mc-apt" , type => "client" , repo => "extra" }
    }

}
