# This class manages PAM settings
#
# @param system_auth_template Path of the erb template (as used in template())
#                             used to manage the content of pam system-auth.
#                             By default a proper template for the underlying OS
#                             is used. Note: currently only RHEL 7 derivatives
#                             are supported.
# @param password_auth_template Path of the erb template (as used in template())
#                               used to manage the content of pam passwotd-auth.
#                               By default a proper template for the underlying
#                               OS is used. Note: currently only RHEL 7
#                               derivatives are supported.
# @param login_defs_template Path of the erb template (as used in template())
#                            used to manage the content of /etc/login.defs
#                            If empty the file is not managed.
# @params options An open hash of options that can be used in the provided
#                 templates. It's merged with some defaults options defined in
#                 the class. Note: this variable is not a class param but looked
#                 up via hiera_hash('psick::hardening::pam::options', {} )
#
# @example To set password age settings:
#   psick::hardening::pam::login_defs_template: 'psick/hardening/pam/login.defs.erb'
#   psick::hardening::pam::options:
#     password_max_age: 30
#     password_min_age: 7
#
class psick::hardening::pam (
  String $system_auth_template   = '',
  String $password_auth_template = '',
  String $login_defs_template    = '',
) {

  $options_user=hiera_hash('psick::hardening::pam::options', {} )
  $options_default = {
    umask                    => '027',
    password_max_age         => 60,
    password_min_age         => 7,
    password_warb_age        => 7,
    ttygroup                 => 'tty',
    ttyperm                  => '0600',
    uid_min                  => 1000,
    uid_max                  => 60000,
    gid_min                  => 1000,
    gid_max                  => 60000,
    encrypt_method           => 'SHA512',
    login_retries            => 5,
    login_timeout            => 60,
    sha_crypt_max_rounds     => 10000,
    chfn_restrict            => '',
    allow_login_without_home => false,
    additional_user_paths    => '',
  }
  $options=merge($options_default,$options_user)

  $real_system_auth_template = $system_auth_template ? {
    ''     => "psick/hardening/pam/system-auth_${::os['family']}${::os['release']['major']}",
    default => $system_auth_template,
  }
  $real_password_auth_template = $password_auth_template ? {
    ''     => "psick/hardening/pam/password-auth_${::os['family']}${::os['release']['major']}",
    default => $password_auth_template,
  }

  if $login_defs_template != '' {
    file { '/etc/login.defs':
      ensure  => file,
      content => template($login_defs_template),
      owner   => root,
      group   => root,
      mode    => '0400',
    }
  }
  if ( $::os['family'] == 'RedHat' and $::os['release']['major'] == '7' ) {
    file { '/etc/pam.d/system-auth-ac':
      content => template($real_system_auth_template),
    }
    file { '/etc/pam.d/password-auth-ac':
      content => template($real_password_auth_template),
    }
  }

}
