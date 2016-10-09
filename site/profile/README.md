# Profiles module

This module contains profile classes to be composed and used in different nodes according to any expected combinations.

Here are the essential Hiera configurations needed to costomise the used profiles behaviour.

## ::profile::base::$kernel - Base classes common to all nodes

Base profile is loaded in ```manifests/site.pp``` and is different for each OS: ```contain "::profile::base::${kernel_down}"```.

The base class, different for each Kernel to ease management of common baselines on totally different OS, just exposes parameters that define what classes to use to manage different base configurations which are expected on every node.

To cope with exceptions and edge cases, different classes can be used to manage a specific functionality and if a class name is set to an empty string then no class is loaded for that base set of configurations.

Hiera data is therefore used to define which class names to include, on the different base classes. If a profile doesn't manage a base resource as wanted, it's therefore possible to create and use a different profile for the same function.

A special class in the base profile is the *pre* class, its resources are applied before all the other ones (can be used to manage packages repositories, keys or any other configurations that is needed as prerequisite for everything else).

A pre_class *must* always be defined, even if you don't place any resource inside.

Sample base profile settings for Linux servers:

    profile::base::linux::pre_class: '::profile::pre'
    profile::base::linux::network_class: '::profile::network' # Requires example42-network
    profile::base::linux::mail_class: '::profile::mail::postfix'
    profile::base::linux::puppet_class: 'puppet' # Requires example42-puppet 4.x branch
    profile::base::linux::ssh_class: '::profile::ssh::openssh'
    profile::base::linux::users_class: '::profile::users::static'
    profile::base::linux::sudo_class: '::profile::sudo'
    profile::base::linux::monitor_class: '::profile::monitor'
    profile::base::linux::logs_class: '::profile::logs::rsyslog'
    profile::base::linux::backup_class: '::profile::backup::duply'
    profile::base::linux::time_class: '::profile::time::ntpdate'
    profile::base::linux::timezone_class: '::profile::timezone'
    profile::base::linux::sysctl_class: '::profile::sysctl'
    profile::base::linux::dns_class: '::profile::dns::resolver'
    profile::base::linux::hardening_class: '::profile::hardening'
    profile::base::linux::motd_class: '::profile::motd'
    profile::base::linux::hostname_class: '::profile::hostname'
    profile::base::linux::hosts_class: '::profile::hosts::file'
    profile::base::linux::update_class: '::profile::update'
  
Similarly can be defined bbase profiles for Solaris, Darwin, Windows and other OS families (currently mostly not yet developed):

    profile::base::solaris::timezone_class: '::profile::timezone'
  
Across the Hiera hierarchies these settings can be disabled with (listing some sample classes which MAY be dangerous to apply without proper testing):

    profile::base::linux::ssh_class: ''
    profile::base::linux::network_class: ''
    profile::base::linux::hardening_class: ''
    profile::base::linux::sudo_class: ''

## ::profile::pre - Prerequisites class

This profile class is the only one included by default on the base profiles, so you actually don't need to enable it with a configuration like what follows as this is the default setting for profile::base::linux::pre_class parameter:

    profile::base::linux::pre_class: '::profile::pre'


## ::profile::mail::postfix - Postfix management

This class manages Postfix using Tiny Puppet, it can be included with the parameter:

    profile::base::linux::mail_class: '::profile::mail::postfix'

To customise its behaviour you can set the template to use to manage ```main.cf```, a generic options hash to configure it, and the source directory to use to populate the whole ```/etc/postfix``` directory:

    profile::mail::postfix::config_dir_source: 'puppet:///modules/profile/mail/postfix'
    profile::mail::postfix::config_file_template: 'profile/mail/postfix/main.cf.erb'
    profile::mail::postfix::options: # Looked up via hiera_hash
      relayhost: mail.mn.de.tmo

To explicitly remove postfix and its configuration from the system:

    profile::mail::postfix::ensure: absent

To avoid to manage the configuration file (eventually overriding more general settings):

    profile::mail::postfix::config_file_template: ''

## ::profile::ssh::openssh - Openssh Configuration

This class manages OpenSSH using Tiny Puppet, it can be included with the parameter:

    profile::base::linux::ssh_class: '::profile::openssh::ssh'

To customise its behaviour you can set the template to use to manage ```sshd_config```, a generic options hash to configure them, and the source directory to use to populate the whole ```/etc/ssh``` directory:

    profile::ssh::openssh::config_dir_source: 'puppet:///modules/profile/ssh/openssh'
    profile::ssh::openssh::config_file_template: 'profile/ssh/openssh/sshd_config.erb'
    profile::ssh::openssh::options: # Looked up via hiera_hash
      ListenAddress:
        - 127.0.0.1
        - 0.0.0.0
      PermitRootLogin: yes
 

## ::profile::hosts::file - /etc/hosts management

This class manages /etc/hosts, it can be included with the parameter:

    profile::base::linux::hosts_class: '::profile::hosts::file'

To customise its behaviour you can set the template to use to manage ```/etc/hosts```, and the ipaddress, domain and hostname values for the local node (by default the relevant facts values are used):

    profile::hosts::file::template: 'profile/hosts/file/hosts.erb' # Default value
    profile::hosts::file::ipaddress: '10.0.0.4' # Default: $::ipaddress
    profile::hosts::file::domain: 'domain.com' # Default: $::domain
    profile::hosts::file::hostname: 'www01' # Default: $::hostname


## ::profile::hosts::dynamic - Automatic /etc/hosts management

TODO


## ::profile::monitor::sar - Manage sysstat

This class manages and configures systat (sar), it can be included with the parameter:

    profile::monitor::sysstat_class: '::profile::monitor::sar'

It's possible to customise if to actually install sar, the cron schedule for its execution and the template to use for the cronjob ( content of /etc/cron.d/sysstat ) :

    profile::monitor::sar::ensure: 'present' # Default
    profile::monitor::sar::check_cron: '*/5 * * * *' # Default
    profile::monitor::sar::summary_cron: '53 23 * * *' # Default
    profile::monitor::sar::cron_template: 'profile/monitor/sar/systat.cron.erb' # Default


## ::profile::update - Manage packages updates

This class manages how and when a system should be updated, it can be included with the parameter:

    profile::base::linux::update_class: '::profile::update'

The class just creates a cronjob which runs the system's specific update command. By default the cron schedule is empy so not update is automatically done:

    profile::update::cron_schedule: '0 6 * * *' 

The above setting would create a cron job, executed every day at 6:00 AM, that updates the system's packages.


## ::profile::sudo - Manage sudo

This class manages sudo. It can be included by setting:

    profile::base::linux::sudo_class: '::profile::sudo'

You can configure the template to use for ```/etc/sudoers```, the admins who can sudo on your system (if it's used the default or a compatible template), the Puppet fileserver source for the whole content of the ```/etc/sudoers.d/```:

    profile::sudo::sudoers_template: 'profile/sudo/sudoers.erb' # Default value
    profile::sudo::admins: # Default is [] 
      - al
      - mark
      - bill
    profile::sudo::sudoers_d_source: 'puppet:///modules/site/sudo/sudoers.d' # Default is empty

It's also possible to provide an hash of custom sudo directives to pass to the ```::tools::sudo::directive``` define:

    profile::sudo::directives:
      oracle:
        template: 'profile/sudo/oracle.erb'
        order: 30
      itex:
        content: "Cmnd_Alias    SUITEX = /bin/su - itex, /usr/bin/su - itex\n"
       
The ```::tools::sudo::directive``` define accepts these params (template, content and source are ALTERNATIVE way to manage the content of the sudo file):

    define tools::sudo::directive (
      Enum['present','absent'] $ensure   = present,
      Variant[Undef,String]    $content  = undef,
      Variant[Undef,String]    $template = undef,
      Variant[Undef,String]    $source   = undef,
      Integer                  $order    = 20,
    ) { ...}


## ::profile::monitor - Manage monitoring

This class is a wrapper class to manage different monitor tools and configurations.

Similarly to the base profile, it just exposes parameters to define the classes to include for each functionality. It's included with:

    profile::base::linux::monitor_class: '::profile::monitor'

By default no class is included by the monitor profile and nothing happens until you configure it with something like:

    profile::monitor::incinga_class: '::profile::monitor::incinga'
    profile::monitor::nrpe_class: '::profile::monitor::nrpe'
    profile::monitor::snmp_class: '::profile::monitor::snmpd'


## profile::monitor::snmpd - Manage snmpd

This class installs and configures the snmpd service using Tiny Puppet. To include it:

    profile::monitor::snmp_class: '::profile::monitor::snmpd'

Configuration can be done via the following Hiera params:

    profile::monitor::snmpd::config_dir_source: 'puppet:///modules/profile/monitor/snmpd'
    profile::monitor::snmpd::config_file_template: 'profile/monitor/snmpd/snmpd.conf.erb'
    profile::monitor::snmpd::options:  # Looked up via hiera_hash
      ro_community: n0ts0public

To avoid to manage the configuration file:

    profile::monitor::snmpd::config_file_template: ''


## ::profile::logs::rsyslog - Rsyslog configuration

This class installs and configures Rsyslog using Tiny Puppet. To include it:

    profile::base::linux::logs_class: '::profile::logs::rsyslog'

Common settings for similar profiles:

    profile::logs::rsyslog::config_dir_source: 'puppet:///modules/profile/logs/rsyslog'
    profile::logs::rsyslog::config_file_template: 'profile/logs/rsyslog/rsyslog.conf.erb'
    profile::logs::rsyslog::options: # Looked up via hiera_hash
      remote_host: log.example.com

To explicitly remove postfix and its configuration from the system:

    profile::logs::rsyslog::ensure: absent

To avoid to manage the configuration file (eventually overriding more general settings):

    profile::logs::rsyslog::config_file_template: ''


## ::profile::sysctl - Manage sysctl settings

This class manages sysctl settings. To include it:

    profile::base::linux::sysctl_class: '::profile::sysctl'

Any sysctl setting can be set via Hiera, using the ```profile::sysctl::settings``` key, which expects and hash (looked up via hiera_hash so values across the hierarchies are merged):

    profile::sysctl::settings:
      kernel.shmmni:
        value: 4096
      kernel.sem:
        value: 250 32000 100 128


## ::profile::motd - Manage /etc/motd and /etc/issue files

This class just manages the content of the ```/etc/motd.conf``` and ```/etc/issue``` files. To include it:

    profile::base::linux::motd_class: '::profile::motd'

To customise the content of the provided files:

    profile::motd::motd_file_template: 'profile/motd/motd.erb' # Default value
    profile::motd::issue_file_template: 'profile/motd/issue.erb' # Default value

To avoid to manage these files:

    profile::motd::motd_file_template: ''
    profile::motd::issue_file_template: ''

To remove these files:

    profile::motd::motd_file_ensure: 'absent'
    profile::motd::issue_file_ensure: 'absent'

