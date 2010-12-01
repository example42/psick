# Class puppet::example42::server
#
# Custom project class for example42 project. Use this to adapt the puppet server settings to your project.
# This class is autoloaded if $my_module == example42 and $my_module_onmodule != yes
# If $my_module_onmodule == yes Puppet tries to autoload example42::puppet::server
# that is:  MODULEPATH/example42/manifests/puppet/server.pp
#
class puppet::example42::server inherits puppet::server {
    File["puppet.conf"] {
        content => template("puppet/example42/server/puppet.conf.erb"),
    }

    File["namespaceauth.conf"] {
        content => template("puppet/example42/server/namespaceauth.conf.erb"),
    }

}
