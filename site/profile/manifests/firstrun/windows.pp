# @summary Manages classes executed only at the first Puppet run in windows.
#
# This special class is supposed to be included ONLY at the first Puppet run.
# It's up to user to decide if to enable it (by setting on hiera the key
# firstrun_enable: true and it's up to the user to decide what classes to
# include in this run.
# By default, if included, this class automatically triggers a reboot at the
# end of the first run, and creates an external fact that prevents a reboot
# cycle. Note: the external fact name can be defined by the firstrun_fact hiera
# key. Whatever is its name or value, if this fact is removed a reboot
# is triggered. This is done by using the reboot type from puppetlabs-reboot
# module.
#
# Use cases for this profile:
# - Set a desired hostname on Windows, reboot and join a AD domain
# - Install aws-sdk gem, reboot and have ec2_tags facts since the first real Puppet run
# - Any case where a configuration or some installations have to be done
#   in a separated and never repeating first Puppet run. With or without a
#   system reboot
#
# Note if firstrun_enable: true is set on Hiera on existing nodes, Puppet
# triggers a reboot (once). Set profile::firstrun::windows::reboot to false
# to avoid it.
#
# @example Enable firstrun and configure it to set hostname and reboot
#   firstrun_enable: true
#   profile::firstrun::windows::hostname_class: profile::hostname
#
# @example Enable firstrun and configure it to set hostname and proxy
#   but do not trigger any reboot
#
#   firstrun_enable: true
#   profile::firstrun::windows::hostname_class: profile::hostname
#   profile::firstrun::windows::proxy_class: profile::proxy
#   profile::firstrun::windows::reboot: false
#
# @example Never include this profile and have a normal Puppet run, based
#   on profile::pre, profile::base and the classes defined in the profiles key
#   This is the default behaviour, and the behaviour also when firstrun is
#   enabled and Puppet has already been run
#
#   firstrun_enable: false   
#
# @param manage If to actually manage any resource. Set to false to disable
#   any effect of the firstrun profile.
# @param hostname_class Name of the class to include to manage hostname
# @param repo_class Name of the class to include to manage additional repos
# @param proxy_class Name of the class to include to configure system's proxy server
# @param packages_class Name of the class to include to install packages
# @param users_class Name of the class to include to manage users
# @param reboot If to automatically trigger a reboot after the first run
# @param reboot_apply The apply parameter to pass to reboot type
# @param reboot_when The when parameter to pass to reboot type
# @param reboot_message The message parameter to pass to reboot type
# @param reboot_name The name of the reboot type
# @param reboot_timeout The timeout parameter to pass to reboot type
class profile::firstrun::windows (
  # General switch. If false nothing is done.
  Boolean $manage        = true,
  String $hostname_class = '',
  String $repo_class     = '',
  String $proxy_class    = '',
  String $packages_class = '',
  String $users_class    = '',
  String $fact_value     = 'done',
  Boolean $reboot         = true,
  Enum['immediately','finished'] $reboot_apply = 'finished',
  Enum['refreshed','pending']    $reboot_when  = 'refreshed',
  String $reboot_message  = 'firstboot mode enabled, rebooting after first Puppet run',
  String $reboot_name     = 'Rebooting',
  Integer $reboot_timeout = 60,
) {
  # If $manage is false nothing is done here
  if $manage {
    if $hostname_class != '' {
      contain $hostname_class
      Class[$hostname_class] -> Tools::Puppet::Set_external_fact[$::firstrun_fact]
    }
    if $repo_class != '' {
      contain $repo_class
      Class[$repo_class] -> Tools::Puppet::Set_external_fact[$::firstrun_fact]
    }
    if $proxy_class != '' {
      contain $proxy_class
      Class[$proxy_class] -> Tools::Puppet::Set_external_fact[$::firstrun_fact]
    }
    if $packages_class != '' {
      contain $packages_class
      Class[$packages_class] -> Tools::Puppet::Set_external_fact[$::firstrun_fact]
      if $proxy_class != '' {
        Class[$proxy_class] -> Class[$packages_class]
      }
      if $repo_class != '' {
        Class[$repo_class] -> Class[$packages_class]
      }
    }
    if $users_class != '' {
      contain $users_class
      Class[$users_class] -> Tools::Puppet::Set_external_fact[$::firstrun_fact]
    }
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
