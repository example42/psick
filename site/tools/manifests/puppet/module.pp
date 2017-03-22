# Installs a Puppet module for a user
define tools::puppet::module (
  String $user                = 'root',
  String $modulename          = $title,
  Optional[String] $arguments = undef,
) {

  $split_title = split($modulename,'-')
  $creates = $user ? {
    'root'  => "/etc/puppetlabs/code/modules/$split_title[1]",
    default => "/home/%{user}/.puppetlabs/etc/code/modules/$split_title[1]",
  }
  exec { "puppet module install ${modulename}":
    command     => "puppet module install ${modulename} ${arguments}",
    user        => $user,
    creates     => $creates,
  }
}
