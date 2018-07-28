- [Docker integration](#docker-integration)
    - [Docker for testing](#docker-for-testing)
    - [Building Docker images](#building-docker-images)
        - [Using tp build (WIP)](#using-tp-build-wip)
        - [Using tp::rocker (WIP)](#using-tprocker-wip)
        - [Using image_clone (TODO)](#using-image_clone-todo)
    - [General maintenance](#general-maintenance)
        - [Docker status](#docker-status)
        - [Docker files cleanup](#docker-files-cleanup)
    - [Docker prerequisites](#docker-prerequisites)


## Docker integration

This `control-repo` provides various ways to use, configure and work with `Docker`.

They are available via `Fabric` or `shell commands`, we are going to show them both.

### Docker for testing

We can try to test a `Puppet run` for a `role` in a `Docker` container.

To run `Puppet` for the default ```docker_test_role``` on the default image (```centos-7```):

    fab docker.test_role
    # or
    bin/docker_test_role.sh

To test another `role` (define the profiles to use and the relevant data in ```hieradata/role/$role.yaml```

    fab docker.test_role:ansible
    # or
    bin/docker_test_role.sh ansible

It's also possible to select the underlying OS to use in the base image:

Available images are: `ubuntu-12.04`, `ubuntu-14.04`, `ubuntu-16.04`, `centos-7`, `debian-7`, `debian-8`, `alpine-3.3`.

    fab docker.test_role:myrole,debian-8
    # or
    bin/docker_test_role.sh myrole debian-8


**NOTE:** the base images used for the different OS are by default downloaded from [https://hub.docker.com/r/example42/puppet-agent/tags/](https://hub.docker.com/r/example42/puppet-agent/tags/).

It's possible to use custom ones by:

 - Setting on `Hiera` in the ```"role".yaml``` files the parameter ```docker::username``` (example42 by default)

 - Build custom (with ```fab docker.tp_build_role:puppet-agent```) ```puppet-agent``` images

 - Push them to our registry for use outside our local machine


### Building Docker images

In this `control-repo` various ways to use `Puppet` to build `Docker images` are explored.

They follow different approaches and have their own **limitations**. Work is progress (WIP) here.

#### Using tp build (WIP)

Dockerize a `role` entirely based on ```tp defines``` for one or multiple OS `Docker images`.

In this approach, `Puppet` is executed on our local machine, we might need `root privileges` to set file permissions.

    fab docker.tp_build_role

The above command uses the data in ```hieradata/role/docker_tp_build.yaml```


To specify a different role to build for:

    fab docker.tp_build_role:webserver
    # or
    bin/docker_tp_build_role.sh webserver


#### Using tp::rocker (WIP)

To build an image with [Rocker](https://github.com/rocker-org/rocker), without leaving traces of `Puppet` inside the image, we can run the following command.

Data used for the image is in ```hieradata/role/$puppetrole.yaml```

    docker.rocker_build_role

#### Using image_clone (TODO)



### General maintenance

A few other commands are available for general `Docker` maintenance.


#### Docker status

To show general `Docker` information (version, containers and images):

    fab docker.status
    # or
    bin/docker_status.sh

#### Docker files cleanup

To remove all local images and containers (**WARNING:** have no important data there).

By default a confirmation prompt appears:

    fab docker.purge
    # or
    bin/docker_purge.sh

To run in unattended mode (useful for cleanups in `CI pipelines`):

    fab docker.purge:auto
    # or
    bin/docker_purge.sh auto


### Docker prerequisites

`Docker` operations via `Fabric` or using the command line require `Docker` to be locally installed.

If we use `Mac` or `Windows` we need the newer native client.

To install `docker` we can run one of these commands:

    fab docker.setup
    # or
    bin/docker_setup.sh

You'll need to run ```docker login``` before trying any operation that involves pushing our images to `Docker registry`.
