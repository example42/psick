define mcollective::plugin ( $source , $type="plugin" , $repo="puppetlabs" ) {

   include mcollective::params

   $localpath = $type ? {
       client  => "/usr/local/bin/${name}",
       default => "${mcollective::params::libdir}/mcollective/${name}",
   }

   file { "${localpath}":
        owner   => root,
        group   => root,
        mode    => $type ? {
            client  => "0555",
            default => "0444",
        },
        require => Package["mcollective"],
        notify  => Service["mcollective"],
        source  => "${mcollective::params::general_base_source}/mcollective/mcollective-plugins/$repo/${source}",
   }

}
