- [Working with AWS](#working-with-aws)
- [Installation of AWS environment on local node](#installation-of-aws-environment-on-local-node)
- [Manual steps](#manual-steps)
- [Installation of Puppet on a remote node](#installation-of-puppet-on-a-remote-node)
    - [Procedure for a single node](#procedure-for-a-single-node)

## Working with AWS

This `control-repo` has some resources and tools to work with `AWS`.

In order to have everything in place for working with `AWS` you need:

  - An account on [AWS](https://aws.amazon.com)
  - Generate a `user` under IAM and create an `ACCESS_KEY_ID` and its `SECRET_ACCESS_KEY`
  - Installed, on the `node` you want to work with `AWS`, all the necessary tools

## Installation of AWS environment on local node

Install locally this `control-repo` and all its dependencies:

    fab puppet.setup

If you want to manage `AWS resources` from your local computer, install the necessary packages:

    bin/aws_setup.sh
    # or
    fab aws.setup

Alternatively you can use the VM ```dev-local-aws-01``` under ```vagrant/environments/puppetinfra``` which is preconfigured to use the `aws role`:

    fab vagrant.up:dev-local-aws-01
    fab vagrant.provision:dev-local-aws-01

**NOTE:** Be very careful when *"playing"* with `AWS`. Always try in `noop mode` if you are not sure of what may happen. Remember that most of what is done in the `aws role` is managed in ```hieradata/role/aws.yaml```.


## Manual steps

For the complete initial setup of an `AWS` environment, some operations must be done manually via the `AWS console`:

  - Creation of a keypair to use for `SSH` on a newly provisioned machine. The name of this keypair, as written on `AWS console`, must be configured in ```hieradata/role/aws.yaml``` in a similar way:

          psick::aws::puppet::ec2::default_key_name: 'puppet'

  - Acceptance of the `Marketplace user agreement` via the `AWS console` (just create a disposable instance on the `Console`, using an image from the `Marketplace` (i.e. the official ```Centos 7``` one).


## Installation of Puppet on a remote node

To install `Puppet` on the specified `<node>`. It might be necessary to specify the `breed` (TODO: Automate OS detection)

    fab -H <node> puppet.install:[os_breed]

Example for ```Centos7``` servers:

    fab -H <node> puppet.install:redhat7

To setup the correct `Puppet environment`, in order to be able to run `puppet` both in agent and apply mode:

    fab -H <node> puppet.remote_setup

The above command will ask for confirmation, to skip it:

    fab -H <node> puppet.remote_setup:unattended

If you want to set `role` and `env` as external facts you can run a command like the following (**BEWARE:** changing these facts after `Puppet` has already run may radically change the configurations of a `node`).

    fab -H <node> puppet.set_facts:<role>,env=<env>

To run ```puppet apply``` on the specified node using your local development `control-repo`. This copies via ```rsync``` the local `control-repo` files to the home directory of the connecting user and runs ```sudo puppet apply``` on the local code. A ```role``` can be specified, it will be set as fact.

    fab -H <node> puppet.sync_and_apply

To specify a `role` (not needed if ```puppet.set_facts``` has been previously executed):

    fab -H <node> puppet.sync_and_apply:bastion

To specify a `role` AND force an `hostname` (**Important:** This actually changes the `hostname` of the machine and the relevant `Puppet data:`

    fab -H <node> puppet.sync_and_apply:mongo,fqdn=mongo-03.test.fd

### Procedure for a single node

For a `node` to be called ```mon-01.mgmt.fd``` with `mon role` this, therefore, the list of commands to run is as follows. We assume you are connected to the `VPN` and have the correct configurations in your ```.ssh/config``` with something like:

    Host prod-mon
        IdentityFile ~/.ssh/id_rsa.pem
        Hostname 10.10.11.35
        User centos

First time setup:

    fab -H prod-mon puppet.install:redhat7
    fab -H prod-mon puppet.remote_setup:unattended
    fab -H prod-mon puppet.set_facts:mon,env=prod

Then you can run `Puppet` on the `node` with:

    fab -H fd-prod-mon puppet.sync_and_apply

To run ```sync_and_apply``` in `noop mode`:

    fab -H fd-prod-mon puppet.sync_and_apply:options='--noop'
