# Profiles module

This module contains psick classes to be composed and used in different nodes according to any expected combinations.

Here are the essential Hiera configurations needed to costomise the used psicks behaviour.

## ::profile::base::$kernel - Base classes common to all nodes

Base psick is loaded in ```manifests/site.pp``` and is different for each OS: ```contain "::profile::base::${kernel_down}"```.

The base class, different for each Kernel to ease management of common baselines on totally different OS, just exposes parameters that define what classes to use to manage different base configurations which are expected on every node.

To cope with exceptions and edge cases, different classes can be used to manage a specific functionality and if a class name is set to an empty string then no class is loaded for that base set of configurations.

Hiera data is therefore used to define which class names to include, on the different base classes. If a psick doesn't manage a base resource as wanted, it's therefore possible to create and use a different psick for the same function.

A special class in the base psick is the *pre* class, its resources are applied before all the other ones (can be used to manage packages repositories, keys or any other configurations that is needed as prerequisite for everything else).

A pre_class *must* always be defined, even if you don't place any resource inside.

Sample base psick settings for Linux servers:

    profile::base::linux::pre_class: '::profile::pre'
    profile::base::linux::network_class: '::psick::network' # Requires example42-network
    profile::base::linux::mail_class: '::psick::mail::postfix'
    profile::base::linux::puppet_class: 'puppet' # Requires example42-puppet 4.x branch
    profile::base::linux::ssh_class: '::psick::ssh::openssh'
    profile::base::linux::users_class: '::psick::users::static'
    profile::base::linux::sudo_class: '::psick::sudo'
    profile::base::linux::monitor_class: '::psick::monitor'
    profile::base::linux::logs_class: '::psick::logs::rsyslog'
    profile::base::linux::backup_class: '::psick::backup::duply'
    profile::base::linux::time_class: '::psick::time::ntpdate'
    profile::base::linux::timezone_class: '::psick::timezone'
    profile::base::linux::sysctl_class: '::psick::sysctl'
    profile::base::linux::dns_class: '::psick::dns::resolver'
    profile::base::linux::hardening_class: '::psick::hardening'
    profile::base::linux::motd_class: '::psick::motd'
    profile::base::linux::hostname_class: '::psick::hostname'
    profile::base::linux::hosts_class: '::psick::hosts::file'
    profile::base::linux::update_class: '::psick::update'
  
Similarly can be defined bbase psicks for Solaris, Darwin, Windows and other OS families (currently mostly not yet developed):

    profile::base::solaris::timezone_class: '::psick::timezone'
  
Across the Hiera hierarchies these settings can be disabled with (listing some sample classes which MAY be dangerous to apply without proper testing):

    profile::base::linux::ssh_class: ''
    profile::base::linux::network_class: ''
    profile::base::linux::hardening_class: ''
    profile::base::linux::sudo_class: ''

## ::profile::pre - Prerequisites class

This psick class is the only one included by default on the base psicks, so you actually don't need to enable it with a configuration like what follows as this is the default setting for profile::base::linux::pre_class parameter:

    profile::base::linux::pre_class: '::profile::pre'

## ::psick::proxy - Proxy Management

If your servers need a proxy to access the Internet you can include the ```psick::proxy``` class directly in:

    profile::pre::proxy_class: 'psick::proxy'

Proxy settings can be passed either to the global ```psick::settings``` class or directly in ```psick::proxy```. The ```proxy_server``` parameter is an Hash to be defines with:

    psick::settings::proxy_server:
      host: proxy.example.com
      port: 3128
      user: john    # Optional
      password: xxx # Optional
      no_proxy:
        - localhost
        - "%{::domain}"
        - "%{::fqdn}"
      scheme: http

You can customise the components for which proxy should be configured, here are the default params:

    psick::proxy::ensure: present
    psick::proxy::configure_gem: true
    psick::proxy::configure_puppet_gem: true
    psick::proxy::configure_pip: true
    psick::proxy::configure_system: true
    psick::proxy::configure_repo: true


## ::psick::mail::postfix - Postfix management

This class manages Postfix using Tiny Puppet, it can be included with the parameter:

    profile::base::linux::mail_class: '::psick::mail::postfix'

To customise its behaviour you can set the template to use to manage ```main.cf```, a generic options hash to configure it, and the source directory to use to populate the whole ```/etc/postfix``` directory:

    psick::mail::postfix::config_dir_source: 'puppet:///modules/psick/mail/postfix'
    psick::mail::postfix::config_file_template: 'psick/mail/postfix/main.cf.erb'
    psick::mail::postfix::options: # Looked up via hiera_hash
      relayhost: mail.mn.de.tmo

To explicitly remove postfix and its configuration from the system:

    psick::mail::postfix::ensure: absent

To avoid to manage the configuration file (eventually overriding more general settings):

    psick::mail::postfix::config_file_template: ''

## ::psick::ssh::openssh - Openssh Configuration

This class manages OpenSSH using Tiny Puppet, it can be included with the parameter:

    profile::base::linux::ssh_class: '::psick::openssh::ssh'

To customise its behaviour you can set the template to use to manage ```sshd_config```, a generic options hash to configure them, and the source directory to use to populate the whole ```/etc/ssh``` directory:

    psick::ssh::openssh::config_dir_source: 'puppet:///modules/psick/ssh/openssh'
    psick::ssh::openssh::config_file_template: 'psick/ssh/openssh/sshd_config.erb'
    psick::ssh::openssh::options: # Looked up via hiera_hash
      ListenAddress:
        - 127.0.0.1
        - 0.0.0.0
      PermitRootLogin: yes
 

## ::psick::hosts::file - /etc/hosts management

This class manages /etc/hosts, it can be included with the parameter:

    profile::base::linux::hosts_class: '::psick::hosts::file'

To customise its behaviour you can set the template to use to manage ```/etc/hosts```, and the ipaddress, domain and hostname values for the local node (by default the relevant facts values are used):

    psick::hosts::file::template: 'psick/hosts/file/hosts.erb' # Default value
    psick::hosts::file::ipaddress: '10.0.0.4' # Default: $::ipaddress
    psick::hosts::file::domain: 'domain.com' # Default: $::domain
    psick::hosts::file::hostname: 'www01' # Default: $::hostname


## ::psick::hosts::dynamic - Automatic /etc/hosts management

TODO


## ::psick::monitor::sar - Manage sysstat

This class manages and configures systat (sar), it can be included with the parameter:

    psick::monitor::sysstat_class: '::psick::monitor::sar'

It's possible to customise if to actually install sar, the cron schedule for its execution and the template to use for the cronjob ( content of /etc/cron.d/sysstat ) :

    psick::monitor::sar::ensure: 'present' # Default
    psick::monitor::sar::check_cron: '*/5 * * * *' # Default
    psick::monitor::sar::summary_cron: '53 23 * * *' # Default
    psick::monitor::sar::cron_template: 'psick/monitor/sar/systat.cron.erb' # Default


## ::psick::update - Manage packages updates

This class manages how and when a system should be updated, it can be included with the parameter:

    profile::base::linux::update_class: '::psick::update'

The class just creates a cronjob which runs the system's specific update command. By default the cron schedule is empy so not update is automatically done:

    psick::update::cron_schedule: '0 6 * * *' 

The above setting would create a cron job, executed every day at 6:00 AM, that updates the system's packages.


## ::psick::sudo - Manage sudo

This class manages sudo. It can be included by setting:

    profile::base::linux::sudo_class: '::psick::sudo'

You can configure the template to use for ```/etc/sudoers```, the admins who can sudo on your system (if it's used the default or a compatible template), the Puppet fileserver source for the whole content of the ```/etc/sudoers.d/```:

    psick::sudo::sudoers_template: 'psick/sudo/sudoers.erb' # Default value
    psick::sudo::admins: # Default is [] 
      - al
      - mark
      - bill
    psick::sudo::sudoers_d_source: 'puppet:///modules/site/sudo/sudoers.d' # Default is empty

It's also possible to provide an hash of custom sudo directives to pass to the ```::tools::sudo::directive``` define:

    psick::sudo::directives:
      oracle:
        template: 'psick/sudo/oracle.erb'
        order: 30
       
The ```::tools::sudo::directive``` define accepts these params (template, content and source are ALTERNATIVE way to manage the content of the sudo file):

    define tools::sudo::directive (
      Enum['present','absent'] $ensure   = present,
      Variant[Undef,String]    $content  = undef,
      Variant[Undef,String]    $template = undef,
      Variant[Undef,String]    $source   = undef,
      Integer                  $order    = 20,
    ) { ...}


## ::psick::monitor - Manage monitoring

This class is a wrapper class to manage different monitor tools and configurations.

Similarly to the base psick, it just exposes parameters to define the classes to include for each functionality. It's included with:

    profile::base::linux::monitor_class: '::psick::monitor'

By default no class is included by the monitor psick and nothing happens until you configure it with something like:

    psick::monitor::incinga_class: '::psick::monitor::incinga'
    psick::monitor::nrpe_class: '::psick::monitor::nrpe'
    psick::monitor::snmp_class: '::psick::monitor::snmpd'


## psick::monitor::snmpd - Manage snmpd

This class installs and configures the snmpd service using Tiny Puppet. To include it:

    psick::monitor::snmp_class: '::psick::monitor::snmpd'

Configuration can be done via the following Hiera params:

    psick::monitor::snmpd::config_dir_source: 'puppet:///modules/psick/monitor/snmpd'
    psick::monitor::snmpd::config_file_template: 'psick/monitor/snmpd/snmpd.conf.erb'
    psick::monitor::snmpd::options:  # Looked up via hiera_hash
      ro_community: n0ts0public

To avoid to manage the configuration file:

    psick::monitor::snmpd::config_file_template: ''


## ::psick::logs::rsyslog - Rsyslog configuration

This class installs and configures Rsyslog using Tiny Puppet. To include it:

    profile::base::linux::logs_class: '::psick::logs::rsyslog'

Common settings for similar psicks:

    psick::logs::rsyslog::config_dir_source: 'puppet:///modules/psick/logs/rsyslog'
    psick::logs::rsyslog::config_file_template: 'psick/logs/rsyslog/rsyslog.conf.erb'
    psick::logs::rsyslog::options: # Looked up via hiera_hash
      remote_host: log.example.com

To explicitly remove postfix and its configuration from the system:

    psick::logs::rsyslog::ensure: absent

To avoid to manage the configuration file (eventually overriding more general settings):

    psick::logs::rsyslog::config_file_template: ''


## ::psick::sysctl - Manage sysctl settings

This class manages sysctl settings. To include it:

    profile::base::linux::sysctl_class: '::psick::sysctl'

Any sysctl setting can be set via Hiera, using the ```psick::sysctl::settings``` key, which expects and hash (looked up via hiera_hash so values across the hierarchies are merged):

    psick::sysctl::settings:
      kernel.shmmni:
        value: 4096
      kernel.sem:
        value: 250 32000 100 128


## ::psick::motd - Manage /etc/motd and /etc/issue files

This class just manages the content of the ```/etc/motd.conf``` and ```/etc/issue``` files. To include it:

    profile::base::linux::motd_class: '::psick::motd'

To customise the content of the provided files:

    psick::motd::motd_file_template: 'psick/motd/motd.erb' # Default value
    psick::motd::issue_file_template: 'psick/motd/issue.erb' # Default value

To avoid to manage these files:

    psick::motd::motd_file_template: ''
    psick::motd::issue_file_template: ''

To remove these files:

    psick::motd::motd_file_ensure: 'absent'
    psick::motd::issue_file_ensure: 'absent'


# Profiles not in baseline

## ::psick::oracle - Manages prerequisites and installation

This psick should be added to oracle servers. By default it does nothing, but, activating the relevant parameters, it allows
the configuration of all the prerequisites for Oracle 12 installation and, if installation files are available, it can automate the installation of Oracle products (via the biemond/oradb external module).

Main use case is the configuration for prerequisites. This can be done with:

    psicks:
      psick::oracle

    # Activate the prerequisites class that manages /etc/limits
    psick::oracle::prerequisites::limits_class: 'psick::oracle::prerequisites::limits'

    # Activate the prerequisites class that manages packages
    psick::oracle::prerequisites::packages_class: 'psick::oracle::prerequisites::packages'


    # Activate the prerequisites class that manages users
    psick::oracle::prerequisites::users_class: 'psick::oracle::prerequisites::users'
    psick::oracle::prerequisites::users::has_asm: true # Set this on servers with asm

    # Activate the prerequisites class that manages sysctl
    psick::oracle::prerequisites::sysctl_class: 'psick::oracle::prerequisites::sysctl'
    profile::base::linux::sysctl_class: '' # The base default sysctl class conflicts with the above

    # Activate the prerequisites class that cretaes a swap file (needs petems/swap_file module)
    # psick::oracle::prerequisites::swap_class: 'psick::oracle::prerequisites::swap'

    # Activate the dirs class and create a set of dirs for Oracle data
    psick::oracle::prerequisites::dirs_class: 'psick::oracle::prerequisites::dirs'
    psick::oracle::prerequisites::dirs::base_dir: '/data/oracle' # Default value
    psick::oracle::prerequisites::dirs::owner: 'oracle'          # Default value
    psick::oracle::prerequisites::dirs::group: 'dba'             # Default value
    psick::oracle::prerequisites::dirs::dirs:
     app1:
       - 'db1'
       - 'db2'
     app2:
       - 'db1'
   psick::oracle::prerequisites::dirs::suffixes:   # Default value is ''
     - '_DATA'
     - '_FRA'

with the above settings the following directories are created:

    /data/oracle/app1_DATA/db1
    /data/oracle/app1_DATA/db2
    /data/oracle/app1_FRA/db1
    /data/oracle/app1_FRA/db2
    /data/oracle/app2_DATA/db1
    /data/oracle/app2_FRA/db1


