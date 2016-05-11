from fabric.api import *

@task
def provision(puppetrole='log', image='ubuntu-14.04'):
  """Test a role on the specified OS on Docker"""
  local('docker/test.sh ' + str(puppetrole) + ' ' + str(image) )

@task
def multios_build():
  """Build Docker images based on the data in hieradata/role/docker_multios_build.yaml"""
  local( 'cd docker ; ./generate_all.sh' )

@task
def purge_images():
  """Remove ALL local docker images (CAUTION)"""
  local('docker rmi $(docker images -q)')

@task
def purge_containers():
  """Remove ALL local docker containers (CAUTION)"""
  local('docker rm $(docker ps -a -q)')

