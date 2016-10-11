from fabric.api import *
import subprocess
main_dir = subprocess.check_output("git rev-parse --show-toplevel", shell=True).rstrip()

@task
def env_status(env=''):
  """Run vagrant status on all or the specified environments"""
  if env != '':
    local( 'cd ' + main_dir + '/vagrant/environments/' + env + '; echo "Vagrant environment: ${v}" ; echo ; vagrant status ; cd - ; echo ')
  else:
    local( 'cd ' + main_dir + '/vagrant/environments ; for v in $(ls ' + str(env) + '); do cd $v ; echo "Vagrant environment: ${v}" ; echo ; vagrant status ; cd ../ ; echo ; done' )

@task

def status(vm=''):
  """Show status of all or the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh status ' + str(vm) )

@task
def suspend(vm=''):
  """Suspend all or the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh suspend ' + str(vm) )

@task
def resume(vm=''):
  """Resume all or the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh resume ' + str(vm) )

@task
def destroy(vm):
  """Destroy the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh destroy ' + str(vm) )

@task
def reload(vm=''):
  """Reload all or the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh reload ' + str(vm) )

@task
def provision(env='', vm=''):
  """Provision all or the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh provision ' + str(vm) )

@task
def up(vm):
  """Vagrant up the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh up ' + str(vm) )

@task
def halt(vm=''):
  """Halt all or the specified Vagrant vm"""
  local( main_dir + '/vagrant/bin/vm.sh halt ' + str(vm) )

