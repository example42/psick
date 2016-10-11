# example42 control-repo Docker integration

The control repo provides various ways to use, configure and work with Docker.

They are available via fanric commands.

To build the images for testing this control-repo on Docker using different OS.
Note: image building is based on the data in ```hieradata/role/docker_multios_build.yaml``` edit ```docker::profile::builder``` keys to customise what you want to build:

    fab docker.multios_build

Test a specific role on specific OS Docker images via Puppet.
Available images are: (ubuntu-12.04, ubuntu-14.04, ubuntu-14.06, centos-7, debian-7, debian-8, alpine-3.3).
Note that by default they are downloaded from [https://hub.docker.com/r/example42/puppet-agent/tags/](https://hub.docker.com/r/example42/puppet-agent/tags/).
If you change the parameter ```docker::username``` (Here is example42 by default) you will have first to build (with ```fab docker.multios_build```) puppet-agent images and, eventually, push them to the registry.

    fab docker.provision:log,ubuntu-14.04
    fab docker.provision:puppetrole=log,image=ubuntu-14.04 # This has the same effect

### Docker prerequisites

Docker operations via Fabric or using the command line require Docker to be locally installed.

If you use Mac or Windows you need the newer native client, things won't work when using Docker running inside a Virtualbox VM.

You'll need to run ```docker login``` before trying any operation that involves pushing your images to Docker registry.


 
