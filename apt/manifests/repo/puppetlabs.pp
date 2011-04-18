class apt::repo::puppetlabs {

    # Add puppetlabs repository
    apt::key { "8347A27F": }

    apt::repository { "puppetlabs":
        url        => "http://apt.puppetlabs.com/ubuntu",
        distro     => "${lsbdistcodename}",
        repository => "main",
    }

}

