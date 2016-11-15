from fabric.api import *
env.use_ssh_config = True

import aws
import vagrant
import puppet
import facter
import git
import docker
import tp

