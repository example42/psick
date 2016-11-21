# Create a directory and its eventual parents
#
define tools::create_dir (
  Optional[String] $owner = undef,
  Optional[String] $group = undef,
) {
  exec { "mkdir -p ${title}":
    path    => '/bin:/sbin:/usr/sbin:/usr/bin',
    creates => $title,
  }
  if $owner {
    exec { "chown ${owner} ${title}":
      path   => '/bin:/sbin:/usr/sbin:/usr/bin',
      onlyif => "[ $(ls -ld ${title} | awk '{ print \$3 }') != ${owner} ]",
    }
  }
  if $group {
    exec { "chgrp ${group} ${title}":
      path   => '/bin:/sbin:/usr/sbin:/usr/bin',
      onlyif => "[ $(ls -ld ${title} | awk '{ print \$4 }') != ${group} ]",
    }
  }
}
