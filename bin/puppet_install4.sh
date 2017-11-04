#!/usr/bin/env bash
breed=$1

which tput >/dev/null 2>&1
if [ "x${?}" == "x0" ]; then
  SETCOLOR_NORMAL=$(tput sgr0)
  SETCOLOR_TITLE=$(tput setaf 6)
  SETCOLOR_BOLD=$(tput setaf 15)
else
  SETCOLOR_NORMAL=""
  SETCOLOR_TITLE=""
  SETCOLOR_BOLD=""
fi
echo_title () {
  echo
  echo "${SETCOLOR_BOLD}###${SETCOLOR_NORMAL} ${SETCOLOR_TITLE}${1}${SETCOLOR_NORMAL} ${SETCOLOR_BOLD}###${SETCOLOR_NORMAL}"
}

# Skip if recent Puppet already installed
if [ $(which puppet) ]; then
  puppet --version | grep "^[4|5]"
  if [ "x$?" == "x0" ]; then
    echo_title "Puppet version 4 or higher present. Skipping installation."
    exit 0
  fi
fi

setup_redhat() {
  echo_title "Uninstalling existing Puppet"
  yum erase -y puppet puppetlabs-release >/dev/null

  echo_title "Adding repo for Puppet 4"
  rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-$1.noarch.rpm

  sleep 2
  echo_title "Installing Puppet"
  yum install -y puppet-agent >/dev/null
}

setup_fedora() {
  echo_title "Uninstalling existing Puppet"
  yum erase -y puppet puppetlabs-release

  echo_title "Adding repo for Puppet 4"
  rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-fedora-$1.noarch.rpm

  sleep 2
  echo_title "Installing Puppet"
  yum install -y puppet-agent
}

setup_suse() {
  echo_title "Uninstalling existing Puppet"
  zypper remove -y puppet >/dev/null 2>&1
  zypper remove -y puppetlabs-release >/dev/null 2>&1

  echo_title "Adding repo for Puppet 4"
  wget https://yum.puppetlabs.com/puppetlabs-release-pc1-sles-$1.noarch.rpm 2>&1
  rpm -ivh puppetlabs-release-pc1-sles-$1.noarch.rpm 2>&1

  sleep 2
  echo_title "Installing Puppet"
  zypper --no-gpg-checks  --non-interactive install puppet-agent
}

setup_apt() {
  case $1 in
    3*) codename=cumulus ;;
    6) codename=squeeze ;;
    7) codename=wheezy ;;
    8) codename=jessie  ;;
    9) codename=stretch  ;;
    12.04) codename=precise ;;
    14.04) codename=trusty  ;;
    16.04) codename=xenial ;;
    *) echo "Release not supported" ;;
  esac

  echo_title "Adding repo for Puppet 4"
  wget -q "http://apt.puppetlabs.com/puppetlabs-release-pc1-${codename}.deb" >/dev/null
  dpkg -i "puppetlabs-release-pc1-${codename}.deb" >/dev/null

  echo_title "Running apt-get update"
  apt-get update >/dev/null 2>&1

  echo_title "Installing Puppet and its dependencies"
  apt-get install -y puppet-agent -y >/dev/null
  apt-get install -y apt-transport-https -y >/dev/null
}
setup_alpine() {
  echo "## Adding repo for Puppet 4 to /etc/apk/repositories"
  echo http://dl-4.alpinelinux.org/alpine/edge/testing/ >> /etc/apk/repositories
  echo "## Running apk update"
  apk update

  echo "## Installing Puppet and its dependencies"
  apk add shadow ruby less bash
  gem install puppet --no-rdoc -no-ri
}
setup_solaris() {
  echo_title "Not yet supported"
}
setup_darwin() {
  majver=$(sw_vers -productVersion | cut -d '.' -f 1-2)
  echo_title "Downloading package for version ${majver}"
  curl -s -o puppet-agent.dmg "https://downloads.puppetlabs.com/mac/${majver}/PC1/x86_64/puppet-agent-1.8.2-1.osx${majver}.dmg"

  echo_title "Installing Puppet Agent"
  hdiutil mount puppet-agent.dmg
  package=$(find /Volumes/puppet-agent*  | grep pkg)
  installer -pkg $package -target /
  hdiutil unmount /Volumes/puppet-agent*
}
setup_bsd() {
  echo_title "Not yet supported"
}
setup_windows() {
  curl -s -o puppet-agent.msi "https://downloads.puppetlabs.com/windows/puppet-agent-x64-latest.msi"
  msiexec /qn /norestart /i puppet-agent.msi
  # msiexec /qn /norestart /i puppet-agent.msi PUPPET_AGENT_CERTNAME=me.example.com PUPPET_MASTER_SERVER=puppet.example.com \
}
setup_linux() {
  ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
  if [ -f /etc/redhat-release ]; then
      OS=$(cat /etc/redhat-release | cut -d ' ' -f 1-2 | tr -d '[:space:]')
      if [ "$OS" == "CentOSLinux" ] || [ "$OS" == "CentOSrelease" ] ; then
        OS="CentOS"
      fi
      majver=$(cat /etc/redhat-release | sed 's/[^0-9\.]*//g' | sed 's/ //g' | cut -d '.' -f 1)
  elif [ -f /etc/SuSE-release ]; then
      OS=sles
      majver=$(cat /etc/SuSE-release | grep VERSION | cut -d '=' -f 2 | tr -d '[:space:]')
  elif [ -f /etc/alpine-release ]; then
      OS=alpine
      majver=$(cat /etc/alpine-release | cut -d '.' -f 1)
  elif [ -f /etc/os-release ]; then
      . /etc/os-release
      OS=$ID
      majver=$VERSION_ID
  elif [ -f /etc/debian_version ]; then
      OS=Debian
      majver=$(cat /etc/debian_version | cut -d '.' -f 1)
  elif [ -f /etc/lsb-release ]; then
      . /etc/lsb-release
      OS=$DISTRIB_ID
      majver=$DISTRIB_RELEASE
  elif [ -f /etc/os-release ]; then
      . /etc/os-release
      OS=$ID
      majver=$VERSION_ID
  else
      OS=$(uname -s)
      majver=$(uname -r)
  fi
  distro=$(echo $OS | tr '[:upper:]' '[:lower:]')
  echo_title "Detected Linux distro: ${distro} version ${majver} on arch ${ARCH}"
  case "$distro" in
    debian) setup_apt $majver ;;
    ubuntu) setup_apt $majver ;;
    redhat) setup_redhat $majver ;;
    fedora) setup_fedora $majver ;;
    centos) setup_redhat $majver ;;
    scientific) setup_redhat $majver ;;
    amazon) setup_redhat $majver ;;
    sles) setup_suse $majver ;;
    cumulus-linux) setup_apt $majver ;;
    alpine) setup_alpine $majver ;;
    *) echo "Not supported distro: $distro" ;;
  esac
}

os_detect() {
  case "$OSTYPE" in
    solaris*) setup_solaris ;;
    darwin*)  setup_darwin ;;
    linux*)   setup_linux ;;
    bsd*)     setup_bsd ;;
    cygwin*)  setup_windows ;;
    msys*)    setup_windows ;;
    win*)     setup_windows ;;
    *)        setup_linux ;; # For alpine
  esac
}

if [ "x$breed" != "x" ]; then
  setup_$breed
else
  os_detect
fi
[ -e /usr/bin/puppet ] || ln -fs /opt/puppetlabs/puppet/bin/puppet /usr/bin/puppet
[ -e /usr/bin/facter ] || ln -fs /opt/puppetlabs/puppet/bin/facter /usr/bin/facter

