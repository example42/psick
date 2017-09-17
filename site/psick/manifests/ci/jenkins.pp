#
class psick::ci::jenkins (
  String                $ensure   = 'present',

  Variant[Undef,String] $template = undef,
  Hash                  $options  = { },
) {

  include ::psick::java

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
}
