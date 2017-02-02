# Puppet Enterprise and Gitlab integration

Deep and powerful integrations are possible in this control-repo between Puppet (Enterprise) and GitLab.

Here we review what is done in this control-repo and the manual steps for a fully PE-GitLab integrated environment:

  - Puppet Code Manager integration between GitLab and PE
  - Puppet profiles to configure gitlab and gitlab runners
  - Gitlab CI integration with Puppet controlled via the ```.gitlab-ci.yml``` file.
  - PE based Vagrant environment where to test the full integration

## Puppet Code Manager deployments automation

It's possible to configure PE's Code Manager to automatically deploy code on the Puppet server when any change occurs in a control-repo hosted on GitLab.


### Configure Code Manager

To configure Code Manager integration with GitLab follow [official documentation](https://docs.puppet.com/pe/latest/code_mgr_config.html).

In short, set these keys via Hiera or manually on the PE console on the Puppet Master of Masters node (or the Puppet Master in a AIO setup):

    # Url of the control repo hosted on the internal GitLab server
    puppet_enterprise::profile::master::r10k_remote: git@git.lan:puppet/control-repo.git'

    # Path of a ssh private key able to access the repo. File should be owned by pe-puppet user.
    puppet_enterprise::profile::master::r10k_private_key: '/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa'

    # Enable Code Manager auto deployment
    puppet_enterprise::profile::master::code_manager_auto_configure: true

[Manual] steps needed:

  - Create a new repo for your control-repo on GitLab
  - Create a user for deployments on GitLab (ie: deployer), be sure it can access (at least in read only) your control-repo
  - Create a ssh key pair on the Puppet Server (```ssh-keygen```) and copy the private key under ```/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa``` and be sure ```pe-puppet``` user can read it
  - On GitLab add the relevant public key to the deployer user.
  - On PE Console create a user and assign it to the Code Deployers role (see below for details)
  - On the Puppet Server request an authentication token (see below for details) to use for deployments
  - On GitLab add the created PE token to your project's Webhooks.

The class ```profile::puppet::pe_code_manager``` automates some of the above steps.

### Create a deploy user on PE console

User creation on PE console:

  - Click: Access Control -> Users -> Add local user (Specify Full Name and login)
  - Click: User -> Edit user -> Generate Password reset
  - Copy the link for password reset and open it with a browser to the the user password.
  - To assign a new role to the user click User Roles -> Selected role -> Add user (Select from menu the User name)

Check [here](https://docs.puppet.com/pe/latest/rbac_user_roles.html) for more details on PE user roles.

For Code Manager is enough to assign the created user to the Code Deployers role.

### Request an authentication token

PE allows the usage of tokens to manage access to its APIs. Check [Token Based Authentication(https://docs.puppet.com/pe/latest/rbac_token_auth.html) for more details.
 
To create a token of a local system user we can use the ```puppet-access``` command. 

It's configuration file is in ```/etc/puppetlabs/client-tools/puppet-access.conf``` a sample command to request an authentication token (which lasts 5 years) is:

    puppet-access login --lifetime 5h

You are asked to introduce a login and a password, use the credentials of the PE user for which you want to create the token (which will have the access privileges of the username used in puppet-access).

Token is stored in ```~/.puppetlabs/token```, to view activities done using the Token, in the PE console, click Access control > Users > Selected user > Details > Activity tab.

To manage tokens default lifetime, on the PE console node (note: the default value is just 5 minutes):

  puppet_enterprise::profile::console::rbac_token_auth_lifetime: 10y

Note: The control repo provides the define ```tools::puppet::access``` to automate Token requests (you need to provide PE username and password).

Tokens used for Code Deployment have to be added in GitLab's project [webhooks](https://docs.puppet.com/pe/latest/code_mgr_webhook.html).


## Puppet profiles for GitLab components

The control repo provides some class and defines to work with GitLab:

  - ```profile::gitlab``` installs GitLab and eventually creates projects, groups and users (WIP)
  - ```profile::gitlab::runner``` installs a GitLab runner (one or more instances)
  - ```profile::gitlab::proxy``` configures Nginx to act as a reverse proxy of a remote GitLab server
  - ```profile::gitlab::cli``` installs GitLab cli and configures its access credentials via a custom ```/etc/gitlab-cli.conf``` file.
  - ```ptofile::gitlab::ci``` creates the ```/etc/gitlab-ci.conf``` used by some scripts in the CI pipeline
  - ```tools::gitlab::runner``` define used to create a GitLab runner instance
  - ```tools::gitlab::user``` define used to create a GitLab user
  - ```tools::gitlab::group``` define used to create a GitLab group
  - ```tools::gitlab::project``` define used to create a GitLab project

## Puppet CI integration on Gitlab


### GitLab Merge Resquests and approvals

In the pipelines you may use the commands ```bin/gitlab_create_merge_request.rb``` and ```bin/gitlab_accept_merge_request.rb``` to automate the remote managements of GitLAB Merge Requests.

These scripts use the ```/etc/gitlab-cli.conf``` file generated by the ```profile::gitlab::cli``` class.

You configure it with something like:

    profile::gitlab::cli::private_token: '9C2xPzg9V22Ha3TdsQpx'  # This changes at every GitLab installationn
    profile::gitlab::cli::api_endpoint: 'https://git.lan/api/v3' # Use the url of your GitLab server
    profile::gitlab::cli::project_id: 3 # ID of the control-repo repo on your GitLab (TODO: be able to specify just the project name)

The GitLab private token is the one from a user that has, on GitLab, the permissions for the requested activities (such as MR management). Create a user with such privileges and then retrive it's Private token from:
User Settings [Settings in the top right user icon] -> Account -> Private Token

## PE/Gitlab demo Vagrant environment





## Catalog preview
[PE cLient tools](https://docs.puppet.com/pe/latest/install_pe_client_tools.html)
pe-client-tools package

[Token based authentication](https://docs.puppet.com/pe/latest/rbac_token_auth.html)

## Orchestrator

[Orchestrator](https://docs.puppet.com/pe/latest/orchestrator_intro.html)

Configural file ```/etc/puppetlabs/client-tools/orchestrator.conf```


[Direct Puppet workflow](https://docs.puppet.com/pe/latest/direct_puppet_workflow.html)
