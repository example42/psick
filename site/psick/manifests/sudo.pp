# Generic class to manage sudo
#
# @param sudoers_template The erb template to use for /etc/sudoers If empty the
#                         file is not managed
# @param admins The array of the users to add to the admin group
# @param sudoers_d_source The source (as used in source => ) to use to populate
#                         the /etc/sudoers.d directory
# @param purge_sudoers_dir If to purge all the files existing on the local node
#                          and not present in sudoers_d_source
# @param directives An hash of sudo directives to pass to tools::sudo::directive
#                   Note this is not a real class parameter but a key looked up
#                   with hiera_hash('psick::sudo::directives', {})
#
class psick::sudo (
  String                   $sudoers_template  = '',
  Array                    $admins            = [ ],
  Variant[String[1],Undef] $sudoers_d_source  = undef,
  Boolean                  $purge_sudoers_dir = false,
) {

  if $sudoers_template != '' {
    file { '/etc/sudoers':
      ensure  => file,
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
    ensure  => directory,
    mode    => '0440',
    owner   => 'root',
    group   => 'root',
    source  => $sudoers_d_source,
    recurse => true,
    purge   => $purge_sudoers_dir,
  }

  $directives = hiera_hash('psick::sudo::directives', {})
  $directives.each |$name,$opts| {
    ::tools::sudo::directive { $name:
      * => $opts,
    }
  }

  if $::virtual == 'virtualbox' and $purge_sudoers_dir {
    tools::sudo::directive { 'vagrant':
      source => 'puppet:///modules/psick/sudo/vagrant',
      order  => 30,
    }
  }
}
