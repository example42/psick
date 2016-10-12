from fabric.api import *
from fabric.contrib.project import rsync_project
import subprocess
main_dir = subprocess.check_output("git rev-parse --show-toplevel", shell=True).rstrip()

@task
def setup(options=''):
  """[local] Setup the contro-repo, installs r10k and external modules"""
  local( main_dir + "/bin/puppet_setup.sh " + str(options) )

@task
def check_syntax(file=''):
  """[local] Check the syntax of all .pp .erb .yaml files in the contro-repo"""
  local( main_dir + "/bin/puppet_check_syntax.sh " + str(file) )

@task
def apply(options=''):
  """[remote] Run puppet apply on the deployed control-repo (uses control-repo in the environments/production dir)"""
  sudo( '$(puppet config print codedir)/environments/production/bin/papply.sh ' + str(options) + ' ; echo $?' )

@task
def sync_and_apply(role='UNDEFINED',proxy='UNDEFINED',options='',fqdn='UNDEFINED'):
  """[remote] Run puppet apply on a synced copy of the local git repo (syncs and uses control-repo in the environments/fabric_test dir)"""
  if proxy == "UNDEFINED":
    sshoptions = ""
  else:
    sshoptions = "-o \"ProxyCommand ssh -A -x -W %h:%p " + proxy + "\""
  rsync_project(extra_opts='--delete', ssh_opts='' + str(sshoptions) + '',local_dir='.', remote_dir='/home/' + env.user + '/puppet-controlrepo', exclude='.git')
  sudo( 'rm /etc/puppetlabs/code/environments/fabric_test && ln -sf /home/' + env.user + '/puppet-controlrepo/ /etc/puppetlabs/code/environments/fabric_test')
  sudo( 'ln -sf /home/' + env.user + '/puppet-controlrepo /home/' + env.user + '/puppet-controlrepo/fabric_test')
  if role == "UNDEFINED":
    exportrole = "true"
  else:
    exportrole = "export FACTER_role=" + role
  if fqdn == "UNDEFINED":
    exporthostname = "true"
  else:
    exporthostname = "export FACTER_fqdn=" + fqdn + "; export FACTER_hostname=" + fqdn.partition('.')[0] + "; export FACTER_domain=" + fqdn.partition('.')[2]
  sudo( exportrole + ';' + exporthostname + '; $(puppet config print environmentpath)/fabric_test/bin/papply.sh --environment=fabric_test ' + str(options) + ' ; echo $?' )
  sudo( 'rm -f /home/' + env.user + '/puppet-controlrepo/keys/private_key.pkcs7.pem' )

@task
def remote_setup(options=''):
  """[remote] Installs on a remote node the packages needed for a puppet apply run on the control-repo"""
  put( "bin/functions","/var/tmp/functions",mode=755 )
  put( "bin/puppet_setup.sh","/var/tmp/puppet_remote_setup.sh",mode=755 )
  sudo( "/var/tmp/puppet_remote_setup.sh " + str(options) )

@task
def apply_noop(options=''):
  """[remote] Run puppet apply in noop mode (needs to have this control-repo deployed)"""
  sudo( '$(puppet config print codedir)/environments/production/bin/papply.sh --noop ' + str(options) + ' ; echo $?' )

@task
@parallel(pool_size=4)
def agent():
  """[remote] Run puppet agent"""
  sudo( 'puppet agent -t ; echo $?' )

@task
@parallel(pool_size=4)
def agent_noop():
  """[remote] Run puppet agent in noop mode"""
  sudo( 'puppet agent -t --noop ; echo $?' )

@task
@parallel(pool_size=4)
def current_config():
  """[remote] Show currently applied version of our Puppet code"""
  sudo( 'cat $(puppet config print lastrunfile) | grep "config: " | cut -d ":" -f 2- ' )

@task
def deploy_controlrepo():
  """[remote] Deploy this control repo on a node (Puppet has to be already installed)"""
  put( "bin/puppet_deploy_controlrepo.sh","/var/tmp/puppet_deploy_controlrepo.sh",mode=755 )
  sudo ( "/var/tmp/puppet_deploy_controlrepo.sh" )

@task
def install(os=''):
  """[remote] Install Puppet 4 on a node (for Puppet official repos)"""
  put( "bin/puppet4_install.sh","/var/tmp/puppet4_install.sh",mode=755 )
  sudo ( "/var/tmp/puppet4_install.sh " + str(os) )
  
@task
def module_generate(module=''):
  """[local] Generate a Puppet module based on skeleton"""
  local( main_dir + "/bin/puppet_module_generate.sh " + str(module) )
