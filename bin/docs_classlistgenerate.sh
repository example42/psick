#!/usr/bin/env bash
repo_dir=$(git rev-parse --show-toplevel)
. "${repo_dir}/bin/functions"
target_file=${1:-'docs/classes.md'}
[ -f $target_file ] && rm -f $target_file

echo >> $target_file
echo "## List of profile classes" >> $target_file
echo >> $target_file
echo "This is an automatically generated list of the profile classes in this control-repo" >> $target_file
echo >> $target_file
for f in $(find site/profile/manifests/ -name *.pp); do
  a=$(grep ^class ${f} | sed 's/(//g' | sed 's/ $//g' | sed 's/^class //g')
  b=$(grep @summary ${f} | sed 's/^# *@summary/ -/g') 
  echo "  - **${a}**${b}" >> $target_file
done
echo >> $target_file
