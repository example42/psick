## Puppet change process

Delivery of `Puppet code` and `data`, from `Puppet Server` and users to production can be done in several different ways.

They ultimately depend on each site policies and procedures, but it's still possible to summarise the needed steps and procedures.

From `Puppet` developer workstation to real `puppet run` on managed nodes we can identify at least these steps, more or less mandatory, applicable, desired or needed:

  - [DevStation] Work on `control-repo:` data, local site profile or managed external modules.
  - [DevStation] [GitServer] [WebGUI] Manage `Puppet` [hiera] data
  - [DevStation] Interactive development and tests on local VMs.
  - [DevStation] [CI] Syntax checks
  - [DevStation] [CI] Run `unit` and `integration tests`.
  - [CI] [WebGUI] Trigger `Puppet runs` on selected nodes
  - [CIGUI] [GitServer] Review `CI` tests
  - [GitServer] Discuss and review code changes requests
  - [WebGUI] Check `Puppet infrastructure` status and reports
  - [CI] [GitServer] [WebGUI] Manage code promotion to `production` `environment/branch`
  - [CI] [WebGUI] [GitServer] Manage `control-repo` deployment on `Puppet Servers`

[TODO] Complete
