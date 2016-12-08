#!/usr/bin/env bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"

node='git.lan'

PUPPET=$(which puppet)
ERB=$(which erb)
RUBY=$(which ruby)
global_exit=0

octocatalog-diff -n $node
exit $global_exit
