#
# Class rsyslog::server::loganalyzer
# 
# Installs LogAnaalyzer for Rsyslog
# Autoloaded if $rsyslog_use_loganalyzer = yes 
#
class rsyslog::server::loganalyzer {
    require rsyslog::params
    require apache::params

    include apache
    php::module { mysql: }
    php::module { gd: }

    netinstall { "netinstall_loganalyzer":
        url              => "${rsyslog::params::loganalyzer_url}",
        extracted_dir    => "${rsyslog::params::loganalyzer_dirname}",
        destination_dir  => "${apache::params::documentroot}",
        require          => Package["apache"],
    }

    apache::vhost { "syslog.${domain}":
        port          => '80',
        serveraliases => "syslog.${domain}",
        priority      => '10',
        docroot       => "${apache::params::documentroot}/${rsyslog::params::loganalyzer_dirname}/src",
        template      => 'rsyslog/loganalyzer.conf.erb',
    }

}
