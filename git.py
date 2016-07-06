from fabric.api import *
import subprocess
main_dir = subprocess.check_output("git rev-parse --show-toplevel", shell=True).rstrip()

@task
def status():
  """Check git status on this repo and the installed modules"""
  local( main_dir + '/bin/git_status.sh' )

@task
def checkout_master(module=''):
  """Run git checkout master on each on the installed modules"""
  local( 'cd ' + main_dir + '; cd modules ; for m in $(ls ' + str(module) + '); do cd $m ; git checkout master ; cd ../ ; done' )

@task
def install_hooks(url=''):
  """Install Puppet .git/hooks"""
  local( main_dir + '/bin/git_install_hooks.sh ' + url )

