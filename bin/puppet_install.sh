#!/usr/bin/env bash
breed=$2

if [ -z "$1" ]; then
  puppet_version='7'
elif [ "$1" == 'latest' ]; then
  puppet_version='7'
else
  puppet_version="$1"
fi

if [ "$USER" == 'root' ]; then
  sudo_command=''
elif [ -f /.dockerenv ]; then
  sudo_command=''
else
  sudo_command='sudo '
fi

which tput &>/dev/null
if [ "${?}" == "0" ]; then
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

# Skip if Puppet 5 or higher is already installed
if [ "$(which puppet)" ]; then
  puppet --version | grep "^[5|6|7]"
  if [ "$?" == "0" ]; then
    echo_title "Puppet version 5 or higher present. Skipping installation."
    exit 0
  fi
fi

setup_redhat() {
  echo_title "Uninstalling existing Puppet"
  $sudo_command yum erase -y puppet-agent puppet puppetlabs-release puppetlabs-release-pc1 &>/dev/null

  echo_title "Adding repo for Puppet"
  $sudo_command yum install -y https://yum.puppet.com/puppet${puppet_version}-release-el-${1}.noarch.rpm &>/dev/null

  sleep 2
  echo_title "Installing Puppet"
  $sudo_command yum install -y puppet-agent &>/dev/null
}

setup_fedora() {
  release=$1
  echo_title "Uninstalling existing Puppet"
  $sudo_command yum erase -y puppet-agent puppet puppet-release puppet-release-pc1 &>/dev/null

  echo_title "Adding repo for Puppet"
  $sudo_command yum install -y https://yum.puppet.com/puppet$puppet_version-release-fedora-${release}.noarch.rpm &>/dev/null

  sleep 2
  echo_title "Installing Puppet"
  $sudo_command yum install -y puppet-agent &>/dev/null
}

setup_amazon() {
  echo_title "Uninstalling existing Puppet"
  $sudo_command yum erase -y puppet-agent puppet puppetlabs-release puppetlabs-release-pc1 &>/dev/null

  echo_title "Adding repo for Puppet"
  $sudo_command yum install -y https://yum.puppet.com/puppet$puppet_version-release-el-${release}.noarch.rpm &>/dev/null

  sleep 2
  echo_title "Installing Puppet"
  $sudo_command yum install -y puppet-agent &>/dev/null
}

setup_suse() {
  echo_title "Uninstalling existing Puppet"
  $sudo_command zypper remove -y puppet puppet-agent puppetlabs-release puppetlabs-release-pc1 &>/dev/null

  echo_title "Adding repo for Puppet"
  $sudo_command zypper --no-gpg-checks --non-interactive install https://yum.puppet.com/puppet$puppet_version-release-sles-${release}.noarch.rpm &>/dev/null

  sleep 2
  echo_title "Installing Puppet"
  $sudo_command zypper --no-gpg-checks --non-interactive install puppet-agent &>/dev/null
}

setup_apt() {
  case $1 in
    3*) codename=cumulus ;;
    8) codename=jessie ; puppet_version='6'  ;;
    9) codename=stretch  ;;
    10) codename=buster  ;;
    11) codename=bullseye  ;;
    14.04) codename=trusty ;;
    16.04) codename=xenial ;;
    18.04) codename=bionic ;;
    19.04) codename=bionic ;;
    19.10) codename=bionic ;;
    20.04) codename=focal ;;
    20.10) codename=focal ;;
    21.04) codename=focal ;;
    21.10) codename=focal ;;
    22.04) codename=jammy ;;
    22.10) codename=jammy ;;
    *) echo "Release not supported" ;;
  esac

  echo_title "Adding repo for Puppet"
  $sudo_command wget -q "http://apt.puppet.com/puppet${puppet_version}-release-${codename}.deb" -O "/tmp/puppet${puppet_version}-release-${codename}.deb" &>/dev/null
  $sudo_command dpkg -i "/tmp/puppet${puppet_version}-release-${codename}.deb" &>/dev/null

  echo_title "Running apt update"
  $sudo_command apt update -qq &>/dev/null

  echo_title "Installing Puppet and its dependencies"
  $sudo_command apt-get install -qq -y apt-transport-https &>/dev/null
  $sudo_command apt-get install -y puppet-agent
#  $sudo_command apt-get install -qq -y puppet-agent &>/dev/null
}

setup_alpine() {
  echo "## Adding repo for Ruby to /etc/apk/repositories"
  echo http://dl-4.alpinelinux.org/alpine/edge/testing/ >> /etc/apk/repositories
  echo "## Running apk update"
  $sudo_command apk update

  echo "## Installing Puppet and its dependencies"
  $sudo_command apk add shadow ruby less bash
  $sudo_command gem install puppet --no-rdoc -no-ri
}

setup_solaris() {
  echo_title "Not yet supported"
}

setup_darwin() {
  majver=$(sw_vers -productVersion | cut -d '.' -f 1-2)
  echo_title "Downloading package for MacOS version ${majver}"
  curl -s -o puppet-agent.dmg "https://downloads.puppet.com/mac/puppet/${majver}/x86_64/puppet-agent-latest.dmg"

  echo_title "Installing Puppet Agent"
  hdiutil mount puppet-agent.dmg
  package=$(find /Volumes/puppet-agent*  | grep pkg)
  $sudo_command installer -pkg $package -target /
  hdiutil unmount /Volumes/puppet-agent*
}

setup_bsd() {
  echo_title "Not yet supported"
}

setup_windows() {
  curl -s -o puppet-agent.msi "https://downloads.puppet.com/windows/puppet/puppet-agent-x64-latest.msi"
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
    fedorarelease) setup_fedora $majver ;;
    centos) setup_redhat $majver ;;
    scientific) setup_redhat $majver ;;
    rockylinux) setup_redhat $majver ;;
    almalinux) setup_redhat $majver ;;
    almalinuxrelease) setup_redhat $majver ;;
    amzn) setup_amazon ;;
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

echo "Going to install Puppet (and eventually cleanup old version)"
echo "If you are not root some commands will be run via sudo"
if [ "x$breed" != "x" ]; then
  setup_$breed
else
  os_detect
fi
[ -e /usr/bin/puppet ] || $sudo_command ln -fs /opt/puppetlabs/puppet/bin/puppet /usr/bin/puppet
[ -e /usr/bin/facter ] || $sudo_command ln -fs /opt/puppetlabs/puppet/bin/facter /usr/bin/facter
