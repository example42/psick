from fabric.api import *
import subprocess
main_dir = subprocess.check_output("git rev-parse --show-toplevel", shell=True).rstrip()

@task
def setup():
  """[local] Install locally Vagrant and the needed plugins"""
  local( main_dir + "/bin/vagrant_setup.sh" )


@task
def env_status(env=''):
  """[local] Run vagrant status on all or the specified environments"""
  if env != '':
    local( 'cd ' + main_dir + '/vagrant/environments/' + env + '; echo "Vagrant environment: ${v}" ; echo ; vagrant status ; cd - ; echo ')
  else:
    local( 'cd ' + main_dir + '/vagrant/environments ; for v in $(ls ' + str(env) + '); do cd $v ; echo "Vagrant environment: ${v}" ; echo ; vagrant status ; cd ../ ; echo ; done' )

@task
def status(vm='', env=''):
  """[local] Show status of all or the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh status ' + str(vm) + ' ' + str(env) )

@task
def node_test(vm='', env=''):
  """[local] Run existing and testing Puppet code on a VM"""
  local( main_dir + 'bin/vagrant_node_test.sh ' + str(vm) + ' ' + str(env) )

@task
def suspend(vm='', env=''):
  """[local] Suspend all or the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh suspend ' + str(vm) + ' ' + str(env) )

@task
def resume(vm='', env=''):
  """[local] Resume all or the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh resume ' + str(vm) + ' ' + str(env) )

@task
def destroy(vm, env=''):
  """[local] Destroy the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh destroy ' + str(vm) + ' ' + str(env) )

@task
def reload(vm='', env=''):
  """[local] Reload all or the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh reload ' + str(vm) + ' ' + str(env) )

@task
def provision(vm='', env=''):
  """[local] Provision all or the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh provision ' + str(vm) + ' ' + str(env) )
  #result = local( main_dir + '/vagrant/bin/vm.sh provision ' + str(vm) + ' ' + str(env) )
  #if result != '0'
  #  abort( "Failed test - Aborting")

@task
def up(vm, env=''):
  """[local] Vagrant up the specified vm"""
  local( main_dir + '/vagrant/bin/vm.sh up ' + str(vm) + ' ' + str(env) )

@task
def halt(vm='',env=''):
  """[local] Halt all or the specified Vagrant vm"""
  local( main_dir + '/vagrant/bin/vm.sh halt ' + str(vm) + ' ' + str(env) )

