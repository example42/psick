define git::gitweb($gitrepo) {

#	import git::server
#	import lightttpd

        exec {
                "git-instaweb $gitrepo":
                        command => "cd ${git_basedir} ; git-instaweb",
                        require => [ File["${git_basedir}/${gitrepo}"] , Package["lighttpd"] ],
                        unless => "ps -adef | grep lighttpd | grep ${gitrepo}",
        }
}

