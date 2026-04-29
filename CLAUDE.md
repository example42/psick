# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

PSICK (Puppet Systems Infrastructure Construction Kit) is a **Puppet control-repo** — the Git repository that a Puppet server deploys to manage infrastructure. It is not a standalone application; it is meant to be deployed to `/etc/puppetlabs/code/environments/<branch>/` on a Puppet server, where each git branch maps to a Puppet environment.

## Setup

Install prerequisite gems and populate `modules/` via r10k:

```bash
bin/puppet_setup.sh        # installs gems + runs r10k
# or if gems already installed:
r10k puppetfile install -v
```

For optional tools (Vagrant, Docker):

```bash
bin/setup.sh
```

## Testing Commands

### Syntax Checks

```bash
bin/puppet_check_syntax_fast.sh all_but_chars   # validate manifests, templates, ruby files
bin/puppet_check_syntax_fast.sh chars           # check for non-printable characters
bin/puppet_lint.sh                              # run puppet-lint
```

### Unit Tests (Rake / onceover)

```bash
bundle exec rake spec                           # run rspec unit tests for the control-repo
bin/puppet_check_rake.sh controlrepo           # same via helper script
bin/puppet_check_rake.sh site                  # rspec tests for modules in site/
bin/puppet_check_rake.sh site bundle           # with bundle install first
```

### onceover (catalog compilation tests)

onceover compiles catalogs for classes against factsets, without a live Puppet server:

```bash
bundle exec onceover run spec                   # run onceover spec tests
./run_onceover.sh run spec                      # same via podman container (puppet/puppet-dev-tools:4.x)
```

onceover config is in `spec/onceover.yaml`. Factsets (mock node facts) are in `spec/factsets/`.

### Docker Integration Tests

```bash
bin/docker_run.sh --image centos-7             # test Puppet apply inside a Docker container
```

### Vagrant Integration Tests

```bash
cd vagrant/environments/lab   # (or ostest, bare, foss, pe)
vagrant status
vagrant up <vm>
vagrant provision <vm>         # re-run Puppet apply on a running VM
```

## Architecture and Key Concepts

### Nodeless, Hiera-Driven Classification

`manifests/site.pp` includes only `include 'psick'`. The psick module drives all classification. Node roles are determined by **top-scope variables** set from trusted facts, external facts, or an ENC:

- `$role` — maps to a Puppet role (e.g., `webserver`, `dbserver`)
- `$env` — operational environment (e.g., `production`, `test`)
- `$zone` / `$datacenter` / `$application` — optional further grouping

These variables are used as keys in `hiera.yaml` to determine which Hiera data applies to a node.

### Hiera Hierarchy (`hiera.yaml`)

```
nodes/%{trusted.certname}.yaml        # per-node override (highest priority)
role/%{::role}-%{::env}.yaml          # role+environment combo
role/%{::role}.yaml                    # role-level data
zone/%{::zone}.yaml                    # zone/datacenter data
common.yaml                            # global defaults (lowest priority)
```

Data lives in `modules/hieradata/data/` (the `example42/hieradata` module, sourced from the `psick-hieradata` git repo, branch matching the control branch). Hiera uses the eyaml backend for encrypted secrets; keys are at `/etc/puppetlabs/puppet/keys/`.

`hiera_pabawi.yaml` is an alternate Hiera config that uses `facts.fact_role` instead of top-scope `$role` — for use with Pabawi/HDM (Hiera Data Manager) tools that resolve Hiera without catalog compilation.

### Module Path (`environment.conf`)

```
modulepath = site:modules:$basemodulepath
```

- `site/` — local profiles and custom modules (in this repo)
- `modules/` — external modules installed by r10k from `Puppetfile` (gitignored)
- `$basemodulepath` — Puppet's built-in modules

### Key External Modules (`Puppetfile`)

- `example42/psick` — provides node classification and base profiles
- `example42/psick_profile` — application-specific profiles
- `example42/tp` + `example42/tinydata` — Tiny Puppet (generic application management)
- `example42/hieradata` — Hiera data (sourced from psick-hieradata repo, branch-tracked)
- `trlinkin/noop` — enables noop mode via Hiera key `noop_mode: true`

### Noop Mode

Set `noop_mode: true` in Hiera data to put nodes into noop (dry-run) mode without touching agent configuration.

### Bolt (`bolt-project.yaml`)

Bolt tasks and plans can be run against nodes. The project is named `psick` with `hiera.yaml` used for Hiera data. Available tasks include `tp::test` and `psick::puppet_*`.

## CI/CD Pipelines

### GitLab CI (`.gitlab-ci.yml`)

Stages: `merge request → checks → unit → integration → canary → promote → production runs → documentation`

Key scripts used by CI:
- `bin/gitlab_before.sh <branch>` — setup (r10k deploy, etc.) before test stages
- `bin/puppet_check_syntax_fast.sh` — syntax stage
- `bin/puppet_check_rake.sh controlrepo` — unit stage
- `bin/docker_run.sh` — Docker integration stage
- `bin/puppet_ci.sh` — orchestrates PE/PuppetDB tasks (catalog preview, job runs)

### Jenkins (`Jenkinsfile`)

Stages: Setup → Syntax → Unit → Diff → Integration → Integration Rollout → Production Rollout

## Directory Reference

| Path | Purpose |
|------|---------|
| `manifests/site.pp` | Entry point; sets top-scope vars, includes psick |
| `hiera.yaml` | Hiera 5 environment config with eyaml backend |
| `hiera_pabawi.yaml` | Alternate Hiera config for HDM/Pabawi (uses facts instead of top-scope vars) |
| `Puppetfile` | External module definitions for r10k |
| `environment.conf` | Puppet environment settings (modulepath, manifest dir) |
| `site/` | Local profiles and custom Puppet modules |
| `modules/` | r10k-installed external modules (gitignored) |
| `spec/onceover.yaml` | onceover test matrix (classes × nodes) |
| `spec/factsets/` | Mock fact sets for onceover catalog tests |
| `vagrant/environments/` | Vagrant test environments (lab, ostest, bare, foss, pe) |
| `bin/` | Helper scripts for syntax checks, CI, Docker, Vagrant, r10k |
| `docs/` | Extended documentation |
| `bolt-project.yaml` | Bolt project config |
