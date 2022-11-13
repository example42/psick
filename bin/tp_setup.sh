#!/usr/bin/env bash
PATH=$PATH:/opt/puppetlabs/puppet/bin
puppet module install example42-tp
puppet tp setup
