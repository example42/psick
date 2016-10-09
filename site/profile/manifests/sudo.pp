# Generic class to manage sudo
#
class profile::sudo (
  String                   $sudoers_template = '',
  Array                    $admins           = [ ],
  Variant[String[1],Undef] $sudoers_d_source = undef,
) {

  if $sudoers_template != '' {
    file { '/etc/sudoers':
      ensure  => present,
      mode    => '0440',
      owner   => 'root',
      group   => 'root',
      content => template($sudoers_template),
      notify  => Exec['sudo_syntax_check'],
    }
    file { '/etc/sudoers.broken':
      ensure => absent,
      before => Exec['sudo_syntax_check'],
    }
    exec { 'sudo_syntax_check':
      command     => 'visudo -c -f /etc/sudoers && ( cp -f /etc/sudoers /etc/sudoers.lastgood ) || ( mv -f /etc/sudoers /etc/sudoers.broken ; cp /etc/sudoers.lastgood /etc/sudoers ; exit 1) ',
      refreshonly => true,
    }
  }

  file { '/etc/sudoers.d':
    ensure => directory,
    mode   => '0440',
    owner  => 'root',
    group  => 'root',
    source => $sudoers_d_source,
  }

  $directives = hiera_hash('profile::sudo::directives', {})
  $directives.each |$name,$opts| {
    ::tools::sudo::directive { $name:
      * => $opts,
    }
  }
}
