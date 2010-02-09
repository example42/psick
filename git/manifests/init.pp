class git {

	$git_basedir="/srv/git"
        
	package { "git":
                name => $operatingsystem ? {
                        default => "git",
                        },
                ensure => present,
        }

}

import "classes/*.pp"
import "definitions/*.pp"
