#!/bin/bash
# get_metadata.sh - Made for Puppi

# Sources common header for Puppi scripts
. $(dirname $0)/header || exit 10

# Show help
showhelp () {
    echo "This script retrieves some metadata from the downwloaded files "
    echo "The metadatasource is automatically detected from the \$metadatasource runtime config"
    echo
    echo "It has some, not required, options:"
    echo "-m <magicstring> - The string to use as prefix in custom metadata info provided "
}

while [ $# -gt 0 ]; do
  case "$1" in
    -m)
      suffix=$2
      shift 2 ;;
    -h)
      showhelp ;;
  esac
done


case $metadatasource in
    list)
    if [ -z $suffix ] ; then
        suffix="####"
    fi
    # TODO Make this more secure, for God's sake!
    for param in $(cat $downloadedfile | grep "^$suffix" ) ; do
        save_runtime_config $param
    done
    ;;
    tarball)
    ;;
    maven)
    version=$(xml_parse release $downloadedfile )
    artifact=$(xml_parse artifactId $downloadedfile )
    warfile=$artifact-$version.war
    if [ $suffix ] ; then
        srcfile=$artifact-$version-src-$suffix.tar
        configfile=$artifact-$version-cfg-$suffix.tar
    else
        srcfile=$artifact-$version-src.tar
        configfile=$artifact-$version-cfg.tar
    fi

    # Store metadata
    save_runtime_config "version=$version"
    save_runtime_config "artifact=$artifact"
    # Store filenames
    save_runtime_config "warfile=$warfile"
    save_runtime_config "srcfile=$srcfile" 
    save_runtime_config "configfile=$configfile" 
    ;;
esac

