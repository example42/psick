# Class puppet::example42::client
#
# Custom project class for example42 project. Use this to adapt the puppet client settings to your project.
# This class is autoloaded if $my_module == example42 and $my_module_onmodule != yes
# If $my_module_onmodule == yes Puppet tries to autoload example42::puppet::client
# that is:  MODULEPATH/example42/manifests/puppet/client.pp
#
#
class puppet::example42::client inherits puppet::client {

}

