#!/usr/bin/env bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"

source_dir=${1:-'modules/psick'}
target_file=${2:-'docs/classes.md'}
[ -f $target_file ] && rm -f $target_file

echo >> $target_file
echo "## List of psick classes" >> $target_file
echo >> $target_file
echo "This is an automatically generated list of the psick classes in this control-repo" >> $target_file
echo >> $target_file
for f in $(find $source_dir -name *.pp | grep manifests | grep -v fixtures); do
  a=$(grep ^class ${f} | sed 's/(//g' | sed 's/{//g' | sed 's/)//g' | sed 's/ *$//g' | sed 's/^class //g')
  b=$(grep @summary ${f} | sed 's/^# *@summary/ -/g') 
  echo "  - **${a}**${b}" >> $target_file
done
echo >> $target_file
