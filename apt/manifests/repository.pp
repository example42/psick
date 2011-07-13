# Define: apt::repository
#
# Add repository to /etc/apt/sources.list.d
#
# Usage:
#  apt::repository { "name":
#      url => 'repository url',
#      distro => 'distrib name',
#      repository => 'repository name(s)'
#      source => false
#  }
#
# For example, to add the standard Ubuntu Lucid repository, you can use
#
#   apt::repository { "ubuntu":
#      url        => "http://it.archive.ubuntu.com/ubuntu/",
#      distro     => 'lucid',
#      repository => 'main restricted',
#   } 
# This will make the file /etc/apt/sources.list.d/ubuntu.list
# with content:
#
#   deb http://it.archive.ubuntu.com/ubuntu/ lucid main restricted
#
# If you have specified the source => true (the default is false), the line
# was:
#
#   deb-src http://it.archive.ubuntu.com/ubuntu/ lucid main restricted
#
define apt::repository (
    $url,
    $distro,
    $repository,
    $key='',
    $key_url='',
    $source=false
) { 
    include apt

    # Create repository file
    file { "${name}.list":
        path    => "/etc/apt/sources.list.d/${name}.list",
        mode    => "644",
        owner   => "root",
        group   => "root",
        require => File["/etc/apt/sources.list.d"],
        ensure  => present,
        content => template("apt/repository.list.erb"),
	notify  => Exec["aptget_update"],
    }

  if $key {
    case $key_url {
        '' : { 
            exec { "aptkey_add_${key}":
                command => "gpg --recv-key ${key} ; gpg -a --export | apt-key add -",
                unless  => "apt-key list | grep -q ${key}",
            }
        }
        default: {  
            exec { "aptkey_add_${key}":
                command => "wget -O - ${key_url} | apt-key add -",
	        unless  => "apt-key list | grep -q ${key}",
            }
        }
    }
  }
}

