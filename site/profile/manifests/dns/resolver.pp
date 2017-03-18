# This class manages /etc/resolv.conf
# Based on ghoneycutt-dnsclient
class profile::dns::resolver (
  Array $nameservers           = ['8.8.8.8','8.8.4.4'],
  Optional[Array] $options     = undef,
  Optional[Array] $search      = undef,
  Optional[String] $domain     = undef,
  Optional[Array] $sortlist    = undef,
  String $resolver_path        = '/etc/resolv.conf',
  String $resolver_template    = 'profile/dns/resolver/resolv.conf.erb',
) {

  if $::virtual != 'docker' {
    file { $resolver_path:
      ensure  => present,
      content => template($resolver_template),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }
}
