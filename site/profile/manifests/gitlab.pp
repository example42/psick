#
class profile::gitlab (
  String                $ensure      = 'present',

  Variant[Undef,String] $template    = undef,
  Hash                  $options     = { },

  Boolean $manage_installation       = true,

) {

  if $manage_installation {
    $options_default = {
    }
    $gitlab_options = $options + $options_default
    ::tp::install { 'gitlab-ce' :
      ensure => $ensure,
    }

    if $template {
      ::tp::conf { 'gitlab-ce':
        ensure       => $ensure,
        template     => $template,
        options_hash => $gitlab_options,
        notify       => Exec['gitlab-ctl reconfigure'],
      }
    }

    exec { 'gitlab-ctl reconfigure':
      refreshonly => true,
      timeout     => '600',
      subscribe   => Package['gitlab-ce'],
    }
  }

}
