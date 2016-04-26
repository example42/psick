#!/bin/bash
options=$*

echo "## Running puppet agent ${options}"
puppet agent -t ${options}
true
