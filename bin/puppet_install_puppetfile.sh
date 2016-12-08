#!/bin/bash
repo_dir="$(dirname $0)/.."
. "${repo_dir}/bin/functions"
if [ $1 ]; then
  ln -s "${repo_dir}/Puppetfile_${1}" "${repo_dir}/Puppetfile"
fi
if [ $PUPPETFILE_ENV ]; then
  ln -s "${repo_dir}/Puppetfile_${PUPPETFILE_ENV}" "${repo_dir}/Puppetfile"
fi
if [ ! -f "${repo_dir}/Puppetfile" ]; then
  ln -s "${repo_dir}/Puppetfile_public" "${repo_dir}/Puppetfile"
fi
r10k puppetfile install 
