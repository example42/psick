from fabric.api import *

@task
def check_status():
  """Check git status on this repo and the installed modules"""
  local( 'bin/check_gitstatus.sh' )

@task
def checkout_master(module=''):
  """Run git checkout master on each on the installed modules"""
  local( 'cd modules ; for m in $(ls ' + str(module) + '); do cd $m ; git checkout master ; cd ../ ; done' )

