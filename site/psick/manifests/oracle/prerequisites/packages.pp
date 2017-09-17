# This class configures the packages prerequisites for Oracle installation
#
# To include and configure it do something like:
# @example
# ---
#   psick::oracle::prerequisites::packages_class: 'psick::oracle::prerequisites::packages'
#   psick::oracle::prerequisites::packages::use_defaults: true # Default value
#   psick::oracle::prerequisites::packages::extra_packages:
#     - toad
# @param use_defaults Define if to use default options or not. Note that if
#                     you set this to false the default template will fail,
#                     so you will need to provide a custom one.
# @param extra_packages An optional array of extra packages to install
#
class psick::oracle::prerequisites::packages (
  Boolean $use_defaults = true,
  Array $extra_packages = [],
) {

  if $use_defaults {
    case $::osfamily {
      'Suse': {
        $default_packages = [
          'binutils',
          'gcc',
          'gcc-c++',
          'glibc',
          'glibc-devel',
          'ksh',
          'libaio',
          'libaio-devel',
          'libcap1',
          'libstdc++33',
          'libstdc++33-32bit',
          'libstdc++43-devel',
          'libstdc++46',
          'libgcc46',
          'make',
          'sysstat',
          'xorg-x11-libs-32bit',
          'xorg-x11-libs',
          'xorg-x11-libX11-32bit',
          'xorg-x11-libX11',
          'xorg-x11-libXau-32bit',
          'xorg-x11-libXau',
          'xorg-x11-libxcb-32bit',
          'xorg-x11-libxcb',
          'xorg-x11-libXext-32bit',
          'xorg-x11-libXext',
        ]
      }
      'RedHat': {
        $default_packages = [
          'binutils.x86_64',
          'compat-libcap1.x86_64',
          'compat-libstdc++-33.i686',
          'compat-libstdc++-33.x86_64',
          'gcc.x86_64',
          'gcc-c++.x86_64',
          'libaio.i686',
          'glibc.i686',
          'glibc.x86_64',
          'glibc-devel.i686',
          'glibc-devel.x86_64',
          'ksh.x86_64',
          'libaio.x86_64',
          'libaio-devel.i686',
          'libaio-devel.x86_64',
          'libgcc.x86_64',
          'libgcc.i686',
          'libstdc++.x86_64',
          'libstdc++.i686',
          'libstdc++-devel.x86_64',
          'libstdc++-devel.i686',
          'libXext.x86_64',
          'libXtst.x86_64',
          'libXext.i686',
          'libXtst.i686',
          'libX11.x86_64',
          'libX11.i686',
          'libXau.x86_64',
          'libXau.i686',
          'libxcb.x86_64',
          'libxcb.i686',
          'libXi.x86_64',
          'libXi.i686',
          'make.x86_64',
          'sysstat.x86_64',
          'unixODBC-devel',
        ]
      }
      'Debian': {
        $default_packages = [
          'alien',
          'cpp-3.3',
          'debhelper',
          'g++-3.3',
          'gawk',
          'gcc-3.3',
          'gcc-3.3-base',
          'gettext',
          'html2text',
          'intltool-debian',
          'ksh',
          'lesstif2',
          'libaio-dev',
          'libaio1',
          'libbeecrypt6',
          'libdb3',
          'libelf-dev',
          'libelf1',
          'libltdl3',
          'libltdl3-dev',
          'libmotif3',
          'libodbcinstq1c2',
          'libqt4-core',
          'libqt4-gui',
          'librpm4.4',
          'libsqlite3-0',
          'libstdc++5',
          'libstdc++5-3.3-dev',
          'lsb',
          'lsb-core',
          'lsb-cxx',
          'lsb-desktop',
          'lsb-graphics',
          'lsb-qt4',
          'odbcinst1debian1',
          'pax',
          'po-debconf',
          'rpm',
          'sysstat',
          'unixodbc',
          'unixodbc-dev',
          'libc6-dev-i386',
        ]
      }
      default: { notice("Unsupported ${::osfamily} in psick::oracle::prerequisites::packages") }
    }
  } else {
    $default_packages = []
  }
  ensure_packages($default_packages + $extra_packages)
}
