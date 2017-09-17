# This class manages the installation and initialisation of rundeck
#
# @param ensure If to install or remove rundeck
# @param auto_prerequisites If to automatically install all the prerequisites
#                           resources needed to install rundeck, if defined in tinydata
# @param template The path to the erb template (as used in template()) to use
#                 to populate the main configuration file.
# @param init_template The path to the erb template (as used in template()) to use
#                      to populate the init script configuration file
# @param options An open hash of options you may use in your template
# 
class psick::rundeck (
  String           $ensure             = 'present',
  Boolean          $auto_prerequisites = true,
  Optional[String] $template           = undef,
  Optional[String] $init_template      = undef,
  Hash             $options            = { },
) {

  $options_default = {
    'framework.server.name'     => $::fqdn,
    'framework.server.hostname' => $::fqdn,
    'framework.server.port'     => '4440',
    'framework.server.url'      => "http://${::fqdn}:4440",
    'framework.ssh.keypath'     => '/var/lib/rundeck/.ssh/id_rsa',
    'framework.ssh.user'        => 'rundeck',
    'framework.ssh.timeout'     => '0',
  }
  $real_options = $options_default + $options

  ::tp::install { 'rundeck' :
    ensure             => $ensure,
    auto_prerequisites => $auto_prerequisites,
  }

  if $template {
    ::tp::conf { 'rundeck':
      ensure       => $ensure,
      template     => $template,
      base_file    => 'config',
      options_hash => $real_options,
    }
  }
  if $init_template {
    ::tp::conf { 'rundeck::init':
      ensure       => $ensure,
      template     => $init_template,
      base_file    => 'init',
      options_hash => $real_options,
    }
  }

}
