# This is the default manifest used in Vagrant and PuppetMaster
# environments.
# Here we have a sample $::role driven nodeless setup with a common base profile
# Feel free to modify and adapt to your case.

# Some useful resource defaults for Files and Execs
case $::kernel {
  'Darwin': {
    File {
      owner => 'root',
      group => 'wheel',
      mode  => '0644',
    }
  }
  default: {
    File {
      owner => 'root',
      group => 'root',
      mode  => '0644',
    }
  }
}
Exec {
  path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
}

# Classification option 1 - Profiles defined in Hiera
#  $profiles = hiera_array('profiles',[])
#  $profiles.each | $p | {
#    contain $p
#  }

# Classification option 2 - Classic roles and profiles classes:
#  if $::role and $::role != '' {
#    contain "::role::${::role}"
#  }

