define git::clone($url,$path="/srv/git") {

	include git

        exec {
                "git-clone $url":
                        command => "git-clone ${url}",
			cwd	=> "${path}",
                        require => Package[git],
                        onlyif  => "test ! -e ${path}/${name}",
        }
}

