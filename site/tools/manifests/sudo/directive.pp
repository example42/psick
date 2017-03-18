# = Define: tools::sudo::directive
#
# Derived from example42-sudo module
#
# This defines places a directive for the sudoers file
# On old versions of sudo ( < 1.7.2 ) it places a line in
# /etc/sudoers (The Concat module is required for it)
# On more recent versions it just places a file in /etc/sudoers.d
#
# == Parameters
#
# [*content*]
#   Sets the value of content parameter for the sudo fragment.
#   Can be set as an array (joined with newlines)
#
# [*source*]
#   Sets the value of source parameter for the sudo fragment
#
# [*template*]
#   Sets the value of content parameter for the sudo fragment
#   Note: This option is alternative to the source one
#
# [*ensure*]
#   Define if the fragment should be present (default) or 'absent'
#
# [*order*]
#   Sets the order of the fragment inside /etc/sudoers or /etc/sudoers.d
#   Default 20
#
define tools::sudo::directive (
  Enum['present','absent'] $ensure   = present,
  Variant[Undef,String]    $content  = undef,
  Variant[Undef,String]    $template = undef,
  Variant[Undef,String]    $source   = undef,
  Integer                  $order    = 20,
) {

  # sudo skipping file names that contain a "."
  $dname = regsubst($name, '\.', '-', 'G')

  # Define the final content: if $content is set a line break is added at the
  # end, if not, the $template is used, if set.
  $real_content = $content ? {
    undef     => $template ? {
      undef   => undef,
      default => template($template),
    },
    default   => inline_template('<%= [@content].flatten.join("\n") + "\n" %>'),
  }

  # Dependency on exec only when esnure is present
  $syntax_check = $ensure ? {
    'present' => Exec["sudo-syntax-check for file ${dname}"],
    default   => undef,
  }

  $base_name = "/etc/sudoers.d/${order}_${dname}"

  file { $base_name:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => $real_content,
    source  => $source,
    notify  => $syntax_check,
  }

  # Remove the .broken file which can be left over by the sudo-syntax-check.
    # This runs intentionally before the syntax-check to leave the file around for debugging.
  file { "${base_name}.broken":
      ensure => absent,
      before => $syntax_check,
  }

  if $ensure == 'present' {
    exec { "sudo-syntax-check for file ${dname}":
      command     => "visudo -c -f ${base_name} || ( mv -f ${base_name} ${base_name}.broken && exit 1 )",
      refreshonly => true,
      path        => '/bin:/usr/bin:/sbin:/usr/sbin',
    }
  }

}
