from fabric.api import *
import subprocess
main_dir = subprocess.check_output("git rev-parse --show-toplevel", shell=True).rstrip()

@task
def status():
  """[local] Run git status on this repo and the installed modules"""
  local( main_dir + '/bin/git_status.sh' )

@task
def checkout_master(module=''):
  """[local] Run git checkout master on each on the installed modules"""
  local( main_dir + '/bin/git_checkout_master.sh' )

@task
def install_hooks(url=''):
  """[local] Install Puppet .git/hooks"""
  local( main_dir + '/bin/git_install_hooks.sh ' + url )

@task
def setup_new_repo(repo=''):
  """[local] Create a new repo from scratch, based on the current contents of this control-repo"""
  local( main_dir + '/bin/git_setup_new_repo.sh ' + repo )

