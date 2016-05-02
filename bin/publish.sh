#!/bin/bash
work_dir=/tmp/puppet-publish
echo_title () {
  echo
  echo
  echo "###########################################"
  echo "$1"
  echo
}

showhelp () {
cat << EOF

This script tags and publishes a module:
- On the Puppet forge, with Maestrodev's Puppet Blacksmith https://github.com/maestrodev/puppet-blacksmith
- On GitHub using local credentials

Usage:
$0 [OPTIONS]

Available OPTIONS
[-m module_name] - Name of the module to publish. Must be in pwd
[-f|--force] [-nf|--no-force]        Default: disabled - Enable/Disable forcing of the publising even with test errors
[-b|--bump] [-nb|--no-bump]                            - Enable/Disable bumping of the module version
[-t|--tag] [-nt|--no-tag]                              - Enable/Disable tagging of the module
[-fx|--fix] [-nofx|--no-fix]                           - Enable/Disable removal of optional dependencies for the Forge version
[-c|--check] [-nc|--no-check]                          - Enable/Disable module testing before any operation
[-s|--sync-master] [-ns|--no-sync-master]              - Enable/Disable merging of version branch on master
[-u|--update-collection] [-nu|--no-update-collection]  - Enable/Disable automatic update of gitsubmodule on the containing modules collection

EOF
}

force=false
bump=true
tag=true
fix=true
check=true
forge=true
github=true
syncmaster=true
updatecollection=true

while [ $# -gt 0 ]; do
  case "$1" in
    -m)
      module=$2
      shift 2 ;;
    -f|--force)
      force=true
      shift ;;
    -nf|--no-force)
      force=false
      shift ;;
    -b|--bump)
      bump=true
      shift ;;
    -nb|--no-bump)
      bump=false
      shift ;;
    -t|--tag)
      tag=true
      shift ;;
    -nt|--no-tag)
      tag=false
      shift ;;
    -fx|--fix)
      fix=true
      shift ;;
    -nfx|--no-fix)
      fix=false
      shift ;;
    -c|--check)
      check=true
      shift ;;
    -nc|--no-check)
      check=false
      shift ;;
    -s|--sync-master)
      syncmaster=true
      shift ;;
    -ns|--no-sync-master)
      syncmaster=false
      shift ;;
    -u|--update-collection)
      updatecollection=true
      shift ;;
    -nu|--no-update-collection)
      updatecollection=false
      shift ;;
  esac
done

if [ $module ] ; then
  cd $module
fi

modulename=$(basename `pwd`)
branch=$(git branch --no-column | grep '*' | cut -c 3-)

if [ ! -f manifests/init.pp ] ; then
  echo_title "SOMETHING WRONG"
  echo "I don't find manifests/init.pp "
  echo "Run this script from a module directory or specify -m modulename"
  showhelp
  exit 1
fi

if [ $check == 'true' ] ; then
  pwd
  rake -f ../../bin/Rakefile_blacksmith module:clean
  rake spec_clean

  echo_title "LINT TESTS"
  rake lint
  echo_title "SPEC TESTS"
  rake spec
fi

if [ $force != 'true' ] ; then
  echo_title "PROCEED? "
  read -p "Do you want to continue with tagging and publishing? (Y/n) " answer
  answer=${answer:-y}
  if [ $answer != 'y' ] ; then
    echo "OK, try later!"
    exit 1
  fi
fi

if [ $bump == 'true' ] ; then
  echo_title "VERSION BUMP"
  rake -f ../../bin/Rakefile_blacksmith module:bump || exit 1
fi

if [ $tag == 'true' ] ; then
  version=$(git describe --abbrev=0 --tags)
  echo_title "MODULE TAG ${version}"
  rake -f ../../bin/Rakefile_blacksmith module:tag || exit 1
  git commit -a -m "Release $version"
fi

if [ $forge == 'true' ] ; then
  echo_title "PUBLISH TO THE FORGE"

  rake -f ../../bin/Rakefile_blacksmith module:push || exit 1

fi

if [ $github == 'true' ] ; then
  echo_title "PUBLISH TO GITHUB"
  git push origin $branch
  git push origin $branch --tags
fi

if [ $syncmaster == 'true' ] ; then
  if [ "x$branch" != "xmaster" ] ; then
    echo_title "MERGING $branch to master"
    read -p "Do you want to merge $branch on master? (Y/n) " answer
    answer=${answer:-y}
    if [ $answer != 'y' ] ; then
      git checkout master
      git merge $branch master
      read -p "Do you want to merge $branch on master? (Y/n) " answer
      answer=${answer:-y}
      if [ $answer != 'y' ] ; then
        git push origin master
      fi
    fi
  fi
fi
