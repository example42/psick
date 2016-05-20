from fabric.api import *

@task
def all_status(env=''):
  """Run vagrant status on all the available environments"""
  local( 'cd vagrant/environments ; for v in $(ls ' + str(env) + '); do cd $v ; echo "Vagrant environment: ${v}" ; echo ; vagrant status ; cd ../ ; echo ; done' )

@task
def status(vm=''):
  """Show status of the specified vm"""
  local( 'vagrant/bin/vm.sh status ' + str(vm) )

@task
def suspend(vm):
  """Suspend the specified vm"""
  local( 'vagrant/bin/vm.sh suspend ' + str(vm) )

@task
def resume(vm):
  """Resume the specified vm"""
  local( 'vagrant/bin/vm.sh resume ' + str(vm) )

@task
def destroy(vm):
  """Destroy the specified vm"""
  local( 'vagrant/bin/vm.sh destroy ' + str(vm) )

@task
def reload(vm):
  """Reload the specified vm"""
  local( 'vagrant/bin/vm.sh reload ' + str(vm) )

@task
def provision(vm):
  """Run vagrant provision on the specified vm"""
  local( 'vagrant/bin/vm.sh provision ' + str(vm) )

@task
def up(vm):
  """Vagrant up the specified vm"""
  local( 'vagrant/bin/vm.sh up ' + str(vm) )

@task
def halt(vm):
  """Halts the the specified Vagrant vm"""
  local( 'vagrant/bin/vm.sh halt' + str(vm) )

