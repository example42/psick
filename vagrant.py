from fabric.api import *

@task
def status(env=''):
  """Run vagrant status on all the available environments"""
  local( 'cd vagrant/environments ; for v in $(ls ' + str(env) + '); do cd $v ; echo $v ; vagrant status ; cd ../ ; echo ; done' )

@task
def provision(env='',vm=''):
  """Run vagrant provision on all the VMs or the specified one"""
  local( 'cd vagrant/environments ; for v in $(ls ' + str(env) + '); do cd $v ; echo $v ; vagrant provision ' + str(vm) + '; cd ../ ; echo ; done' )

@task
def up(env='',vm=''):
  """Run vagrant up on all the VMs (CAUTION!) or the specified one"""
  local( 'cd vagrant/environments ; for v in $(ls ' + str(env) + '); do cd $v ; echo $v ; vagrant up ' + str(vm) + '; cd ../ ; echo ; done' )


