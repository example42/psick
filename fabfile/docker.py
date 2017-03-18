from fabric.api import *
import subprocess
main_dir = subprocess.check_output("git rev-parse --show-toplevel", shell=True).rstrip()

env.warn_only = True


# Testing
@task
def test_role(puppetrole='docker_test_role', image='centos-7') :
  """[local] Test a role on the specified OS on a Docker image"""
  local( 'cd ' + main_dir + '/bin ; ./docker_test_role.sh ' + str(puppetrole) + ' ' + str(image) )

# Building
@task
def rocker_build_role(puppetrole='docker_rocker_build', image='ubuntu1404'):
  """[local] WIP Rockerize a role on all or the specified image OS (data in hieradata/role/$puppetrole.yaml)"""
  local( 'cd ' + main_dir + '/bin ; ./docker_rocker_build_role.sh ' + str(puppetrole) + ' ' + str(image) )

@task
def tp_build_role(puppetrole='docker_tp_build', image='centos7'):
  """[local] Dockerize a role based on tp on all or the specified Docker (data in hieradata/role/$puppetrole.yaml)"""
  local( 'cd ' + main_dir + '/bin ; ./docker_tp_build_role.sh ' + str(puppetrole) + ' ' + str(image) )


# Maintenance
@task
def setup():
  """[local] Install locally Docker (needs su privileges)"""
  local( main_dir + "/bin/docker_setup.sh" )

@task
def status():
  """[local] Show Docker status info"""
  local( 'cd ' + main_dir + '/bin ; ./docker_status.sh ' )

@task
def purge(mode=''):
  """[local] Clean up docker images and containers (CAUTION)"""
  local( 'cd ' + main_dir + '/bin ; ./docker_purge.sh ' + str(mode))

