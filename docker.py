from fabric.api import *
import subprocess
main_dir = subprocess.check_output("git rev-parse --show-toplevel", shell=True).rstrip()

@task
def test_role(puppetrole='log', image='ubuntu-14.04'):
  """[local] Test a role on the specified OS on a Docker image"""
  local( 'cd ' + main_dir + '; docker/test.sh ' + str(puppetrole) + ' ' + str(image) )

@task
def build_role(puppetrole='docker_test', image='ubuntu1404'):
  """[local] WIP Dockerize a role on the specified image OS (data in hieradata/role/$puppetrole.yaml)"""
  local( 'cd ' + main_dir + '/docker ; ./dockerize_role.sh ' + str(puppetrole) + ' ' + str(image) )

@task
def build_role_multios(puppetrole):
  """[local] WIP Dockerize a role on multiple OS images (data in hieradata/role/$puppetrole.yaml)"""
  local( 'cd ' + main_dir + '/docker ; ./dockerize_role_all_os.sh ' + str(puppetrole) )

@task
def build_multios():
  """[local] Build multiple OS Docker images with TP (data in hieradata/role/docker_multios_build.yaml)"""
  local( 'cd ' + main_dir + '/docker ; ./generate_all.sh' )

@task
def purge_images():
  """[local] Remove ALL local docker images (CAUTION)"""
  local( 'docker rmi $(docker images -q)' )

@task
def purge_containers():
  """[local] Remove ALL local docker containers (CAUTION)"""
  local( 'docker rm $(docker ps -a -q)' )

