class collectd::plugins {

    # General "plugin" (quick autoload of most common plugins. TODO: Split into different specific plugins files)
    collectd::plugin { "general": ensure => present } 

    # Network plugin. Necessary for distributed and centralized monitoring
    collectd::plugin { "network": ensure => present } # This uses Users's variablesa

    # Other plugins
    collectd::plugin { "syslog": ensure => present } 

}
