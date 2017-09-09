# @summary Manages classes executed only at the first Puppet run in solaris.
#
# This special class is supposed to be included ONLY at the first Puppet run.
# It's up to user to decide if to enable it (by setting on hiera the key
# firstrun_enable: true and it's up to the user to decide what classes to
# include in this run
#
# @example Enable firstrun and configure it to set hostname and reboot
#   firstrun_enable: true
#   profile::firstrun::solaris::hostname_class: profile::hostname
#   profile::firstrun::solaris::reboot_class: profile::reboot
#
# @param manage If to actually manage any resource. Set to false to disable
#   any effect of the firstrun profile.
# @param hostname_class Name of the class to include to manage hostname
# @param repo_class Name of the class to include to manage additional repos
# @param proxy_class Name of the class to include to configure system's proxy server
# @param packages_class Name of the class to include to install packages
#
class profile::firstrun::solaris (
  # General switch. If false nothing is done.
  Boolean $manage        = true,

  String $hostname_class = '',
  String $repo_class     = '',
  String $proxy_class    = '',
  String $packages_class = '',
  String $facts_class    = '',

  String $fact_value     = 'done',

  Boolean $reboot        = true,
  Enum['immediately','finished'] $reboot_apply = 'finished',
  Enum['refreshed','pending'] $reboot_when     = 'refreshed',
  String $reboot_message     = 'firstboot mode enabled, rebooting after first Puppet run',
  String $reboot_name = 'Rebooting',
  Integer $reboot_timeout    = 60,
) {

  if $hostname_class != '' and $manage {
    contain $hostname_class
    Class[$hostname_class] -> Tools::Puppet::Set_external_fact[$::firstrun_fact]
  }

  if $repo_class != '' and $manage {
    contain $repo_class
    Class[$repo_class] -> Tools::Puppet::Set_external_fact[$::firstrun_fact]
  }

  if $proxy_class != '' and $manage {
    contain $proxy_class
    Class[$proxy_class] -> Tools::Puppet::Set_external_fact[$::firstrun_fact]
  }

  if $packages_class != '' and $manage {
    contain $packages_class
    Class[$packages_class] -> Tools::Puppet::Set_external_fact[$::firstrun_fact]
    if $proxy_class != '' {
      Class[$proxy_class] -> Class[$packages_class]
    }
    if $repo_class != '' {
      Class[$repo_class] -> Class[$packages_class]
    }
  }

  if $manage {
    $fact_notify = $reboot ? {
      false => undef,
      true  => Reboot[$reboot_name],
    }

    tools::puppet::set_external_fact { $::firstrun_fact:
      value  => $fact_value,
      notify => $fact_notify,
    }

    if $reboot {
      reboot { $reboot_name:
        apply   => $reboot_apply,
        message => $reboot_message,
        when    => $reboot_when,
        timeout => $reboot_timeout,
      }
    }
  }

}
