import "modules.pp"
import "infrastructure.pp"
import "nodes.pp"
import "roles.pp"

Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

Package { provider => "yum" }

# Centralized backup filebucket
filebucket { main: server => puppet }
filebucket { local: path => "/var/lib/puppet/clientbucket" }
filebucket { server: server => puppet, port=> 8140 }

