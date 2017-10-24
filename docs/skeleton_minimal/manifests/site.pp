# This is the default manifest used in Vagrant and PuppetMaster
# environments.
# Feel free to modify and adapt to your case.


### RESOURCE DEFAULTS
# Some resource defaults for Files, Execs and Tiny Puppet
case $::kernel {
  'Darwin': {
    File {
      owner => 'root',
      group => 'wheel',
      mode  => '0644',
    }
    Exec {
      path => $::path,
    }
  }
  'Windows': {
    File {
      owner => 'Administrator',
      group => 'Administrators',
      mode  => '0644',
    }
    Exec {
      path => $::path,
    }
  }
  default: {
    File {
      owner => 'root',
      group => 'root',
      mode  => '0644',
    }
    Exec {
      path => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    }
  }
}

# A useful trick to manage noop mode via hiera using the key: noop_mode
# This needs the trlinklin-noop module
$noop_mode = lookup('noop_mode', Boolean, 'first', false)
if $noop_mode == true {
  noop()
}

# Hiera driven classification: The key 'profiles' contains an array
# of names of classes to include in the catalog
# Example in yaml format:
# ---
# profiles:
#   - openssh
#   - apache
lookup('profiles',Array,'unique',[]).include
