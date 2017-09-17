# This class configures the sysctl prerequisites for Oracle installation
# 
# To include and configure it do something like:
#
# @example
# ---
#   psick::oracle::prerequisites::sysctl_class: 'psick::oracle::prerequisites::sysctl'
#   psick::oracle::prerequisites::sysctl::template: 'psick/oracle/sysctl/my_oracle.erb'
#   psick::oracle::prerequisites::sysctl::options:
#     shmmax = '536870912'
#     shmall = '2097152'
#   psick::oracle::prerequisites::sysctl::use_defaults: true
#   psick::oracle::prerequisites::sysctl::auto_tune: true
# 
# @param template Path to the erb template of the /etc/sysctl file
# @param options An hash of options with values used in the template
# @param use_defaults Define if to use default options or not. Note that if
#                     you set this to false the default template will fail,
#                     so you will need to provide a custom one.
# @param auto_tune Define if you want to enable automatic tuning based on RAM
#                  of the default options
#
class psick::oracle::prerequisites::sysctl (
  Optional[String] $template = 'psick/oracle/sysctl/sysctl.erb',
  Hash $options              = { },
  Boolean $use_defaults      = true,
  Boolean $auto_tune         = false,
) {

  if $auto_tune {
    $memsize = to_bytes($::memorysize)
    $shmmax = floor(0.5 * $memsize)
    $swapsize = $shmmax
    $memlock = $shmmax
    $pagesize = '4096'
    $shmall = floor($memsize / $pagesize)
  } else {
    $shmmax = '536870912'
    $shmall = '2097152'
  }

  $defaults = {
    'kernel.msgmnb'                 => '65536',
    'kernel.msgmax'                 => '65536',
    'kernel.shmall'                 => $shmall,
    'kernel.shmmax'                 => $shmmax,
    'kernel.sem'                    => '250 32000 100 128',
    'kernel.shmmni'                 => '4096',
    'fs.file-max'                   => '6815744',
    'fs.aio-max-nr'                 => '1048576',
    'net.ipv4.tcp_keepalive_time'   => '1800',
    'net.ipv4.tcp_keepalive_intvl'  => '30',
    'net.ipv4.tcp_keepalive_probes' => '5',
    'net.ipv4.tcp_fin_timeout'      => '30',
    'net.ipv4.ip_local_port_range'  => '9000 65500',
    'net.core.rmem_default'         => '262144',
    'net.core.rmem_max'             => '4194304',
    'net.core.wmem_default'         => '262144',
    'net.core.wmem_max'             => '1048576',
    'vm.hugetlb_shm_group'          => '1876',
    'vm.nr_hugepages'               => '1025',
    'kernel.semmsl'                 => '250',
    'kernel.semmns'                 => '3000',
    'kernel.semopm'                 => '100',
  }
  $sysctl_options = $use_defaults ? {
    true  => $defaults + $options,
    false => $options,
  }

  if $template and $template != '' {
    file { '/etc/sysctl.conf':
      ensure  => file,
      content => template($template),
    }
  }

  exec { 'sysctl -p':
    subscribe   => File['/etc/sysctl.conf'],
    command     => 'cat /etc/sysctl.conf /etc/sysctl.d/*.conf | sysctl -p -',
    refreshonly => true,
  }
}
