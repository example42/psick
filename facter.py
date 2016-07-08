from fabric.api import *

@task
def set_role(role):
  """Configure an external role fact with the given value."""
  sudo ( "mkdir -p /etc/puppetlabs/facter/facts.d && echo 'role=" + str(role) + "' > /etc/puppetlabs/facter/facts.d/role.txt" )

def set_env(env):
  """Configure an external env fact with the given value."""
  sudo ( "mkdir -p /etc/puppetlabs/facter/facts.d && echo 'env=" + str(env) + "' > /etc/puppetlabs/facter/facts.d/env.txt" )

