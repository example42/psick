#!/bin/bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

echo_title "Going to install awscli and dependencies"
puppet resource package awscli provider=pip ensure=present
puppet resource package aws-sdk-core provider=gem ensure=present
puppet resource package retries provider=gem ensure=present

echo_title "Running aws configure"
aws configure

