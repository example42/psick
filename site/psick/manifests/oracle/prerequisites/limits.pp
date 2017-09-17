# This class configures the limits prerequisites for Oracle installation
# 
# To include and configure it do something like:
# @example
# ---
#   psick::oracle::prerequisites::limits_class: 'psick::oracle::prerequisites::limits'
#   psick::oracle::prerequisites::limits::template: 'psick/oracle/limits/my_oracle.erb'
#   psick::oracle::prerequisites::limits::options:
#     all.nofile.soft = '2048'
#     all.nofile.hard = '8192'
#   psick::oracle::prerequisites::limits::use_defaults: true
#
# @param template Path to the erb template of the /etc/limits file
# @param options An hash of options with values used in the template
# @param use_defaults Define if to use default options or not. Note that if
#                     you set this to false the default template will fail,
#                     so you will need to provide a custom one.
#
class psick::oracle::prerequisites::limits (
  Optional[String] $template = 'psick/oracle/limits/oracle.erb',
  Hash $options              = { },
  Boolean $use_defaults      = true,
) {

  $defaults = {
    'all.nofile.soft'     => '1024',
    'all.nofile.hard'     => '8192',
    'all.stack'           => '10240',
    'oracle.nofile.soft'  => '65536',
    'oracle.nofile.hard'  => '65536',
    'oracle.nproc.soft'   => '2048',
    'oracle.nproc.hard'   => '16384',
    'oracle.memlock.soft' => '1048576',
    'oracle.memlock.hard' => '1048576',
    'oracle.stack.soft'   => '10240',
    'oracle.stack.hard'   => '32768',
  }
  $limits_options = $use_defaults ? {
    true  => $defaults + $options,
    false => $options,
  }

  if $template and $template != '' {
    file { '/etc/security/limits.conf':
      ensure  => file,
      content => template($template),
    }
  }

}
