from fabric.api import *

@task
def apply():
  """Run puppet apply (needs to have this control-repo deployed)"""
  sudo( '$(puppet config print codedir)/environments/production/bin/papply.sh ; echo $?' )

@task
def apply_noop():
  """Run puppet apply in noop mode (needs to have this control-repo deployed)"""
  sudo( '$(puppet config print codedir)/environments/production/bin/papply.sh --noop ; echo $?' )

@task
@parallel(pool_size=4)
def agent():
  """Run puppet agent"""
  sudo( 'puppet agent -t ; echo $?' )

@task
@parallel(pool_size=4)
def agent_noop():
  """Run puppet agent in noop mode"""
  sudo( 'puppet agent -t --noop ; echo $?' )

@task
@parallel(pool_size=4)
def current_config():
  """Show currenly applied version of our Puppet code"""
  sudo( 'cat $(puppet config print lastrunfile) | grep "config: " | cut -d ":" -f 2- ' )

@task
def deploy_controlrepo():
  """Deploy this control repo on a node (Puppet has to be already installed)"""
  put( "bin/setup_controlrepo.sh","/usr/local/bin/setup_controlrepo.sh",mode=755 )
  sudo ( "/usr/local/bin/setup_controlrepo.sh" )

@task
def install_puppet():
  """Install Puppet 4 on a node (for Puppet official repos)"""
  put( "bin/install_puppet.sh","/usr/local/bin/install_puppet.sh",mode=755 )
  sudo ( "/usr/local/bin/install_puppet.sh" )

@task
def module_generate(module=''):
  """Generate a Puppet module based on skeleton"""
  local( "bin/module_generate.sh " + str(module) )
