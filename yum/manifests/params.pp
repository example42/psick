class yum::params  {

# Manage Automatic Updates method
    $update = $yum_update ? {
        "cron"     => "cron",
        "updatesd" => "updatesd",
        default    => "off",
    }

    $extrarepo = $yum_extrarepo

# Base Source
    case $base_source {
        '': {
            $general_base_source = $puppetversion ? {
                /(^0.25)/ => "puppet:///modules",
                /(^0.)/   => "puppet://$servername",
                default   => "puppet:///modules",
            }
        }
        default: { $general_base_source=$base_source }
    }


}

