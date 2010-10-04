# Define: monit::checkurl
#
# Basic URL checking define, with or without content
#
# Usage:
# With standard template:
# monit::checkurl    { "hostname": }
#
# Standard template is too vanilla, a better usage:
# monit::checkurl    {
#     "hostname":
#     fqdn       => "hostname.example42.com",
#     url        => "http://hostname.example42.com/check/something.php",
#     content    => "OKK",
#     failaction => "exec /etc/restart.d/script.sh",
# }
#
define monit::checkurl ( $templatefile="", $fqdn="", $url="", $content="", $failaction="" ) {

    require monit::params

    # Check name, required
    $name_checkurl = "$name"

    # Template file
    $templatefile_checkurl = $templatefile ? {
        ''      => "checkurl.erb",
        default => $templatefile,
    }

    # FQDN
    $fqdn_checkurl = $fqdn ? {
        ''      => "$name.example42.com",
        default => $fqdn,
    }

    # URL to check
    $url_checkurl = $url ? {
        ''      => "http://$fqdn/",
        default => $url,
    }

    # Content to check, optional
    $content_checkurl = "$content"

    # Emergency fail action
    $failaction_checkurl = $failaction ? {
        ''      => "alert",
        default => $failaction,
    }

    
    file { "MonitCheckUrl_$name":
        path    => "${monit::params::pluginsdir}/$name",
        mode    => "${monit::params::pluginfile_mode}",
        owner   => "${monit::params::pluginfile_owner}",
        group   => "${monit::params::pluginfile_group}",
        require => Package["monit"],
        notify  => Service["monit"],
        ensure  => present,
        content => template("monit/plugins/$templatefile"),
    }

}
