# This is the default manifest used in Vagrant and PuppetMaster environments.

# Here we have a sample $::role driven nodeless setup with a common base profile
# a additional classes (profiles) set on Hiera.
# The $::role variable, useful for classification in Hiera, can be set in different ways:
# - As an external fact defined during provisioning
# - Via a ENC like The Foreman or Puppet Enterprise
# - In this same site.pp, extracting the role information from the hostname
# - In this same site.pp, setting the $role var based on pp_role trusted fact
# The latter choice is what is used here, feel free to modify and adapt to your case.

### SETTING TOP SCOPE VARIABLES USED IN HIERA.YAML
# The following lines are used to assign to top-scope variables (used in
# hiera.yaml) the values of eventual trusted facts.
# More info: https://docs.puppet.com/puppet/latest/reference/ssl_attributes_extensions.html
# You may need to change and adapt them according to your hiera.yaml
# You can keep them also if you don't set extended trusted facts.
if defined('$facts') and defined('$trusted') {
  if $trusted['extensions']['pp_role'] and !has_key($facts,'role') {
    $role = $trusted['extensions']['pp_role']
  }
  if $trusted['extensions']['pp_environment'] and !has_key($facts,'env') {
    $env = $trusted['extensions']['pp_environment']
  }
  if $trusted['extensions']['pp_datacenter'] and !has_key($facts,'datacenter') {
    $datacenter = $trusted['extensions']['pp_datacenter']
  }
  if $trusted['extensions']['pp_zone'] and !has_key($facts,'zone') {
    $zone = $trusted['extensions']['pp_zone']
  }
  if $trusted['extensions']['pp_application'] and !has_key($facts,'application') {
    $application = $trusted['extensions']['pp_application']
  }
  # Note: with the above settings we allow overriding of our trusted facts by normal facts.
  # This is done here to adapt to different approaches, if you use trusted facts
  # you will probably want to change the above into something like:
  # if $trusted['extensions']['pp_role'] {
  #   $role = $trusted['extensions']['pp_role']
  # }


  ### RESOURCE DEFAULTS
  # Some resource defaults for Files, Execs and Tiny Puppet
  case $::kernel {
    'Darwin': {
      File {
        owner => 'root',
        group => 'wheel',
        mode  => '0644',
      }
      Exec {
        path => $::path,
      }
    }
    'Windows': {
      File {
        owner => 'Administrator',
        group => 'Administrators',
        mode  => '0644',
      }
      Exec {
        path => $::path,
      }
    }
    default: {
      File {
        owner => 'root',
        group => 'root',
        mode  => '0644',
      }
      Exec {
        path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
      }
    }
  }

  ### ADDITIONS FOR RUNS INSIDE DOCKER IMAGES AND NOOP MODE
  # Building Docker container support
  # This has a fix for service provider on docker
  if $virtual == 'docker' {
    include ::dummy_service
  }

  # A useful trick to manage noop mode via hiera using the key: noop_mode
  # This needs the trlinklin-noop module
  $noop_mode = lookup('noop_mode', Boolean, 'first', false)
  if $noop_mode == true {
    noop()
  }

  # We just do everything in psick module
  include '::psick'

}
