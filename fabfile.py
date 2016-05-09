from fabric.api import *

def git_check_status():
  local( 'bin/check_gitstatus.sh' )

def git_checkout_master():
  local( 'cd modules ; for m in $(ls); do cd $m ; git checkout master ; cd ../ ; done' )

def vagrant_statuses():
  local( 'cd vagrant/environments ; for v in $(ls); do cd $v ; vagrant status ; cd ../ ; done' )

def vagrant_provision():
  local( 'cd vagrant/environments ; for v in $(ls); do cd $v ; vagrant provision ; cd ../ ; done' )

def docker_buildall():
  local( 'cd docker ; ./generate_all.sh' )

# TODO: Parametrise 
def docker_provision(role='log', image='ubuntu-14.04'):
  local('docker/test.sh ' + str(role) + ' ' + str(image) )

def docker_purge_images():
  local('docker rmi $(docker images -q)')

def docker_purge_containers():
  local('docker rm $(docker ps -a -q)')

def puppet_apply():
  sudo( '$(puppet config print lastrunfile)/environtments/production/bin/papply.sh ; echo $?' )

@parallel(pool_size=4)
def puppet_agent():
  sudo( 'puppet agent -t ; echo $?' )

@parallel(pool_size=4)
def puppet_agent_noop():
  sudo( 'puppet agent -t --noop ; echo $?' )

@parallel(pool_size=4)
def puppet_current_config():
  sudo( 'cat $(puppet config print lastrunfile) | grep "config: " | cut -d ":" -f 2- ' )

