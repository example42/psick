#
class profile::ci::jenkins (
  String                $ensure      = 'present',

  Variant[Undef,String] $template    = undef,
  Hash                  $options     = { },

  Boolean               $manage_user = false,
  Hash                  $user_hash   = { },
) {

  include ::profile::java

  $options_default = {
  }
  $jenkins_options = $options + $options_default
  ::tp::install { 'jenkins' :
    ensure => $ensure,
  }

  if $template {
    ::tp::conf { 'jenkins':
      ensure       => $ensure,
      template     => $template,
      options_hash => $jenkins_options,
    }
  }

  if $manage_user {
    user { 'jenkins':
      * => $user_hash,
    }
  }

}
