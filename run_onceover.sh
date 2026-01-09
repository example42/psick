#!/bin/bash
podman run --rm -v $(pwd):/repo --userns=keep-id puppet/puppet-dev-tools:4.x onceover "$@"
