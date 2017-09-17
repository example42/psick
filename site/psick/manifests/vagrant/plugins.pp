# Installs the Vagrant plugins needed for the control repo
class psick::vagrant::plugins (
  Array $plugins         = [] ,
  Array $default_plugins = [ 'vagrant-hostmanager' , 'vagrant-vbguest' ,  'vagrant-cachier', 'vagrant-triggers' , 'vagrant-pe_build'],
  String $user           = 'root',
) {

  include ::psick::vagrant

  $all_plugins = $default_plugins + $plugins

  $all_plugins.each | $plugin | {
    ::vagrant::plugin { $plugin:
      user => $user,
    }
  }
}

