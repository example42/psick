
al@mule pe_demo [ci] $ **vagrant status**
Current machine states:

puppet.demo               not created (virtualbox)
git.demo                  not created (virtualbox)
cirunner.demo             not created (virtualbox)
docker-build.demo         not created (virtualbox)
docker-host.demo          not created (virtualbox)
pe-centos7.demo           not created (virtualbox)
pe-centos6.demo           not created (virtualbox)
pe-ubuntu1604.demo        not created (virtualbox)
pe-suse12.demo            not created (virtualbox)
pe-suse11.demo            not created (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.


al@mule pe_demo [ci] $ **vagrant up puppet.demo**
Bringing machine 'puppet.demo' up with 'virtualbox' provider...
==> puppet.demo: Importing base box 'centos/7'...
==> puppet.demo: Matching MAC address for NAT networking...
==> puppet.demo: Checking if box 'centos/7' is up to date...
==> puppet.demo: Setting the name of the VM: pe_demo_puppetdemo_1486072967573_28129
==> puppet.demo: Clearing any previously set network interfaces...
==> puppet.demo: Preparing network interfaces based on configuration...
    puppet.demo: Adapter 1: nat
    puppet.demo: Adapter 2: hostonly
==> puppet.demo: Forwarding ports...
    puppet.demo: 443 (guest) => 1443 (host) (adapter 1)
    puppet.demo: 22 (guest) => 2222 (host) (adapter 1)
==> puppet.demo: Running 'pre-boot' VM customizations...
==> puppet.demo: Booting VM...
==> puppet.demo: Waiting for machine to boot. This may take a few minutes...
    puppet.demo: SSH address: 127.0.0.1:2222
    puppet.demo: SSH username: vagrant
    puppet.demo: SSH auth method: private key
    puppet.demo: Warning: Remote connection disconnect. Retrying...
    puppet.demo: Warning: Remote connection disconnect. Retrying...
    puppet.demo: Warning: Remote connection disconnect. Retrying...
    puppet.demo:
    puppet.demo: Vagrant insecure key detected. Vagrant will automatically replace
    puppet.demo: this with a newly generated keypair for better security.
    puppet.demo:
    puppet.demo: Inserting generated public key within guest...
    puppet.demo: Removing insecure key from the guest if it's present...
    puppet.demo: Key inserted! Disconnecting and reconnecting using new SSH key...
==> puppet.demo: Machine booted and ready!
[puppet.demo] No installation found.
Loaded plugins: fastestmirror
Determining fastest mirrors
 * base: mirror.ratiokontakt.de
 * extras: mirror.ratiokontakt.de
 * updates: mirror.23media.de
Package binutils-2.25.1-22.base.el7.x86_64 already installed and latest version
Package 1:make-3.82-23.el7.x86_64 already installed and latest version
Package bzip2-1.0.6-13.el7.x86_64 already installed and latest version
Resolving Dependencies
--> Running transaction check
---> Package gcc.x86_64 0:4.8.5-11.el7 will be installed
--> Processing Dependency: cpp = 4.8.5-11.el7 for package: gcc-4.8.5-11.el7.x86_64
--> Processing Dependency: glibc-devel >= 2.2.90-12 for package: gcc-4.8.5-11.el7.x86_64
--> Processing Dependency: libmpfr.so.4()(64bit) for package: gcc-4.8.5-11.el7.x86_64
--> Processing Dependency: libmpc.so.3()(64bit) for package: gcc-4.8.5-11.el7.x86_64
---> Package kernel-devel.x86_64 0:3.10.0-514.2.2.el7 will be installed
---> Package perl.x86_64 4:5.16.3-291.el7 will be installed
--> Processing Dependency: perl-libs = 4:5.16.3-291.el7 for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Socket) >= 1.3 for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Scalar::Util) >= 1.10 for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl-macros for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl-libs for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(threads::shared) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(threads) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(constant) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Time::Local) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Time::HiRes) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Storable) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Socket) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Scalar::Util) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Pod::Simple::XHTML) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Pod::Simple::Search) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Getopt::Long) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Filter::Util::Call) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(File::Temp) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(File::Spec::Unix) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(File::Spec::Functions) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(File::Spec) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(File::Path) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Exporter) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Cwd) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: perl(Carp) for package: 4:perl-5.16.3-291.el7.x86_64
--> Processing Dependency: libperl.so()(64bit) for package: 4:perl-5.16.3-291.el7.x86_64
--> Running transaction check
---> Package cpp.x86_64 0:4.8.5-11.el7 will be installed
---> Package glibc-devel.x86_64 0:2.17-157.el7_3.1 will be installed
--> Processing Dependency: glibc-headers = 2.17-157.el7_3.1 for package: glibc-devel-2.17-157.el7_3.1.x86_64
--> Processing Dependency: glibc-headers for package: glibc-devel-2.17-157.el7_3.1.x86_64
---> Package libmpc.x86_64 0:1.0.1-3.el7 will be installed
---> Package mpfr.x86_64 0:3.1.1-4.el7 will be installed
---> Package perl-Carp.noarch 0:1.26-244.el7 will be installed
---> Package perl-Exporter.noarch 0:5.68-3.el7 will be installed
---> Package perl-File-Path.noarch 0:2.09-2.el7 will be installed
---> Package perl-File-Temp.noarch 0:0.23.01-3.el7 will be installed
---> Package perl-Filter.x86_64 0:1.49-3.el7 will be installed
---> Package perl-Getopt-Long.noarch 0:2.40-2.el7 will be installed
--> Processing Dependency: perl(Pod::Usage) >= 1.14 for package: perl-Getopt-Long-2.40-2.el7.noarch
--> Processing Dependency: perl(Text::ParseWords) for package: perl-Getopt-Long-2.40-2.el7.noarch
---> Package perl-PathTools.x86_64 0:3.40-5.el7 will be installed
---> Package perl-Pod-Simple.noarch 1:3.28-4.el7 will be installed
--> Processing Dependency: perl(Pod::Escapes) >= 1.04 for package: 1:perl-Pod-Simple-3.28-4.el7.noarch
--> Processing Dependency: perl(Encode) for package: 1:perl-Pod-Simple-3.28-4.el7.noarch
---> Package perl-Scalar-List-Utils.x86_64 0:1.27-248.el7 will be installed
---> Package perl-Socket.x86_64 0:2.010-4.el7 will be installed
---> Package perl-Storable.x86_64 0:2.45-3.el7 will be installed
---> Package perl-Time-HiRes.x86_64 4:1.9725-3.el7 will be installed
---> Package perl-Time-Local.noarch 0:1.2300-2.el7 will be installed
---> Package perl-constant.noarch 0:1.27-2.el7 will be installed
---> Package perl-libs.x86_64 4:5.16.3-291.el7 will be installed
---> Package perl-macros.x86_64 4:5.16.3-291.el7 will be installed
---> Package perl-threads.x86_64 0:1.87-4.el7 will be installed
---> Package perl-threads-shared.x86_64 0:1.43-6.el7 will be installed
--> Running transaction check
---> Package glibc-headers.x86_64 0:2.17-157.el7_3.1 will be installed
--> Processing Dependency: kernel-headers >= 2.2.1 for package: glibc-headers-2.17-157.el7_3.1.x86_64
--> Processing Dependency: kernel-headers for package: glibc-headers-2.17-157.el7_3.1.x86_64
---> Package perl-Encode.x86_64 0:2.51-7.el7 will be installed
---> Package perl-Pod-Escapes.noarch 1:1.04-291.el7 will be installed
---> Package perl-Pod-Usage.noarch 0:1.63-3.el7 will be installed
--> Processing Dependency: perl(Pod::Text) >= 3.15 for package: perl-Pod-Usage-1.63-3.el7.noarch
--> Processing Dependency: perl-Pod-Perldoc for package: perl-Pod-Usage-1.63-3.el7.noarch
---> Package perl-Text-ParseWords.noarch 0:3.29-4.el7 will be installed
--> Running transaction check
---> Package kernel-headers.x86_64 0:3.10.0-514.6.1.el7 will be installed
---> Package perl-Pod-Perldoc.noarch 0:3.20-4.el7 will be installed
--> Processing Dependency: perl(parent) for package: perl-Pod-Perldoc-3.20-4.el7.noarch
--> Processing Dependency: perl(HTTP::Tiny) for package: perl-Pod-Perldoc-3.20-4.el7.noarch
---> Package perl-podlators.noarch 0:2.5.1-3.el7 will be installed
--> Running transaction check
---> Package perl-HTTP-Tiny.noarch 0:0.033-3.el7 will be installed
---> Package perl-parent.noarch 1:0.225-244.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package                    Arch       Version                Repository   Size
================================================================================
Installing:
 gcc                        x86_64     4.8.5-11.el7           base         16 M
 kernel-devel               x86_64     3.10.0-514.2.2.el7     updates      13 M
 perl                       x86_64     4:5.16.3-291.el7       base        8.0 M
Installing for dependencies:
 cpp                        x86_64     4.8.5-11.el7           base        5.9 M
 glibc-devel                x86_64     2.17-157.el7_3.1       updates     1.1 M
 glibc-headers              x86_64     2.17-157.el7_3.1       updates     668 k
 kernel-headers             x86_64     3.10.0-514.6.1.el7     updates     4.8 M
 libmpc                     x86_64     1.0.1-3.el7            base         51 k
 mpfr                       x86_64     3.1.1-4.el7            base        203 k
 perl-Carp                  noarch     1.26-244.el7           base         19 k
 perl-Encode                x86_64     2.51-7.el7             base        1.5 M
 perl-Exporter              noarch     5.68-3.el7             base         28 k
 perl-File-Path             noarch     2.09-2.el7             base         26 k
 perl-File-Temp             noarch     0.23.01-3.el7          base         56 k
 perl-Filter                x86_64     1.49-3.el7             base         76 k
 perl-Getopt-Long           noarch     2.40-2.el7             base         56 k
 perl-HTTP-Tiny             noarch     0.033-3.el7            base         38 k
 perl-PathTools             x86_64     3.40-5.el7             base         82 k
 perl-Pod-Escapes           noarch     1:1.04-291.el7         base         51 k
 perl-Pod-Perldoc           noarch     3.20-4.el7             base         87 k
 perl-Pod-Simple            noarch     1:3.28-4.el7           base        216 k
 perl-Pod-Usage             noarch     1.63-3.el7             base         27 k
 perl-Scalar-List-Utils     x86_64     1.27-248.el7           base         36 k
 perl-Socket                x86_64     2.010-4.el7            base         49 k
 perl-Storable              x86_64     2.45-3.el7             base         77 k
 perl-Text-ParseWords       noarch     3.29-4.el7             base         14 k
 perl-Time-HiRes            x86_64     4:1.9725-3.el7         base         45 k
 perl-Time-Local            noarch     1.2300-2.el7           base         24 k
 perl-constant              noarch     1.27-2.el7             base         19 k
 perl-libs                  x86_64     4:5.16.3-291.el7       base        688 k
 perl-macros                x86_64     4:5.16.3-291.el7       base         43 k
 perl-parent                noarch     1:0.225-244.el7        base         12 k
 perl-podlators             noarch     2.5.1-3.el7            base        112 k
 perl-threads               x86_64     1.87-4.el7             base         49 k
 perl-threads-shared        x86_64     1.43-6.el7             base         39 k

Transaction Summary
================================================================================
Install  3 Packages (+32 Dependent packages)

Total download size: 53 M
Installed size: 130 M
Downloading packages:
Public key for glibc-devel-2.17-157.el7_3.1.x86_64.rpm is not installed
warning: /var/cache/yum/x86_64/7/updates/packages/glibc-devel-2.17-157.el7_3.1.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID f4a80eb5: NOKEY
Public key for libmpc-1.0.1-3.el7.x86_64.rpm is not installed
--------------------------------------------------------------------------------
Total                                              1.7 MB/s |  53 MB  00:31
Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
Importing GPG key 0xF4A80EB5:
 Userid     : "CentOS-7 Key (CentOS 7 Official Signing Key) <security@centos.org>"
 Fingerprint: 6341 ab27 53d7 8a78 a7c2 7bb1 24c6 a8a7 f4a8 0eb5
 Package    : centos-release-7-3.1611.el7.centos.x86_64 (@anaconda)
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : mpfr-3.1.1-4.el7.x86_64                                     1/35
  Installing : libmpc-1.0.1-3.el7.x86_64                                   2/35
  Installing : cpp-4.8.5-11.el7.x86_64                                     3/35
  Installing : 1:perl-parent-0.225-244.el7.noarch                          4/35
  Installing : perl-HTTP-Tiny-0.033-3.el7.noarch                           5/35
  Installing : perl-podlators-2.5.1-3.el7.noarch                           6/35
  Installing : perl-Pod-Perldoc-3.20-4.el7.noarch                          7/35
  Installing : 1:perl-Pod-Escapes-1.04-291.el7.noarch                      8/35
  Installing : perl-Encode-2.51-7.el7.x86_64                               9/35
  Installing : perl-Text-ParseWords-3.29-4.el7.noarch                     10/35
  Installing : perl-Pod-Usage-1.63-3.el7.noarch                           11/35
  Installing : perl-threads-1.87-4.el7.x86_64                             12/35
  Installing : perl-Storable-2.45-3.el7.x86_64                            13/35
  Installing : perl-Exporter-5.68-3.el7.noarch                            14/35
  Installing : perl-constant-1.27-2.el7.noarch                            15/35
  Installing : perl-Time-Local-1.2300-2.el7.noarch                        16/35
  Installing : perl-Socket-2.010-4.el7.x86_64                             17/35
  Installing : perl-Carp-1.26-244.el7.noarch                              18/35
  Installing : 4:perl-Time-HiRes-1.9725-3.el7.x86_64                      19/35
  Installing : perl-threads-shared-1.43-6.el7.x86_64                      20/35
  Installing : perl-PathTools-3.40-5.el7.x86_64                           21/35
  Installing : perl-Scalar-List-Utils-1.27-248.el7.x86_64                 22/35
  Installing : 4:perl-libs-5.16.3-291.el7.x86_64                          23/35
  Installing : 4:perl-macros-5.16.3-291.el7.x86_64                        24/35
  Installing : 1:perl-Pod-Simple-3.28-4.el7.noarch                        25/35
  Installing : perl-File-Temp-0.23.01-3.el7.noarch                        26/35
  Installing : perl-File-Path-2.09-2.el7.noarch                           27/35
  Installing : perl-Filter-1.49-3.el7.x86_64                              28/35
  Installing : perl-Getopt-Long-2.40-2.el7.noarch                         29/35
  Installing : 4:perl-5.16.3-291.el7.x86_64                               30/35
  Installing : kernel-headers-3.10.0-514.6.1.el7.x86_64                   31/35
  Installing : glibc-headers-2.17-157.el7_3.1.x86_64                      32/35
  Installing : glibc-devel-2.17-157.el7_3.1.x86_64                        33/35
  Installing : gcc-4.8.5-11.el7.x86_64                                    34/35
  Installing : kernel-devel-3.10.0-514.2.2.el7.x86_64                     35/35
  Verifying  : perl-HTTP-Tiny-0.033-3.el7.noarch                           1/35
  Verifying  : perl-threads-shared-1.43-6.el7.x86_64                       2/35
  Verifying  : perl-Storable-2.45-3.el7.x86_64                             3/35
  Verifying  : perl-threads-1.87-4.el7.x86_64                              4/35
  Verifying  : perl-Exporter-5.68-3.el7.noarch                             5/35
  Verifying  : perl-constant-1.27-2.el7.noarch                             6/35
  Verifying  : perl-PathTools-3.40-5.el7.x86_64                            7/35
  Verifying  : cpp-4.8.5-11.el7.x86_64                                     8/35
  Verifying  : 1:perl-Pod-Escapes-1.04-291.el7.noarch                      9/35
  Verifying  : glibc-headers-2.17-157.el7_3.1.x86_64                      10/35
  Verifying  : 1:perl-parent-0.225-244.el7.noarch                         11/35
  Verifying  : perl-File-Temp-0.23.01-3.el7.noarch                        12/35
  Verifying  : 1:perl-Pod-Simple-3.28-4.el7.noarch                        13/35
  Verifying  : perl-Time-Local-1.2300-2.el7.noarch                        14/35
  Verifying  : perl-Pod-Perldoc-3.20-4.el7.noarch                         15/35
  Verifying  : perl-Socket-2.010-4.el7.x86_64                             16/35
  Verifying  : glibc-devel-2.17-157.el7_3.1.x86_64                        17/35
  Verifying  : perl-Carp-1.26-244.el7.noarch                              18/35
  Verifying  : 4:perl-Time-HiRes-1.9725-3.el7.x86_64                      19/35
  Verifying  : perl-Scalar-List-Utils-1.27-248.el7.x86_64                 20/35
  Verifying  : libmpc-1.0.1-3.el7.x86_64                                  21/35
  Verifying  : 4:perl-libs-5.16.3-291.el7.x86_64                          22/35
  Verifying  : 4:perl-macros-5.16.3-291.el7.x86_64                        23/35
  Verifying  : kernel-devel-3.10.0-514.2.2.el7.x86_64                     24/35
  Verifying  : perl-Pod-Usage-1.63-3.el7.noarch                           25/35
  Verifying  : perl-Encode-2.51-7.el7.x86_64                              26/35
  Verifying  : kernel-headers-3.10.0-514.6.1.el7.x86_64                   27/35
  Verifying  : perl-podlators-2.5.1-3.el7.noarch                          28/35
  Verifying  : perl-Getopt-Long-2.40-2.el7.noarch                         29/35
  Verifying  : perl-File-Path-2.09-2.el7.noarch                           30/35
  Verifying  : 4:perl-5.16.3-291.el7.x86_64                               31/35
  Verifying  : mpfr-3.1.1-4.el7.x86_64                                    32/35
  Verifying  : perl-Filter-1.49-3.el7.x86_64                              33/35
  Verifying  : perl-Text-ParseWords-3.29-4.el7.noarch                     34/35
  Verifying  : gcc-4.8.5-11.el7.x86_64                                    35/35

Installed:
  gcc.x86_64 0:4.8.5-11.el7        kernel-devel.x86_64 0:3.10.0-514.2.2.el7
  perl.x86_64 4:5.16.3-291.el7

Dependency Installed:
  cpp.x86_64 0:4.8.5-11.el7
  glibc-devel.x86_64 0:2.17-157.el7_3.1
  glibc-headers.x86_64 0:2.17-157.el7_3.1
  kernel-headers.x86_64 0:3.10.0-514.6.1.el7
  libmpc.x86_64 0:1.0.1-3.el7
  mpfr.x86_64 0:3.1.1-4.el7
  perl-Carp.noarch 0:1.26-244.el7
  perl-Encode.x86_64 0:2.51-7.el7
  perl-Exporter.noarch 0:5.68-3.el7
  perl-File-Path.noarch 0:2.09-2.el7
  perl-File-Temp.noarch 0:0.23.01-3.el7
  perl-Filter.x86_64 0:1.49-3.el7
  perl-Getopt-Long.noarch 0:2.40-2.el7
  perl-HTTP-Tiny.noarch 0:0.033-3.el7
  perl-PathTools.x86_64 0:3.40-5.el7
  perl-Pod-Escapes.noarch 1:1.04-291.el7
  perl-Pod-Perldoc.noarch 0:3.20-4.el7
  perl-Pod-Simple.noarch 1:3.28-4.el7
  perl-Pod-Usage.noarch 0:1.63-3.el7
  perl-Scalar-List-Utils.x86_64 0:1.27-248.el7
  perl-Socket.x86_64 0:2.010-4.el7
  perl-Storable.x86_64 0:2.45-3.el7
  perl-Text-ParseWords.noarch 0:3.29-4.el7
  perl-Time-HiRes.x86_64 4:1.9725-3.el7
  perl-Time-Local.noarch 0:1.2300-2.el7
  perl-constant.noarch 0:1.27-2.el7
  perl-libs.x86_64 4:5.16.3-291.el7
  perl-macros.x86_64 4:5.16.3-291.el7
  perl-parent.noarch 1:0.225-244.el7
  perl-podlators.noarch 0:2.5.1-3.el7
  perl-threads.x86_64 0:1.87-4.el7
  perl-threads-shared.x86_64 0:1.43-6.el7

Complete!
Copy iso file /Applications/VirtualBox.app/Contents/MacOS/VBoxGuestAdditions.iso into the box /tmp/VBoxGuestAdditions.iso
mount: /dev/loop0 is write-protected, mounting read-only
Installing Virtualbox Guest Additions 5.0.32 - guest version is unknown
Verifying archive integrity... All good.
Uncompressing VirtualBox 5.0.32 Guest Additions for Linux............
VirtualBox Guest Additions installer
Copying additional installer modules ...
Installing additional modules ...
Removing existing VirtualBox non-DKMS kernel modules[  OK  ]
Building the VirtualBox Guest Additions kernel modules
Building the main Guest Additions module[  OK  ]
Building the shared folder support module[  OK  ]
Building the graphics driver module[  OK  ]
Doing non-kernel setup of the Guest Additions[  OK  ]
Starting the VirtualBox Guest Additions Installing the Window System drivers
Could not find the X.Org or XFree86 Window System, skipping.
[  OK  ]
==> puppet.demo: Checking for guest additions in VM...
==> puppet.demo: [vagrant-hostsupdater] Checking for host entries
==> puppet.demo: [vagrant-hostsupdater] Writing the following entries to (/etc/hosts)
==> puppet.demo: [vagrant-hostsupdater]   10.42.42.101  puppet.demo  # VAGRANT: 7b8b8657ebeb90e56c2db1f4ea43e268 (puppet.demo) / 82feed4f-c238-40a3-bf95-ec4d5fbf4ef2
==> puppet.demo: [vagrant-hostsupdater] This operation requires administrative access. You may skip it by manually adding equivalent entries to the hosts file.
==> puppet.demo: Setting hostname...
==> puppet.demo: Configuring and enabling network interfaces...
==> puppet.demo: Rsyncing folder: /Users/al/Documents/github/EXAMPLE42/control-repo/vagrant/environments/pe_demo/ => /vagrant
==> puppet.demo: Mounting shared folders...
    puppet.demo: /etc/puppetlabs/code/environments/host => /Users/al/Documents/github/EXAMPLE42/control-repo
==> puppet.demo: Updating /etc/hosts file on active guest machines...
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-47069-1aj5w6h.sh
==> puppet.demo: ### Setting hostname puppet.demo
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-47069-k53jc7.sh
==> puppet.demo: ### Setting trusted facts pp_role=puppet pp_environment=demo pp_zone=demo pp_datacenter=vagrant pp_application=default
==> puppet.demo: Running provisioner: pe_bootstrap...
Fetching: https://s3.amazonaws.com/pe-builds/released/2016.5.1/puppet-enterprise-2016.5.1-el-7-x86_64.tar.gz
Fetching file: 100% |=========================================================================================>| Time: 00:10:18
==> puppet.demo: bash: line 2: /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/puppet-enterprise-installer: No such file or directory
The following SSH command responded with a non-zero exit status.
Vagrant assumes that this means the command failed!

/vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/puppet-enterprise-installer -c /vagrant/.pe_build/answers/puppet.demo.txt
Stdout from the command:
Stderr from the command:
bash: line 2: /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/puppet-enterprise-installer: No such file or directory


al@mule pe_demo [ci] $ **vagrant reload puppet.demo**
==> puppet.demo: [vagrant-hostsupdater] Removing hosts
==> puppet.demo: Attempting graceful shutdown of VM...
==> puppet.demo: Checking if box 'centos/7' is up to date...
==> puppet.demo: Clearing any previously set forwarded ports...
==> puppet.demo: Clearing any previously set network interfaces...
==> puppet.demo: Preparing network interfaces based on configuration...
    puppet.demo: Adapter 1: nat
    puppet.demo: Adapter 2: hostonly
==> puppet.demo: Forwarding ports...
    puppet.demo: 443 (guest) => 1443 (host) (adapter 1)
    puppet.demo: 22 (guest) => 2222 (host) (adapter 1)
==> puppet.demo: Running 'pre-boot' VM customizations...
==> puppet.demo: Booting VM...
==> puppet.demo: Waiting for machine to boot. This may take a few minutes...
    puppet.demo: SSH address: 127.0.0.1:2222
    puppet.demo: SSH username: vagrant
    puppet.demo: SSH auth method: private key
    puppet.demo: Warning: Remote connection disconnect. Retrying...
==> puppet.demo: Machine booted and ready!
[puppet.demo] GuestAdditions 5.0.32 running --- OK.
==> puppet.demo: Checking for guest additions in VM...
==> puppet.demo: [vagrant-hostsupdater] Checking for host entries
==> puppet.demo: [vagrant-hostsupdater] Writing the following entries to (/etc/hosts)
==> puppet.demo: [vagrant-hostsupdater]   10.42.42.101  puppet.demo  # VAGRANT: 7b8b8657ebeb90e56c2db1f4ea43e268 (puppet.demo) / 82feed4f-c238-40a3-bf95-ec4d5fbf4ef2
==> puppet.demo: [vagrant-hostsupdater] This operation requires administrative access. You may skip it by manually adding equivalent entries to the hosts file.
==> puppet.demo: Setting hostname...
==> puppet.demo: Configuring and enabling network interfaces...
==> puppet.demo: Rsyncing folder: /Users/al/Documents/github/EXAMPLE42/control-repo/vagrant/environments/pe_demo/ => /vagrant
==> puppet.demo: Mounting shared folders...
    puppet.demo: /etc/puppetlabs/code/environments/host => /Users/al/Documents/github/EXAMPLE42/control-repo
==> puppet.demo: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> puppet.demo: flag to force provisioning. Provisioners marked to run always will still run.


al@mule pe_demo [ci] $ **vagrant provision puppet.demo**
==> puppet.demo: [vagrant-hostsupdater] Checking for host entries
==> puppet.demo: [vagrant-hostsupdater]   found entry for: 10.42.42.101 puppet.demo
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-47944-jbi5ht.sh
==> puppet.demo: ### Setting hostname puppet.demo
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-47944-1qxwn3a.sh
==> puppet.demo: Running provisioner: pe_bootstrap...
==> puppet.demo: /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64 /home/vagrant
==> puppet.demo: =============================================================
==> puppet.demo:     Puppet Enterprise Installer
==> puppet.demo: =============================================================
==> puppet.demo:
==> puppet.demo: ## We're installing the Puppet Agent...
==> puppet.demo:
==> puppet.demo: 2017-02-02 22:19:32,285 Running command: mkdir -p /opt/puppetlabs/server/data/packages/public/2016.5.1/el-7-x86_64-1.8.2
==> puppet.demo: 2017-02-02 22:19:32,289 Running command: cp -r -L /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/packages/el-7-x86_64/* /opt/puppetlabs/server/data/packages/public/2016.5.1/el-7-x86_64-1.8.2
==> puppet.demo: 2017-02-02 22:19:32,800 Running command: cp -r -L /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/packages/GPG-KEY-puppetlabs /opt/puppetlabs/server/data/packages/public
==> puppet.demo: 2017-02-02 22:19:32,805 Running command: cp -r -L /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/packages/GPG-KEY-puppet /opt/puppetlabs/server/data/packages/public
==> puppet.demo: 2017-02-02 22:19:32,809 Running command: mkdir -p /etc/yum.repos.d
==> puppet.demo: 2017-02-02 22:19:32,813 Running command: echo '[puppet_enterprise]' > /etc/yum.repos.d/puppet_enterprise.repo
==> puppet.demo: 2017-02-02 22:19:32,817 Running command: echo 'name=PuppetLabs PE Packages $releasever - $basearch' >> /etc/yum.repos.d/puppet_enterprise.repo
==> puppet.demo: 2017-02-02 22:19:32,820 Running command: echo 'baseurl=file:///opt/puppetlabs/server/data/packages/public/2016.5.1/el-7-x86_64-1.8.2' >> /etc/yum.repos.d/puppet_enterprise.repo
==> puppet.demo: 2017-02-02 22:19:32,827 Running command: echo 'enabled=1' >> /etc/yum.repos.d/puppet_enterprise.repo
==> puppet.demo: 2017-02-02 22:19:32,831 Running command: echo 'gpgcheck=1' >> /etc/yum.repos.d/puppet_enterprise.repo
==> puppet.demo: 2017-02-02 22:19:32,837 Running command: echo -e 'gpgkey=file:///opt/puppetlabs/server/data/packages/public/GPG-KEY-puppetlabs\n       file:///opt/puppetlabs/server/data/packages/public/GPG-KEY-puppet' >> /etc/yum.repos.d/puppet_enterprise.repo
==> puppet.demo: 2017-02-02 22:19:32,841 Running command: rpm --import /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/packages/GPG-KEY-puppetlabs
==> puppet.demo: 2017-02-02 22:19:32,918 Running command: rpm --import /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/packages/GPG-KEY-puppet
==> puppet.demo: 2017-02-02 22:19:32,952 Running command: yum clean all --disablerepo='*' --enablerepo=puppet_enterprise
==> puppet.demo: Loaded plugins: fastestmirror
==> puppet.demo: Cleaning repos: puppet_enterprise
==> puppet.demo: Cleaning up everything
==> puppet.demo: Cleaning up list of fastest mirrors
==> puppet.demo: 2017-02-02 22:19:33,191 Running command: yum install -y puppet-agent pe-bundler pe-installer
==> puppet.demo: Loaded plugins: fastestmirror
==> puppet.demo: Determining fastest mirrors
==> puppet.demo:  * base: mirror.de.leaseweb.net
==> puppet.demo:  * extras: mirror.de.leaseweb.net
==> puppet.demo:  * updates: centos.schlundtech.de
==> puppet.demo: Resolving Dependencies
==> puppet.demo: --> Running transaction check
==> puppet.demo: ---> Package pe-bundler.noarch 0:2016.5.1.8.2-1.pe.el7 will be installed
==> puppet.demo: ---> Package pe-installer.x86_64 0:2016.5.0-0.1rc0.3.el7 will be installed
==> puppet.demo: ---> Package puppet-agent.x86_64 0:1.8.2-1.el7 will be installed
==> puppet.demo: --> Finished Dependency Resolution
==> puppet.demo:
==> puppet.demo: Dependencies Resolved
==> puppet.demo:
==> puppet.demo: ================================================================================
==> puppet.demo:  Package         Arch      Version                   Repository            Size
==> puppet.demo: ================================================================================
==> puppet.demo: Installing:
==> puppet.demo:  pe-bundler      noarch    2016.5.1.8.2-1.pe.el7     puppet_enterprise    218 k
==> puppet.demo:  pe-installer    x86_64    2016.5.0-0.1rc0.3.el7     puppet_enterprise    4.0 M
==> puppet.demo:  puppet-agent    x86_64    1.8.2-1.el7               puppet_enterprise     25 M
==> puppet.demo:
==> puppet.demo: Transaction Summary
==> puppet.demo: ================================================================================
==> puppet.demo: Install  3 Packages
==> puppet.demo:
==> puppet.demo: Total download size: 30 M
==> puppet.demo: Installed size: 133 M
==> puppet.demo: Downloading packages:
==> puppet.demo: --------------------------------------------------------------------------------
==> puppet.demo: Total                                              521 MB/s |  30 MB  00:00
==> puppet.demo: Running transaction check
==> puppet.demo: Running transaction test
==> puppet.demo: Transaction test succeeded
==> puppet.demo: Running transaction
==> puppet.demo:   Installing : puppet-agent-1.8.2-1.el7.x86_64                              1/3
==> puppet.demo:
==> puppet.demo:   Installing : pe-bundler-2016.5.1.8.2-1.pe.el7.noarch                      2/3
==> puppet.demo:
==> puppet.demo:   Installing : pe-installer-2016.5.0-0.1rc0.3.el7.x86_64                    3/3
==> puppet.demo:
==> puppet.demo:   Verifying  : pe-bundler-2016.5.1.8.2-1.pe.el7.noarch                      1/3
==> puppet.demo:
==> puppet.demo:   Verifying  : puppet-agent-1.8.2-1.el7.x86_64                              2/3
==> puppet.demo:
==> puppet.demo:   Verifying  : pe-installer-2016.5.0-0.1rc0.3.el7.x86_64                    3/3
==> puppet.demo:
==> puppet.demo:
==> puppet.demo: Installed:
==> puppet.demo:   pe-bundler.noarch 0:2016.5.1.8.2-1.pe.el7
==> puppet.demo:   pe-installer.x86_64 0:2016.5.0-0.1rc0.3.el7
==> puppet.demo:   puppet-agent.x86_64 0:1.8.2-1.el7
==> puppet.demo:
==> puppet.demo: Complete!
==> puppet.demo:
==> puppet.demo:
==> puppet.demo: ## We're checking if /vagrant/.pe_build/answers/puppet.demo.txt contains valid HOCON syntax...
==> puppet.demo:
==> puppet.demo:
==> puppet.demo: ## We're configuring the PE Modules...
==> puppet.demo:
==> puppet.demo: 2017-02-02 22:19:42,339 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_accounts-2.0.2-6-gd2f698c.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Created target directory /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_accounts (v2.0.2-6-gd2f698c)
==> puppet.demo: 2017-02-02 22:19:43,303 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_concat-1.1.2-7-g77ec55b.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_concat (v1.1.2-7-g77ec55b)
==> puppet.demo: 2017-02-02 22:19:44,266 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_console_prune-0.1.1-9-gfc256c0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_console_prune (v0.1.1-9-gfc256c0)
==> puppet.demo: 2017-02-02 22:19:45,198 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_hocon-2016.2.0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_hocon (v2016.2.0)
==> puppet.demo: 2017-02-02 22:19:46,140 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_infrastructure-2016.5.0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_infrastructure (v2016.5.0)
==> puppet.demo: 2017-02-02 22:19:47,090 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_inifile-2016.5.0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_inifile (v2016.5.0)
==> puppet.demo: 2017-02-02 22:19:48,020 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_install-2016.5.0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_install (v2016.5.0)
==> puppet.demo: 2017-02-02 22:19:48,974 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_java_ks-1.2.4-37-g2d86015.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_java_ks (v1.2.4-37-g2d86015)
==> puppet.demo: 2017-02-02 22:19:49,910 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_manager-2016.5.0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_manager (v2016.5.0)
==> puppet.demo: 2017-02-02 22:19:50,852 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_nginx-2016.4.0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_nginx (v2016.4.0)
==> puppet.demo: 2017-02-02 22:19:51,830 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_postgresql-2016.5.0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_postgresql (v2016.5.0)
==> puppet.demo: 2017-02-02 22:19:52,772 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_puppet_authorization-2016.2.0-rc1.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_puppet_authorization (v2016.2.0-rc1)
==> puppet.demo: 2017-02-02 22:19:53,719 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_r10k-2016.2.0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_r10k (v2016.2.0)
==> puppet.demo: 2017-02-02 22:19:54,633 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_razor-1.0.1.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_razor (v1.0.1)
==> puppet.demo: 2017-02-02 22:19:55,583 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_repo-2016.5.0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_repo (v2016.5.0)
==> puppet.demo: 2017-02-02 22:19:56,526 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_staging-2015.3.0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_staging (v2015.3.0)
==> puppet.demo: 2017-02-02 22:19:57,469 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-pe_support_script-2016.5.0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-pe_support_script (v2016.5.0)
==> puppet.demo: 2017-02-02 22:19:58,429 Running command: /opt/puppetlabs/puppet/bin/puppet module install /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/puppetlabs-puppet_enterprise-2016.5.0.tar.gz       --force       --ignore-dependencies       --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: Notice: Preparing to install into /opt/puppetlabs/server/data/enterprise/modules ...
==> puppet.demo: Notice: Installing -- do not interrupt ...
==> puppet.demo: /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: └── puppetlabs-puppet_enterprise (v2016.5.0)
==> puppet.demo: 2017-02-02 22:19:59,412 Running command: rm -rf /opt/puppetlabs/server/share/installer/modules
==> puppet.demo: 2017-02-02 22:19:59,416 Running command: mkdir -p /opt/puppetlabs/server/share/installer/modules
==> puppet.demo: 2017-02-02 22:19:59,420 Running command: cp -R -L /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/modules/* /opt/puppetlabs/server/share/installer/modules
==> puppet.demo: 2017-02-02 22:19:59,427 Running command: chmod 0755 /opt/puppetlabs/server/share/installer/modules
==> puppet.demo: 2017-02-02 22:19:59,432 Running command: chmod -R 0750 /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo:
==> puppet.demo: ## We're configuring PE using /vagrant/.pe_build/answers/puppet.demo.txt...
==> puppet.demo:
==> puppet.demo: 2017-02-02 22:19:59,450 Running command: mkdir -p /opt/puppetlabs/server
==> puppet.demo: 2017-02-02 22:19:59,455 Running command: cp -L /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/VERSION /opt/puppetlabs/server/pe_build
==> puppet.demo: 2017-02-02 22:19:59,462 Running command: chown root:root /opt/puppetlabs/server/pe_build
==> puppet.demo: 2017-02-02 22:19:59,466 Running command: chmod 644 /opt/puppetlabs/server/pe_build
==> puppet.demo: 2017-02-02 22:19:59,470 Running command: mkdir -p /etc/puppetlabs/enterprise/conf.d
==> puppet.demo: 2017-02-02 22:19:59,484 Running command: cp /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/conf.d/hiera.yaml /etc/puppetlabs/enterprise
==> puppet.demo: 2017-02-02 22:19:59,490 Running command: cp /vagrant/.pe_build/answers/puppet.demo.txt /etc/puppetlabs/enterprise/conf.d/pe.conf
==> puppet.demo: 2017-02-02 22:19:59,496 Running command: chown -R root:root /etc/puppetlabs/enterprise
==> puppet.demo: 2017-02-02 22:19:59,500 Running command: chmod -R 600 /etc/puppetlabs/enterprise
==> puppet.demo: 2017-02-02 22:19:59,505 Running command: cp /vagrant/.pe_build/puppet-enterprise-2016.5.1-el-7-x86_64/puppet-enterprise-uninstaller /opt/puppetlabs/bin
==> puppet.demo: 2017-02-02 22:19:59,516 Running command: chown root:root /opt/puppetlabs/bin/puppet-enterprise-uninstaller
==> puppet.demo: 2017-02-02 22:19:59,521 Running command: chmod 755 /opt/puppetlabs/bin/puppet-enterprise-uninstaller
==> puppet.demo: 2017-02-02 22:19:59,528 Running command: /opt/puppetlabs/puppet/bin/puppet infrastructure configure  --detailed-exitcodes --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: 2017-02-02 22:20:07,996 - [Notice]: Compiled catalog for puppet.demo in environment production in 5.60 seconds
==> puppet.demo: 2017-02-02 22:20:09,976 - [Notice]: /Stage[main]/Pe_install::Prepare::Puppet_config/Pe_ini_setting[main/certname]/ensure: created
==> puppet.demo: 2017-02-02 22:20:09,977 - [Notice]: /Stage[main]/Pe_install::Prepare::Puppet_config/Pe_ini_setting[main/server]/ensure: created
==> puppet.demo: 2017-02-02 22:20:09,980 - [Notice]: /Stage[main]/Pe_install::Prepare::Puppet_config/Pe_ini_setting[main/user]/ensure: created
==> puppet.demo: 2017-02-02 22:20:09,984 - [Notice]: /Stage[main]/Pe_install::Prepare::Puppet_config/Pe_ini_setting[main/group]/ensure: created
==> puppet.demo: 2017-02-02 22:20:09,986 - [Notice]: /Stage[main]/Pe_install::Prepare::Puppet_config/Pe_ini_setting[agent/graph]/ensure: created
==> puppet.demo: 2017-02-02 22:20:15,112 - [Notice]: /Stage[main]/Pe_install::Prepare::Certificates/Exec[generate ca cert]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:20:15,118 - [Notice]: /Stage[main]/Pe_install::Prepare::Certificates/File[/etc/puppetlabs/puppet/autosign.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:20:20,721 - [Notice]: /Stage[main]/Puppet_enterprise::Packages/Package[pe-java]/ensure: created
==> puppet.demo: 2017-02-02 22:20:23,624 - [Notice]: /Stage[main]/Puppet_enterprise::Packages/Package[pe-client-tools]/ensure: created
==> puppet.demo: 2017-02-02 22:20:24,308 - [Notice]: /Stage[main]/Puppet_enterprise::Packages/Package[pe-license]/ensure: created
==> puppet.demo: 2017-02-02 22:20:25,001 - [Notice]: /Stage[main]/Puppet_enterprise::Packages/Package[pe-puppet-license-cli]/ensure: created
==> puppet.demo: 2017-02-02 22:20:25,711 - [Notice]: /Stage[main]/Puppet_enterprise::Packages/Package[pe-puppetdb-termini]/ensure: created
==> puppet.demo: 2017-02-02 22:20:26,396 - [Notice]: /Stage[main]/Puppet_enterprise::Packages/Package[pe-console-services-termini]/ensure: created
==> puppet.demo: 2017-02-02 22:20:33,768 - [Notice]: /Stage[main]/Puppet_enterprise::Packages/Package[pe-puppetserver]/ensure: created
==> puppet.demo: 2017-02-02 22:20:35,799 - [Notice]: /Stage[main]/Pe_install::Prepare::Certificates/Exec[generate cert for pe-internal-mcollective-servers]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:20:38,701 - [Notice]: /Stage[main]/Pe_install::Prepare::Certificates/Exec[generate cert for pe-internal-peadmin-mcollective-client]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:20:38,773 - [Notice]: /Stage[main]/Pe_install::Install/File[default site.pp]/ensure: defined content as '{md5}5f6b8b2e8fb22e6383a2f4a24df2dc0c'
==> puppet.demo: 2017-02-02 22:20:38,775 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master::Classifier/Pe_ini_setting[node_terminus]/ensure: created
==> puppet.demo: 2017-02-02 22:20:38,780 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master::Classifier/File[/etc/puppetlabs/puppet/classifier.yaml]/ensure: defined content as '{md5}c31f498b03a1991ad5766c84eab61932'
==> puppet.demo: 2017-02-02 22:20:38,785 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master::Puppetdb/File[/etc/puppetlabs/puppet/puppetdb.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:20:38,787 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master::Puppetdb/Pe_ini_setting[puppetdb.conf_server_urls]/ensure: created
==> puppet.demo: 2017-02-02 22:20:38,789 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master::Puppetdb/Pe_ini_setting[puppetdb.conf_command_broadcast]/ensure: created
==> puppet.demo: 2017-02-02 22:20:38,791 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master::Puppetdb/Pe_ini_setting[puppetdb.conf_include_unchanged_resources]/ensure: created
==> puppet.demo: 2017-02-02 22:20:38,794 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master::Puppetdb/Pe_ini_setting[puppetdb.conf_soft_write_failure]/ensure: created
==> puppet.demo: 2017-02-02 22:20:38,798 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master::Puppetdb/Pe_ini_setting[puppetdb.conf_sticky_read_failover]/ensure: created
==> puppet.demo: 2017-02-02 22:20:38,893 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master::Puppetdb/Pe_ini_setting[storeconfigs]/ensure: created
==> puppet.demo: 2017-02-02 22:20:38,895 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master::Puppetdb/Pe_ini_setting[storeconfigs_backend]/ensure: created
==> puppet.demo: 2017-02-02 22:20:38,897 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master::Puppetdb/Pe_ini_subsetting[reports_puppetdb]/ensure: created
==> puppet.demo: 2017-02-02 22:20:38,902 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master::Puppetdb/File[/etc/puppetlabs/puppet/routes.yaml]/ensure: defined content as '{md5}85f1d4003267907c2975c953bf12d95c'
==> puppet.demo: 2017-02-02 22:20:42,929 - [Notice]: /Stage[main]/Puppet_enterprise::Packages/Package[pe-activemq]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,321 - [Notice]: /Stage[main]/Puppet_enterprise::Symlinks/File[/usr/local/bin/facter]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,323 - [Notice]: /Stage[main]/Puppet_enterprise::Symlinks/File[/usr/local/bin/puppet]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,327 - [Notice]: /Stage[main]/Puppet_enterprise::Symlinks/File[/usr/local/bin/pe-man]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,330 - [Notice]: /Stage[main]/Puppet_enterprise::Symlinks/File[/usr/local/bin/hiera]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,334 - [Notice]: /Stage[main]/Puppet_enterprise::Symlinks/File[/usr/local/bin/mco]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,337 - [Notice]: /Stage[main]/Puppet_enterprise::Symlinks/File[/usr/local/bin/r10k]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,344 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/webserver.conf]/owner: owner changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,344 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/webserver.conf]/group: group changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,345 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/webserver.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:20:43,429 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[webserver.puppet-server.ssl-cert]/value: value changed ['/etc/puppetlabs/puppet/ssl/certs/localhost.pem'] to '/etc/puppetlabs/puppet/ssl/certs/puppet.demo.pem'
==> puppet.demo: 2017-02-02 22:20:43,436 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[webserver.puppet-server.ssl-key]/value: value changed ['/etc/puppetlabs/puppet/ssl/private_keys/localhost.pem'] to '/etc/puppetlabs/puppet/ssl/private_keys/puppet.demo.pem'
==> puppet.demo: 2017-02-02 22:20:43,449 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[webserver.puppet-server.ssl-crl-path]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,473 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[webserver.puppet-server.static-content]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,484 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/web-routes.conf]/owner: owner changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,485 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/web-routes.conf]/group: group changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,486 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/web-routes.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:20:43,555 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[web-router-service/reverse-proxy-ca-service]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,575 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/pe-puppet-server.conf]/owner: owner changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,576 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/pe-puppet-server.conf]/group: group changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,577 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/pe-puppet-server.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:20:43,597 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[jruby-puppet.ruby-load-path]/value: value changed ['/opt/puppetlabs/puppet/lib/ruby/vendor_ruby'] to '/opt/puppetlabs/puppet/lib/ruby/vendor_ruby /opt/puppetlabs/puppet/cache/lib'
==> puppet.demo: 2017-02-02 22:20:43,672 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[jruby-puppet.max-requests-per-instance]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,682 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[jruby-puppet.use-legacy-auth-conf]/value: value changed ['true'] to 'false'
==> puppet.demo: 2017-02-02 22:20:43,718 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[pe-puppetserver.pre-commit-hook-commands]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,743 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/global.conf]/owner: owner changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,744 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/global.conf]/group: group changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,744 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/global.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:20:43,763 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[/etc/puppetlabs/puppetserver/conf.d/global.conf#global.hostname]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,766 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[global.certs.ssl-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,770 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[global.certs.ssl-key]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,775 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[global.certs.ssl-ca-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,778 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/metrics.conf]/owner: owner changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,779 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/metrics.conf]/group: group changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,780 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/metrics.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:20:43,798 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[metrics.server-id]/value: value changed ['localhost'] to 'puppet'
==> puppet.demo: 2017-02-02 22:20:43,809 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[metrics.registries.puppetserver.reporters.graphite.enabled]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,830 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/rbac-consumer.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,833 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[rbac-consumer.api-url]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,835 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/File[/etc/puppetlabs/puppetserver/conf.d/activity-consumer.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,838 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_hocon_setting[activity-consumer.api-url]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,841 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_ini_setting[puppetserver initconf user]/value: value changed '"pe-puppet"' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,843 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_ini_setting[puppetserver initconf group]/value: value changed '"pe-puppet"' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,911 - [Notice]: /Stage[main]/Puppet_enterprise::Master/File[/opt/puppetlabs/server/pe_build]/content: content changed '{md5}2ad9031d266a698717b55cf2c01665fb' to '{md5}9be667de28dc411dce734d68d84f7e3e'
==> puppet.demo: 2017-02-02 22:20:43,911 - [Notice]: /Stage[main]/Puppet_enterprise::Master/File[/opt/puppetlabs/server/pe_build]/owner: owner changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,912 - [Notice]: /Stage[main]/Puppet_enterprise::Master/File[/opt/puppetlabs/server/pe_build]/group: group changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:43,914 - [Notice]: /Stage[main]/Puppet_enterprise::Master/File[/opt/puppetlabs/server/pe_build]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:20:43,917 - [Notice]: /Stage[main]/Puppet_enterprise::Master/Pe_ini_setting[puppetserver puppetconf certname]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,919 - [Notice]: /Stage[main]/Puppet_enterprise::Master/Pe_ini_setting[puppetserver puppetconf always_cache_features]/ensure: created
==> puppet.demo: 2017-02-02 22:20:43,922 - [Notice]: /Stage[main]/Puppet_enterprise::Master/Pe_ini_setting[puppetconf environment_timeout setting]/ensure: created
==> puppet.demo: 2017-02-02 22:20:46,594 - [Notice]: /Stage[main]/Pe_r10k::Package/Package[pe-r10k]/ensure: created
==> puppet.demo: 2017-02-02 22:20:46,599 - [Notice]: /Stage[main]/Puppet_enterprise::Master::File_sync_disabled/File[/etc/puppetlabs/puppetserver/conf.d/file-sync.conf]/ensure: removed
==> puppet.demo: 2017-02-02 22:20:46,606 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Controller/File[/etc/puppetlabs/client-tools/ssl]/ensure: created
==> puppet.demo: 2017-02-02 22:20:46,610 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Controller/File[/etc/puppetlabs/client-tools/ssl/certs]/ensure: created
==> puppet.demo: 2017-02-02 22:20:46,770 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Controller/File[/etc/puppetlabs/client-tools/ssl/certs/ca.pem]/ensure: defined content as '{md5}b3e804f6bb0b1ef28a7d5ea46c3ae1cc'
==> puppet.demo: 2017-02-02 22:20:46,776 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Controller/File[/etc/puppetlabs/client-tools/orchestrator.conf]/ensure: defined content as '{md5}8ed7304edbcb6834903e0509c62c86d9'
==> puppet.demo: 2017-02-02 22:20:46,781 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Controller/File[/etc/puppetlabs/client-tools/puppet-code.conf]/ensure: defined content as '{md5}4d5462a3943447a8a139ac767ca32e41'
==> puppet.demo: 2017-02-02 22:20:46,785 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Controller/File[/etc/puppetlabs/client-tools/puppet-access.conf]/ensure: defined content as '{md5}c7f6bc465dc9ac04c5d9f89bd532354f'
==> puppet.demo: 2017-02-02 22:20:46,790 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Controller/File[/etc/puppetlabs/client-tools/puppetdb.conf]/ensure: defined content as '{md5}dadc160229ec14220a12a14c2bb5d71b'
==> puppet.demo: 2017-02-02 22:20:46,795 - [Notice]: /Stage[main]/Puppet_enterprise::Cli_config/File[/etc/puppetlabs/client-tools/services.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:20:46,799 - [Notice]: /Stage[main]/Puppet_enterprise::Cli_config/Pe_hocon_setting[/etc/puppetlabs/client-tools/services.conf/services]/ensure: created
==> puppet.demo: 2017-02-02 22:20:46,802 - [Notice]: /Stage[main]/Puppet_enterprise::Cli_config/Pe_hocon_setting[/etc/puppetlabs/client-tools/services.conf/nodes]/ensure: created
==> puppet.demo: 2017-02-02 22:20:46,806 - [Notice]: /Stage[main]/Puppet_enterprise::Cli_config/Pe_hocon_setting[/etc/puppetlabs/client-tools/services.conf/certs]/ensure: created
==> puppet.demo: 2017-02-02 22:20:46,929 - [Notice]: /Stage[main]/Pe_install::Install::Ssldir/File[/etc/puppetlabs/puppet/ssl/ca/signed/pe-internal-mcollective-servers.pem]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:20:46,931 - [Notice]: /Stage[main]/Pe_install::Install::Ssldir/File[/etc/puppetlabs/puppet/ssl/ca/signed/pe-internal-peadmin-mcollective-client.pem]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:20:46,935 - [Notice]: /Stage[main]/Pe_install::Install::Ssldir/File[/etc/puppetlabs/puppet/ssl/ca/signed/puppet.demo.pem]/owner: owner changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:46,935 - [Notice]: /Stage[main]/Pe_install::Install::Ssldir/File[/etc/puppetlabs/puppet/ssl/ca/signed/puppet.demo.pem]/group: group changed 'root' to 'pe-puppet'
==> puppet.demo: 2017-02-02 22:20:46,937 - [Notice]: /Stage[main]/Pe_install::Install::Ssldir/File[/etc/puppetlabs/puppet/ssl/ca/signed/puppet.demo.pem]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:20:46,945 - [Notice]: /Stage[main]/Pe_install::Install::Ssldir/File[/etc/puppetlabs/puppet/ssl/certs/pe-internal-mcollective-servers.pem]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:20:46,947 - [Notice]: /Stage[main]/Pe_install::Install::Ssldir/File[/etc/puppetlabs/puppet/ssl/certs/pe-internal-peadmin-mcollective-client.pem]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:20:46,963 - [Notice]: /Stage[main]/Pe_install::Install::Ssldir/File[/etc/puppetlabs/puppet/ssl/public_keys/pe-internal-mcollective-servers.pem]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:20:46,967 - [Notice]: /Stage[main]/Pe_install::Install::Ssldir/File[/etc/puppetlabs/puppet/ssl/public_keys/pe-internal-peadmin-mcollective-client.pem]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:20:46,973 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Config/File[/etc/puppetlabs/activemq/activemq.xml]/group: group changed 'root' to 'pe-activemq'
==> puppet.demo: 2017-02-02 22:20:46,973 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Config/File[/etc/puppetlabs/activemq/activemq.xml]/mode: mode changed '0755' to '0640'
==> puppet.demo: 2017-02-02 22:20:46,983 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Config/File[/etc/puppetlabs/activemq/jetty.xml]/group: group changed 'root' to 'pe-activemq'
==> puppet.demo: 2017-02-02 22:20:46,983 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Config/File[/etc/puppetlabs/activemq/jetty.xml]/mode: mode changed '0755' to '0640'
==> puppet.demo: 2017-02-02 22:20:46,987 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Config/File[/etc/puppetlabs/activemq/log4j.properties]/group: group changed 'root' to 'pe-activemq'
==> puppet.demo: 2017-02-02 22:20:46,988 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Config/File[/etc/puppetlabs/activemq/log4j.properties]/mode: mode changed '0755' to '0640'
==> puppet.demo: 2017-02-02 22:20:46,993 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Config/File[/etc/puppetlabs/activemq/jetty-realm.properties]/group: group changed 'root' to 'pe-activemq'
==> puppet.demo: 2017-02-02 22:20:47,496 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Certs/Pe_java_ks[puppetca:truststore]/ensure: created
==> puppet.demo: 2017-02-02 22:20:47,502 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/File[/etc/mcollective]/ensure: created
==> puppet.demo: 2017-02-02 22:20:47,680 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective]/ensure: created
==> puppet.demo: 2017-02-02 22:20:47,683 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/agent]/ensure: created
==> puppet.demo: 2017-02-02 22:20:47,689 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/agent/package.ddl]/ensure: defined content as '{md5}ae1d49824b9b84d1a8f617c317147bea'
==> puppet.demo: 2017-02-02 22:20:47,694 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/agent/package.rb]/ensure: defined content as '{md5}60d4b37d3844fc379a99d2b17a243620'
==> puppet.demo: 2017-02-02 22:20:47,699 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/agent/puppet.ddl]/ensure: defined content as '{md5}69e63795545712fd9e3d75ea1ae1d1d4'
==> puppet.demo: 2017-02-02 22:20:47,705 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/agent/puppet.rb]/ensure: defined content as '{md5}8f4839ea11e4c4911e531f77f94b033b'
==> puppet.demo: 2017-02-02 22:20:47,711 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/agent/puppetral.ddl]/ensure: defined content as '{md5}7f06f13953847e60818a681c1f2f168b'
==> puppet.demo: 2017-02-02 22:20:47,718 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/agent/puppetral.rb]/ensure: defined content as '{md5}686272ee73d966e3f1d3482d7d7b61a8'
==> puppet.demo: 2017-02-02 22:20:47,722 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/agent/service.ddl]/ensure: defined content as '{md5}3471e24142773d1bb7769c250e6b63d3'
==> puppet.demo: 2017-02-02 22:20:47,727 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/agent/service.rb]/ensure: defined content as '{md5}cbf84ed615eeda9789650b05ec504566'
==> puppet.demo: 2017-02-02 22:20:47,734 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/aggregate]/ensure: created
==> puppet.demo: 2017-02-02 22:20:47,741 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/aggregate/boolean_summary.ddl]/ensure: defined content as '{md5}aa581c71a6c7658bffdbaec81590f65d'
==> puppet.demo: 2017-02-02 22:20:47,748 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/aggregate/boolean_summary.rb]/ensure: defined content as '{md5}0546063313508d8aff603be320af3c44'
==> puppet.demo: 2017-02-02 22:20:47,753 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/application]/ensure: created
==> puppet.demo: 2017-02-02 22:20:47,758 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/application/package.rb]/ensure: defined content as '{md5}4e6571cdac3f6aa322c9f195693e1dbe'
==> puppet.demo: 2017-02-02 22:20:47,767 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/application/puppet.rb]/ensure: defined content as '{md5}e8085d91ddaa1f92984bde5d34cc47d5'
==> puppet.demo: 2017-02-02 22:20:47,772 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/application/service.rb]/ensure: defined content as '{md5}c95359f947af5f0d904fa3df80cb9820'
==> puppet.demo: 2017-02-02 22:20:47,777 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/data]/ensure: created
==> puppet.demo: 2017-02-02 22:20:47,785 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/data/puppet_data.ddl]/ensure: defined content as '{md5}5c9912bf5ae5dbc8762109a40c027c63'
==> puppet.demo: 2017-02-02 22:20:47,790 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/data/puppet_data.rb]/ensure: defined content as '{md5}606e87cd509addf22dd8e93d503d8262'
==> puppet.demo: 2017-02-02 22:20:47,800 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/data/resource_data.ddl]/ensure: defined content as '{md5}c4e3a46fd3c0b5d3990db0b8af1c747f'
==> puppet.demo: 2017-02-02 22:20:47,805 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/data/resource_data.rb]/ensure: defined content as '{md5}49be769fb403191af41f1b89697ce4cc'
==> puppet.demo: 2017-02-02 22:20:47,812 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/data/service_data.ddl]/ensure: defined content as '{md5}e7f7e0bc65ede56fc636505a400b1700'
==> puppet.demo: 2017-02-02 22:20:47,902 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/data/service_data.rb]/ensure: defined content as '{md5}bc651898c7dcd373d609c933fbd6021f'
==> puppet.demo: 2017-02-02 22:20:47,907 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/mco_plugin_versions]/ensure: defined content as '{md5}c96b3a9206e43f8c3a0550731dd3b739'
==> puppet.demo: 2017-02-02 22:20:47,910 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/registration]/ensure: created
==> puppet.demo: 2017-02-02 22:20:47,916 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/registration/meta.rb]/ensure: defined content as '{md5}e939958bbbc0817e1779c336037e1849'
==> puppet.demo: 2017-02-02 22:20:47,919 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/security]/ensure: created
==> puppet.demo: 2017-02-02 22:20:47,927 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/security/sshkey.ddl]/ensure: defined content as '{md5}e92b26732d03496fb61ad3a1ed623f56'
==> puppet.demo: 2017-02-02 22:20:47,934 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/security/sshkey.rb]/ensure: defined content as '{md5}c3933bda744b78dd857f20aa5b61f75b'
==> puppet.demo: 2017-02-02 22:20:47,938 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util]/ensure: created
==> puppet.demo: 2017-02-02 22:20:47,943 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/actionpolicy.rb]/ensure: defined content as '{md5}e4d6a7024ad7b28e019e7b9931eac027'
==> puppet.demo: 2017-02-02 22:20:47,951 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/package]/ensure: created
==> puppet.demo: 2017-02-02 22:20:47,956 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/package/base.rb]/ensure: defined content as '{md5}1bdb7e7a6dcfea6fd2a06c5dc39b7276'
==> puppet.demo: 2017-02-02 22:20:47,965 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/package/packagehelpers.rb]/ensure: defined content as '{md5}312aecc3b1ee75f97a989fea3e7a221d'
==> puppet.demo: 2017-02-02 22:20:47,972 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/package/puppetpackage.rb]/ensure: defined content as '{md5}865eec36ae05c30b072d3f5bd871fb52'
==> puppet.demo: 2017-02-02 22:20:47,977 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/package/yumHelper.py]/ensure: defined content as '{md5}40fa99ef10b84c38517f6b695a0af533'
==> puppet.demo: 2017-02-02 22:20:47,987 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/package/yumpackage.rb]/ensure: defined content as '{md5}256bde1567d8794ca929092462f5ae03'
==> puppet.demo: 2017-02-02 22:20:47,990 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/puppet_agent_mgr]/ensure: created
==> puppet.demo: 2017-02-02 22:20:47,998 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/puppet_agent_mgr.rb]/ensure: defined content as '{md5}4dbafcaa02334c2d76665cd23ca29688'
==> puppet.demo: 2017-02-02 22:20:48,006 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/puppet_agent_mgr/mgr_v2.rb]/ensure: defined content as '{md5}9a00171022ddb12d0a463e9cefeba481'
==> puppet.demo: 2017-02-02 22:20:48,015 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/puppet_agent_mgr/mgr_v3.rb]/ensure: defined content as '{md5}b5cb1a9b7311fc3769a3ccaabadeb694'
==> puppet.demo: 2017-02-02 22:20:48,021 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/puppet_agent_mgr/mgr_windows.rb]/ensure: defined content as '{md5}79a6cf3dac0177f6b9c22d5085324676'
==> puppet.demo: 2017-02-02 22:20:48,027 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/puppet_server_address_validation.rb]/ensure: defined content as '{md5}1c78390e33e71773e121a902ae91bfd4'
==> puppet.demo: 2017-02-02 22:20:48,037 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/puppetrunner.rb]/ensure: defined content as '{md5}a4fade81457455fbca9370249defbdf1'
==> puppet.demo: 2017-02-02 22:20:48,043 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/service]/ensure: created
==> puppet.demo: 2017-02-02 22:20:48,053 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/service/base.rb]/ensure: defined content as '{md5}abea7b8fadbf3425a7b68b49b9435ff6'
==> puppet.demo: 2017-02-02 22:20:48,059 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/util/service/puppetservice.rb]/ensure: defined content as '{md5}905db93e1c06ad5a7154fa2f9199f31c'
==> puppet.demo: 2017-02-02 22:20:48,063 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/validator]/ensure: created
==> puppet.demo: 2017-02-02 22:20:48,073 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/validator/puppet_resource_validator.ddl]/ensure: defined content as '{md5}3e45a28e1ba6c8d22ce40934c04b30b4'
==> puppet.demo: 2017-02-02 22:20:48,085 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/validator/puppet_resource_validator.rb]/ensure: defined content as '{md5}567c7dc4d70ed0db7fd2626c77f6df41'
==> puppet.demo: 2017-02-02 22:20:48,090 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/validator/puppet_server_address_validator.ddl]/ensure: defined content as '{md5}323e0b9647639fdf32cfbc63a82860f7'
==> puppet.demo: 2017-02-02 22:20:48,099 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/validator/puppet_server_address_validator.rb]/ensure: defined content as '{md5}e84a56187809c5181b78b2819ee149fe'
==> puppet.demo: 2017-02-02 22:20:48,109 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/validator/puppet_tags_validator.ddl]/ensure: defined content as '{md5}7ed95b2e5b210db83d12d5034f1ecb0f'
==> puppet.demo: 2017-02-02 22:20:48,119 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/validator/puppet_tags_validator.rb]/ensure: defined content as '{md5}40b29498e867ba2ecf21dc08bc457d4e'
==> puppet.demo: 2017-02-02 22:20:48,124 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/validator/puppet_variable_validator.ddl]/ensure: defined content as '{md5}58c9db4ca4503e4d692a016743e01627'
==> puppet.demo: 2017-02-02 22:20:48,130 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/validator/puppet_variable_validator.rb]/ensure: defined content as '{md5}3cbca3af2e5884f2a807ef005a87151b'
==> puppet.demo: 2017-02-02 22:20:48,136 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/validator/service_name.ddl]/ensure: defined content as '{md5}2812afa15108103042f706c2201e286b'
==> puppet.demo: 2017-02-02 22:20:48,141 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Plugins/File[/opt/puppetlabs/mcollective/plugins/mcollective/validator/service_name.rb]/ensure: defined content as '{md5}3f501a9ed252ce2dfe06a2e1e53845ab'
==> puppet.demo: 2017-02-02 22:20:48,158 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Logs/File[/var/log/puppetlabs/mcollective.log]/ensure: created
==> puppet.demo: 2017-02-02 22:20:48,170 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Logs/File[/var/log/puppetlabs/mcollective-audit.log]/ensure: created
==> puppet.demo: 2017-02-02 22:20:48,174 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl]/ensure: created
==> puppet.demo: 2017-02-02 22:20:48,181 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/clients]/ensure: created
==> puppet.demo: 2017-02-02 22:20:48,191 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/ca.cert.pem]/ensure: defined content as '{md5}b3e804f6bb0b1ef28a7d5ea46c3ae1cc'
==> puppet.demo: 2017-02-02 22:20:48,202 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/puppet.demo.cert.pem]/ensure: defined content as '{md5}56d99eabb442b5f760c2d3954322db17'
==> puppet.demo: 2017-02-02 22:20:48,208 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/puppet.demo.private_key.pem]/ensure: defined content as '{md5}9d42b8c175ca315355d5e424c00d7523'
==> puppet.demo: 2017-02-02 22:20:48,215 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/mcollective-private.pem]/ensure: defined content as '{md5}d41d8cd98f00b204e9800998ecf8427e'
==> puppet.demo: 2017-02-02 22:20:48,222 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/mcollective-public.pem]/ensure: defined content as '{md5}d41d8cd98f00b204e9800998ecf8427e'
==> puppet.demo: 2017-02-02 22:20:48,227 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/clients/puppet-dashboard-public.pem]/ensure: defined content as '{md5}d41d8cd98f00b204e9800998ecf8427e'
==> puppet.demo: 2017-02-02 22:20:48,235 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/clients/peadmin-public.pem]/ensure: defined content as '{md5}d41d8cd98f00b204e9800998ecf8427e'
==> puppet.demo: 2017-02-02 22:20:48,241 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Facter/File[/opt/puppetlabs/puppet/bin/refresh-mcollective-metadata]/ensure: defined content as '{md5}6daa27a4146a20dea32f525f725563a1'
==> puppet.demo: 2017-02-02 22:20:49,043 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Facter/Exec[bootstrap mcollective metadata]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:20:49,064 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Facter/Cron[pe-mcollective-metadata]/ensure: created
==> puppet.demo: 2017-02-02 22:20:49,081 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server::Facter/File[/etc/puppetlabs/mcollective/facts-bootstrapped]/ensure: created
==> puppet.demo: 2017-02-02 22:20:49,087 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server/File[/etc/puppetlabs/mcollective/server.cfg]/content: content changed '{md5}73e68cfd79153a49de6f5721ab60657b' to '{md5}f85269d2bc879636410916d7ed59b8f2'
==> puppet.demo: 2017-02-02 22:20:49,088 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Server/File[/etc/puppetlabs/mcollective/server.cfg]/mode: mode changed '0644' to '0660'
==> puppet.demo: 2017-02-02 22:20:49,518 - [Notice]: /Stage[main]/Puppet_enterprise::Mcollective::Service/Service[mcollective]/ensure: ensure changed 'stopped' to 'running'
==> puppet.demo: 2017-02-02 22:20:49,522 - [Notice]: /Stage[main]/Pe_repo/File[/opt/puppetlabs/server/data/packages]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:20:49,526 - [Notice]: /Stage[main]/Pe_repo/File[/opt/puppetlabs/server/data/packages/public]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:20:49,528 - [Notice]: /Stage[main]/Pe_repo/File[/opt/puppetlabs/server/data/packages/public/GPG-KEY-puppetlabs]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:20:49,531 - [Notice]: /Stage[main]/Pe_repo/File[/opt/puppetlabs/server/data/packages/public/GPG-KEY-puppet]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:20:49,538 - [Notice]: /Stage[main]/Pe_install::Install/File[/etc/puppetlabs/mcollective/credentials]/ensure: defined content as '{md5}07180e811daf0e5a0343f29f15fb0775'
==> puppet.demo: 2017-02-02 22:20:52,004 - [Notice]: /Stage[main]/Pe_postgresql::Client/Package[postgresql-client]/ensure: created
==> puppet.demo: 2017-02-02 22:20:52,009 - [Notice]: /Stage[main]/Pe_postgresql::Client/File[/opt/puppetlabs/server/bin/validate_postgresql_connection.sh]/ensure: defined content as '{md5}20301932819f035492a30880f5bf335a'
==> puppet.demo: 2017-02-02 22:20:53,569 - [Notice]: /Stage[main]/Pe_postgresql::Server::Install/Package[postgresql-server]/ensure: created
==> puppet.demo: 2017-02-02 22:20:54,371 - [Notice]: /Stage[main]/Puppet_enterprise::Packages/Package[pe-postgresql-pglogical]/ensure: created
==> puppet.demo: 2017-02-02 22:20:54,373 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/File[/opt/puppetlabs/server/data/postgresql]/mode: mode changed '0700' to '0755'
==> puppet.demo: 2017-02-02 22:20:54,376 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/File[/opt/puppetlabs/server/data/postgresql/9.4]/mode: mode changed '0700' to '0755'
==> puppet.demo: 2017-02-02 22:20:55,162 - [Notice]: /Stage[main]/Pe_postgresql::Server::Contrib/Package[postgresql-contrib]/ensure: created
==> puppet.demo: 2017-02-02 22:20:57,138 - [Notice]: /Stage[main]/Pe_postgresql::Server::Initdb/Exec[postgresql_initdb]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:20:57,144 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/File[/opt/puppetlabs/server/data/postgresql/9.4/data/certs]/ensure: created
==> puppet.demo: 2017-02-02 22:20:57,151 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/File[/opt/puppetlabs/server/data/postgresql/9.4/data/certs/_local.cert.pem]/ensure: defined content as '{md5}56d99eabb442b5f760c2d3954322db17'
==> puppet.demo: 2017-02-02 22:20:57,158 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/File[/opt/puppetlabs/server/data/postgresql/9.4/data/certs/_local.private_key.pem]/ensure: defined content as '{md5}9d42b8c175ca315355d5e424c00d7523'
==> puppet.demo: 2017-02-02 22:20:57,170 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Pe_ini_setting[pe-console-services initconf java_bin]/ensure: created
==> puppet.demo: 2017-02-02 22:20:57,173 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Pe_ini_setting[pe-console-services initconf user]/ensure: created
==> puppet.demo: 2017-02-02 22:20:57,175 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Pe_ini_setting[pe-console-services initconf group]/ensure: created
==> puppet.demo: 2017-02-02 22:20:57,177 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Pe_ini_setting[pe-console-services initconf install_dir]/ensure: created
==> puppet.demo: 2017-02-02 22:20:57,180 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Pe_ini_setting[pe-console-services initconf config]/ensure: created
==> puppet.demo: 2017-02-02 22:20:57,183 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Pe_ini_setting[pe-console-services initconf bootstrap_config]/ensure: created
==> puppet.demo: 2017-02-02 22:20:57,185 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Pe_ini_setting[pe-console-services initconf service_stop_retries]/ensure: created
==> puppet.demo: 2017-02-02 22:20:57,194 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Pe_ini_setting[pe-console-services initconf start_timeout]/ensure: created
==> puppet.demo: 2017-02-02 22:20:58,230 - [Notice]: /Stage[main]/Pe_nginx/Package[pe-nginx]/ensure: created
==> puppet.demo: 2017-02-02 22:20:58,238 - [Notice]: /Stage[main]/Puppet_enterprise::Pxp_agent/File[/etc/puppetlabs/pxp-agent/pxp-agent.conf]/ensure: defined content as '{md5}97d63c2fee052fa26a83fbe00754a140'
==> puppet.demo: 2017-02-02 22:20:58,454 - [Notice]: /Stage[main]/Puppet_enterprise::Pxp_agent::Service/Service[pxp-agent]/ensure: ensure changed 'stopped' to 'running'
==> puppet.demo: 2017-02-02 22:20:58,827 - [Notice]: /Stage[main]/Pe_install::Install/Service[puppet]/ensure: ensure changed 'stopped' to 'running'
==> puppet.demo: 2017-02-02 22:20:59,090 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_puppet_authorization::Rule[puppetlabs environment cache]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs environment cache]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,244 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Pe_puppet_authorization::Rule[puppetlabs jruby pool]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs jruby pool]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,246 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Java_args[puppetserver]/Pe_ini_subsetting[pe-puppetserver_'Xmx']/value: value changed '2g' to '2048m'
==> puppet.demo: 2017-02-02 22:20:59,255 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Java_args[puppetserver]/Pe_ini_subsetting[pe-puppetserver_'Xms']/value: value changed '2g' to '2048m'
==> puppet.demo: 2017-02-02 22:20:59,701 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Config/Puppet_enterprise::Amq::Config::Beans[puppet.demo - beans]/Augeas[amq_augeas_base_beans_config]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:20:59,712 - [Notice]: /Stage[main]/Pe_concat::Setup/File[/opt/puppetlabs/puppet/cache/pe_concat]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,715 - [Notice]: /Stage[main]/Pe_concat::Setup/File[/opt/puppetlabs/puppet/cache/pe_concat/bin]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,722 - [Notice]: /Stage[main]/Pe_concat::Setup/File[/opt/puppetlabs/puppet/cache/pe_concat/bin/concatfragments.sh]/ensure: defined content as '{md5}7bbe7c5fce25a5ddd20415d909ba44fc'
==> puppet.demo: 2017-02-02 22:20:59,728 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,738 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,743 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments.concat]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,746 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments.concat.out]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,752 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_postgresql::Server::Config_entry[listen_addresses]/Pe_postgresql_conf[listen_addresses]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,769 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_postgresql::Server::Config_entry[port]/File[systemd-port-override]/ensure: defined content as '{md5}44acf83b25ea47e5bddcc103e0b05661'
==> puppet.demo: 2017-02-02 22:20:59,838 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_postgresql::Server::Config_entry[port]/Exec[restart-systemd]: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:20:59,841 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_postgresql::Server::Config_entry[port]/Pe_postgresql_conf[port]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,845 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[ssl]/Pe_postgresql_conf[ssl]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,849 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[ssl_cert_file]/Pe_postgresql_conf[ssl_cert_file]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,854 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[ssl_key_file]/Pe_postgresql_conf[ssl_key_file]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,859 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[ssl_ca_file]/Pe_postgresql_conf[ssl_ca_file]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,864 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[effective_cache_size]/Pe_postgresql_conf[effective_cache_size]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,869 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[shared_buffers]/Pe_postgresql_conf[shared_buffers]/value: value changed '128MB' to '1336MB'
==> puppet.demo: 2017-02-02 22:20:59,877 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[maintenance_work_mem]/Pe_postgresql_conf[maintenance_work_mem]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,885 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[wal_buffers]/Pe_postgresql_conf[wal_buffers]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,894 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[work_mem]/Pe_postgresql_conf[work_mem]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,899 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[checkpoint_segments]/Pe_postgresql_conf[checkpoint_segments]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,906 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[log_line_prefix]/Pe_postgresql_conf[log_line_prefix]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,914 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[log_min_duration_statement]/Pe_postgresql_conf[log_min_duration_statement]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,921 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[max_connections]/Pe_postgresql_conf[max_connections]/value: value changed '100' to '200'
==> puppet.demo: 2017-02-02 22:20:59,931 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[autovacuum_vacuum_scale_factor]/Pe_postgresql_conf[autovacuum_vacuum_scale_factor]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,935 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[autovacuum_analyze_scale_factor]/Pe_postgresql_conf[autovacuum_analyze_scale_factor]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,940 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[wal_level]/Pe_postgresql_conf[wal_level]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,946 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[max_worker_processes]/Pe_postgresql_conf[max_worker_processes]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,953 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[max_replication_slots]/Pe_postgresql_conf[max_replication_slots]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,962 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[max_wal_senders]/Pe_postgresql_conf[max_wal_senders]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,967 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Config_entry[shared_preload_libraries]/Pe_postgresql_conf[shared_preload_libraries]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,977 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,993 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments]/ensure: created
==> puppet.demo: 2017-02-02 22:20:59,997 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments.concat]/ensure: created
==> puppet.demo: 2017-02-02 22:21:00,000 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments.concat.out]/ensure: created
==> puppet.demo: 2017-02-02 22:21:00,061 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy::Nginx_conf/Pe_nginx::Directive[gzip]/Augeas[pe_nginx::directive for gzip]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:00,114 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy::Nginx_conf/Pe_nginx::Directive[gzip_comp_level]/Augeas[pe_nginx::directive for gzip_comp_level]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:00,172 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy::Nginx_conf/Pe_nginx::Directive[gzip_min_length]/Augeas[pe_nginx::directive for gzip_min_length]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:00,232 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy::Nginx_conf/Pe_nginx::Directive[gzip_proxied]/Augeas[pe_nginx::directive for gzip_proxied]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:00,281 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy::Nginx_conf/Pe_nginx::Directive[gzip_vary]/Augeas[pe_nginx::directive for gzip_vary]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:00,332 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy::Nginx_conf/Pe_nginx::Directive[gzip_types]/Augeas[pe_nginx::directive for gzip_types]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:00,339 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/Pe_concat[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_conf.d_auth.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:21:00,346 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/Pe_concat[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_conf.d_auth.conf/fragments]/ensure: created
==> puppet.demo: 2017-02-02 22:21:00,349 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/Pe_concat[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_conf.d_auth.conf/fragments.concat]/ensure: created
==> puppet.demo: 2017-02-02 22:21:00,352 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/Pe_concat[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_conf.d_auth.conf/fragments.concat.out]/ensure: created
==> puppet.demo: 2017-02-02 22:21:00,360 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/Pe_concat::Fragment[00_header_/etc/puppetlabs/puppetserver/conf.d/auth.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_conf.d_auth.conf/fragments/10_00_header__etc_puppetlabs_puppetserver_conf.d_auth.conf]/ensure: defined content as '{md5}98e633f69129801e017d35bad880f8be'
==> puppet.demo: 2017-02-02 22:21:00,367 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/Pe_concat::Fragment[99_footer_/etc/puppetlabs/puppetserver/conf.d/auth.conf]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_conf.d_auth.conf/fragments/10_99_footer__etc_puppetlabs_puppetserver_conf.d_auth.conf]/ensure: defined content as '{md5}7d9d25f71cb8a5aba86202540a20d405'
==> puppet.demo: 2017-02-02 22:21:00,415 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/Pe_concat[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/Exec[pe_concat_/etc/puppetlabs/puppetserver/conf.d/auth.conf]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:00,441 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/Pe_concat[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/Exec[pe_concat_/etc/puppetlabs/puppetserver/conf.d/auth.conf]: Triggered 'refresh' from 4 events
==> puppet.demo: 2017-02-02 22:21:00,519 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization[/etc/puppetlabs/puppetserver/conf.d/auth.conf]/Pe_hocon_setting[authorization.allow-header-cert-info./etc/puppetlabs/puppetserver/conf.d/auth.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:21:00,619 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs catalog]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs catalog]/ensure: created
==> puppet.demo: 2017-02-02 22:21:00,716 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs certificate]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs certificate]/ensure: created
==> puppet.demo: 2017-02-02 22:21:00,808 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs crl]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs crl]/ensure: created
==> puppet.demo: 2017-02-02 22:21:00,891 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs csr]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs csr]/ensure: created
==> puppet.demo: 2017-02-02 22:21:00,959 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs environments]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs environments]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,031 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs environment]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs environment]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,121 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs environment classes]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs environment classes]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,208 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs file]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs file]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,289 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs node]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs node]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,383 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs report]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs report]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,468 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs resource type]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs resource type]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,559 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs status]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs status]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,659 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs static file content]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs static file content]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,758 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs experimental]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs experimental]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,870 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Tk_authz/Pe_puppet_authorization::Rule[puppetlabs deny all]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs deny all]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,877 - [Notice]: /Stage[main]/Pe_repo::Platform::El_7_x86_64/Pe_repo::El[el-7-x86_64]/Pe_repo::Repo[el-7-x86_64 2016.5.1]/File[/opt/puppetlabs/server/data/packages/public/2016.5.1]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:21:01,884 - [Notice]: /Stage[main]/Pe_repo/File[/opt/puppetlabs/server/data/packages/public/current]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,890 - [Notice]: /Stage[main]/Pe_repo::Platform::El_7_x86_64/Pe_repo::El[el-7-x86_64]/File[/opt/puppetlabs/server/data/packages/public/2016.5.1/el-7-x86_64.repo]/ensure: defined content as '{md5}f46726f3ca16301b939785c8ee0892dd'
==> puppet.demo: 2017-02-02 22:21:01,897 - [Notice]: /Stage[main]/Pe_repo::Platform::El_7_x86_64/Pe_repo::El[el-7-x86_64]/File[/opt/puppetlabs/server/data/packages/public/2016.5.1/el-7-x86_64.bash]/ensure: defined content as '{md5}df1c66cad4c9e1efab4898ef13a8e694'
==> puppet.demo: 2017-02-02 22:21:01,900 - [Notice]: /Stage[main]/Pe_repo::Platform::El_7_x86_64/Pe_repo::El[el-7-x86_64]/Pe_repo::Repo[el-7-x86_64 2016.5.1]/File[/opt/puppetlabs/server/data/packages/public/2016.5.1/el-7-x86_64-1.8.2]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:21:01,916 - [Notice]: /Stage[main]/Pe_repo::Platform::El_7_x86_64/Pe_repo::El[el-7-x86_64]/Pe_repo::Repo[el-7-x86_64 2016.5.1]/File[/opt/puppetlabs/server/data/packages/public/2016.5.1/install.bash]/ensure: defined content as '{md5}0ab27fd6e539f12be1bb3ecb23b14f98'
==> puppet.demo: 2017-02-02 22:21:01,922 - [Notice]: /Stage[main]/Pe_repo::Platform::El_7_x86_64/Pe_repo::El[el-7-x86_64]/Pe_repo::Repo[el-7-x86_64 2016.5.1]/File[/opt/puppetlabs/server/data/packages/public/2016.5.1/upgrade.bash]/ensure: defined content as '{md5}c4f6d0406c58a69b0583ee2d51957c8d'
==> puppet.demo: 2017-02-02 22:21:01,926 - [Notice]: /Stage[main]/Pe_repo::Platform::El_7_x86_64/Pe_repo::El[el-7-x86_64]/Pe_repo::Repo[el-7-x86_64 2016.5.1]/File[/opt/puppetlabs/server/data/packages/public/2016.5.1/el-7-x86_64]/ensure: created
==> puppet.demo: 2017-02-02 22:21:01,937 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_postgresql::Server::Pg_hba_rule[local access as postgres user]/Pe_concat::Fragment[pg_hba_rule_local access as postgres user]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/001_pg_hba_rule_local access as postgres user]/ensure: defined content as '{md5}216a85d405b5b1e39d4962c0d20694c4'
==> puppet.demo: 2017-02-02 22:21:01,945 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_postgresql::Server::Pg_hba_rule[local access to database with same name]/Pe_concat::Fragment[pg_hba_rule_local access to database with same name]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/002_pg_hba_rule_local access to database with same name]/ensure: defined content as '{md5}61275db6b21adbf53b575d4c1a6bbed1'
==> puppet.demo: 2017-02-02 22:21:01,954 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_postgresql::Server::Pg_hba_rule[allow localhost TCP access to postgresql user]/Pe_concat::Fragment[pg_hba_rule_allow localhost TCP access to postgresql user]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/003_pg_hba_rule_allow localhost TCP access to postgresql user]/ensure: defined content as '{md5}d504bd93c9636e8a53e3ed10f0afa28e'
==> puppet.demo: 2017-02-02 22:21:01,960 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_postgresql::Server::Pg_hba_rule[deny access to postgresql user]/Pe_concat::Fragment[pg_hba_rule_deny access to postgresql user]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/004_pg_hba_rule_deny access to postgresql user]/ensure: defined content as '{md5}d2edb0a2e42bbe0e8fb624dc25e7c4fe'
==> puppet.demo: 2017-02-02 22:21:01,972 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_postgresql::Server::Pg_hba_rule[allow access to all users]/Pe_concat::Fragment[pg_hba_rule_allow access to all users]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/100_pg_hba_rule_allow access to all users]/ensure: defined content as '{md5}6332aa580d0a4d80f31f6ce365b93c92'
==> puppet.demo: 2017-02-02 22:21:01,983 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_postgresql::Server::Pg_hba_rule[allow access to ipv6 localhost]/Pe_concat::Fragment[pg_hba_rule_allow access to ipv6 localhost]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/101_pg_hba_rule_allow access to ipv6 localhost]/ensure: defined content as '{md5}ab588822a007943223faadf86be3044a'
==> puppet.demo: 2017-02-02 22:21:01,991 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Pg_hba_rule[allow access to all ipv6]/Pe_concat::Fragment[pg_hba_rule_allow access to all ipv6]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/2_pg_hba_rule_allow access to all ipv6]/ensure: defined content as '{md5}acc79b0cc1fbfeccb28169438e588dae'
==> puppet.demo: 2017-02-02 22:21:02,043 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::User[peadmin]/Pe_accounts::User[peadmin]/Group[peadmin]/ensure: created
==> puppet.demo: 2017-02-02 22:21:02,071 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::User[peadmin]/Pe_accounts::User[peadmin]/User[peadmin]/ensure: created
==> puppet.demo: 2017-02-02 22:21:02,084 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/File[/etc/puppetlabs/mcollective/client.cfg]/ensure: removed
==> puppet.demo: 2017-02-02 22:21:02,098 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::User[peadmin]/Pe_accounts::User[peadmin]/Pe_accounts::Home_dir[/var/lib/peadmin]/File[/var/lib/peadmin]/ensure: created
==> puppet.demo: 2017-02-02 22:21:02,107 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/File[/var/lib/peadmin/.mcollective]/ensure: defined content as '{md5}1394c166f62782d902777d07b3cf95e9'
==> puppet.demo: 2017-02-02 22:21:02,113 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::User[peadmin]/File[/var/lib/peadmin/.bashrc.custom]/ensure: created
==> puppet.demo: 2017-02-02 22:21:02,115 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::User[peadmin]/Pe_file_line[peadmin:path]/ensure: created
==> puppet.demo: 2017-02-02 22:21:02,119 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::Certs[peadmin]/File[/var/lib/peadmin/.mcollective.d]/ensure: created
==> puppet.demo: 2017-02-02 22:21:02,123 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/File[/var/lib/peadmin/.mcollective.d/client.log]/ensure: created
==> puppet.demo: 2017-02-02 22:21:02,135 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::Certs[peadmin]/File[/var/lib/peadmin/.mcollective.d/ca.cert.pem]/ensure: defined content as '{md5}b3e804f6bb0b1ef28a7d5ea46c3ae1cc'
==> puppet.demo: 2017-02-02 22:21:02,142 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::Certs[peadmin]/File[/var/lib/peadmin/.mcollective.d/puppet.demo.cert.pem]/ensure: defined content as '{md5}56d99eabb442b5f760c2d3954322db17'
==> puppet.demo: 2017-02-02 22:21:02,155 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::Certs[peadmin]/File[/var/lib/peadmin/.mcollective.d/puppet.demo.private_key.pem]/ensure: defined content as '{md5}9d42b8c175ca315355d5e424c00d7523'
==> puppet.demo: 2017-02-02 22:21:02,160 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::Certs[peadmin]/File[/var/lib/peadmin/.mcollective.d/peadmin-private.pem]/ensure: defined content as '{md5}d41d8cd98f00b204e9800998ecf8427e'
==> puppet.demo: 2017-02-02 22:21:02,171 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::Certs[peadmin]/File[/var/lib/peadmin/.mcollective.d/peadmin-public.pem]/ensure: defined content as '{md5}d41d8cd98f00b204e9800998ecf8427e'
==> puppet.demo: 2017-02-02 22:21:02,178 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::Certs[peadmin]/File[/var/lib/peadmin/.mcollective.d/mcollective-public.pem]/ensure: defined content as '{md5}d41d8cd98f00b204e9800998ecf8427e'
==> puppet.demo: 2017-02-02 22:21:02,186 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::User[peadmin]/Pe_accounts::User[peadmin]/Pe_accounts::Home_dir[/var/lib/peadmin]/File[/var/lib/peadmin/.ssh]/ensure: created
==> puppet.demo: 2017-02-02 22:21:02,191 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::User[peadmin]/Pe_accounts::User[peadmin]/Pe_accounts::Home_dir[/var/lib/peadmin]/File[/var/lib/peadmin/.vim]/ensure: created
==> puppet.demo: 2017-02-02 22:21:02,203 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::User[peadmin]/Pe_accounts::User[peadmin]/Pe_accounts::Home_dir[/var/lib/peadmin]/File[/var/lib/peadmin/.bashrc]/ensure: defined content as '{md5}776e5327b6b492e2b49f84a41f6f68dd'
==> puppet.demo: 2017-02-02 22:21:02,216 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::User[peadmin]/Pe_accounts::User[peadmin]/Pe_accounts::Home_dir[/var/lib/peadmin]/File[/var/lib/peadmin/.bash_profile]/ensure: defined content as '{md5}546be8ec0dfc6a62ceb331a4430f30f5'
==> puppet.demo: 2017-02-02 22:21:02,225 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::User[peadmin]/Pe_accounts::User[peadmin]/Pe_accounts::Home_dir[/var/lib/peadmin]/File[/var/lib/peadmin/.ssh/authorized_keys]/ensure: created
==> puppet.demo: 2017-02-02 22:21:02,237 - [Notice]: /Stage[main]/Pe_staging/File[/opt/puppetlabs/server/data/staging]/ensure: created
==> puppet.demo: 2017-02-02 22:21:02,242 - [Notice]: /Stage[main]/Pe_repo::Platform::El_7_x86_64/Pe_repo::El[el-7-x86_64]/Pe_repo::Repo[el-7-x86_64 2016.5.1]/File[/opt/puppetlabs/server/data/staging/pe_repo-puppet-agent-1.8.2]/ensure: created
==> puppet.demo: 2017-02-02 22:21:02,269 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-puppetdb as pe-puppetdb]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-puppetdb as pe-puppetdb (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-puppetdb as pe-puppetdb (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-puppetdb as pe-puppetdb (ipv4)]/ensure: defined content as '{md5}0d9788b7dbfc836fc21700cc4ac4de3b'
==> puppet.demo: 2017-02-02 22:21:02,277 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-puppetdb as pe-puppetdb]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-puppetdb as pe-puppetdb (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-puppetdb as pe-puppetdb (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-puppetdb as pe-puppetdb (ipv6)]/ensure: defined content as '{md5}c898da577afc5966935caedd0249eea4'
==> puppet.demo: 2017-02-02 22:21:02,288 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-puppetdb as pe-puppetdb]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-puppetdb as pe-puppetdb]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-puppetdb as pe-puppetdb ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-puppetdb as pe-puppetdb ident rule fragment]/ensure: defined content as '{md5}0fb33e5624c01642809ee6cbf027fde7'
==> puppet.demo: 2017-02-02 22:21:02,301 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-classifier as pe-classifier]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-classifier as pe-classifier (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-classifier as pe-classifier (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-classifier as pe-classifier (ipv4)]/ensure: defined content as '{md5}74cc31625cba2c52e403991f0eaf390c'
==> puppet.demo: 2017-02-02 22:21:02,308 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-classifier as pe-classifier]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-classifier as pe-classifier (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-classifier as pe-classifier (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-classifier as pe-classifier (ipv6)]/ensure: defined content as '{md5}0df3ccac1e610dece219760b5444f038'
==> puppet.demo: 2017-02-02 22:21:02,316 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-classifier as pe-classifier]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-classifier as pe-classifier]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-classifier as pe-classifier ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-classifier as pe-classifier ident rule fragment]/ensure: defined content as '{md5}3122dd7ec2a79949f9f34d58984ec9a4'
==> puppet.demo: 2017-02-02 22:21:02,326 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-classifier as pe-classifier-read]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-classifier as pe-classifier-read (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-classifier as pe-classifier-read (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-classifier as pe-classifier-read (ipv4)]/ensure: defined content as '{md5}9286ffe61d93f0bdf0740317162afae1'
==> puppet.demo: 2017-02-02 22:21:02,337 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-classifier as pe-classifier-read]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-classifier as pe-classifier-read (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-classifier as pe-classifier-read (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-classifier as pe-classifier-read (ipv6)]/ensure: defined content as '{md5}7306117a9cce91892bc076e7152877cf'
==> puppet.demo: 2017-02-02 22:21:02,344 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-classifier as pe-classifier-read]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-classifier as pe-classifier-read]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-classifier as pe-classifier-read ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-classifier as pe-classifier-read ident rule fragment]/ensure: defined content as '{md5}067b2c1baeb452682640297e46b3c96c'
==> puppet.demo: 2017-02-02 22:21:02,352 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-classifier as pe-classifier-write]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-classifier as pe-classifier-write (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-classifier as pe-classifier-write (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-classifier as pe-classifier-write (ipv4)]/ensure: defined content as '{md5}c96be4de0bc87614291397e733bff3d1'
==> puppet.demo: 2017-02-02 22:21:02,362 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-classifier as pe-classifier-write]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-classifier as pe-classifier-write (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-classifier as pe-classifier-write (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-classifier as pe-classifier-write (ipv6)]/ensure: defined content as '{md5}bcdd119c4724eced25ccb4a3d61acd14'
==> puppet.demo: 2017-02-02 22:21:02,372 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-classifier as pe-classifier-write]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-classifier as pe-classifier-write]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-classifier as pe-classifier-write ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-classifier as pe-classifier-write ident rule fragment]/ensure: defined content as '{md5}30cd135817e4e350035191f7ba835749'
==> puppet.demo: 2017-02-02 22:21:02,378 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-rbac as pe-rbac]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-rbac as pe-rbac (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-rbac as pe-rbac (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-rbac as pe-rbac (ipv4)]/ensure: defined content as '{md5}5e5a9328427f855dffeb7c7de0764509'
==> puppet.demo: 2017-02-02 22:21:02,386 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-rbac as pe-rbac]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-rbac as pe-rbac (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-rbac as pe-rbac (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-rbac as pe-rbac (ipv6)]/ensure: defined content as '{md5}edf03d25e9284bbc6388b59cb0ade584'
==> puppet.demo: 2017-02-02 22:21:02,400 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-rbac as pe-rbac]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-rbac as pe-rbac]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-rbac as pe-rbac ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-rbac as pe-rbac ident rule fragment]/ensure: defined content as '{md5}853c9215fadcc8163358e3ecb732bbe7'
==> puppet.demo: 2017-02-02 22:21:02,408 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-rbac as pe-rbac-read]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-rbac as pe-rbac-read (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-rbac as pe-rbac-read (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-rbac as pe-rbac-read (ipv4)]/ensure: defined content as '{md5}c228d73a1708fa6255fa872e1ecd5792'
==> puppet.demo: 2017-02-02 22:21:02,416 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-rbac as pe-rbac-read]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-rbac as pe-rbac-read (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-rbac as pe-rbac-read (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-rbac as pe-rbac-read (ipv6)]/ensure: defined content as '{md5}c4d8f1e44fe6bcef4e3ded5d43b31d3c'
==> puppet.demo: 2017-02-02 22:21:02,425 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-rbac as pe-rbac-read]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-rbac as pe-rbac-read]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-rbac as pe-rbac-read ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-rbac as pe-rbac-read ident rule fragment]/ensure: defined content as '{md5}f40eac1496de374a3cb522395eabfc85'
==> puppet.demo: 2017-02-02 22:21:02,434 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-rbac as pe-rbac-write]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-rbac as pe-rbac-write (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-rbac as pe-rbac-write (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-rbac as pe-rbac-write (ipv4)]/ensure: defined content as '{md5}5ffc5a056b9cdb5081ae0d1142834e28'
==> puppet.demo: 2017-02-02 22:21:02,441 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-rbac as pe-rbac-write]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-rbac as pe-rbac-write (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-rbac as pe-rbac-write (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-rbac as pe-rbac-write (ipv6)]/ensure: defined content as '{md5}a31f5f4c1d3b3482db713fd294881b8b'
==> puppet.demo: 2017-02-02 22:21:02,453 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-rbac as pe-rbac-write]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-rbac as pe-rbac-write]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-rbac as pe-rbac-write ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-rbac as pe-rbac-write ident rule fragment]/ensure: defined content as '{md5}baeabb91ea06c2d6660e71b702da85ab'
==> puppet.demo: 2017-02-02 22:21:02,464 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-activity as pe-activity]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-activity as pe-activity (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-activity as pe-activity (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-activity as pe-activity (ipv4)]/ensure: defined content as '{md5}0b7a60e7b1108e0ccdf14b70fda849bc'
==> puppet.demo: 2017-02-02 22:21:02,472 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-activity as pe-activity]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-activity as pe-activity (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-activity as pe-activity (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-activity as pe-activity (ipv6)]/ensure: defined content as '{md5}29c86cfdff9045af7e0335b4bc499baf'
==> puppet.demo: 2017-02-02 22:21:02,482 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-activity as pe-activity]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-activity as pe-activity]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-activity as pe-activity ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-activity as pe-activity ident rule fragment]/ensure: defined content as '{md5}487b65892575ad24ff4c84bb56193fb6'
==> puppet.demo: 2017-02-02 22:21:02,494 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-activity as pe-activity-read]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-activity as pe-activity-read (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-activity as pe-activity-read (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-activity as pe-activity-read (ipv4)]/ensure: defined content as '{md5}c35d24479de8a0d65bc81104f6b1a2e2'
==> puppet.demo: 2017-02-02 22:21:02,503 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-activity as pe-activity-read]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-activity as pe-activity-read (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-activity as pe-activity-read (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-activity as pe-activity-read (ipv6)]/ensure: defined content as '{md5}41615ea92fee46ac6528c57415d7359a'
==> puppet.demo: 2017-02-02 22:21:02,509 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-activity as pe-activity-read]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-activity as pe-activity-read]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-activity as pe-activity-read ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-activity as pe-activity-read ident rule fragment]/ensure: defined content as '{md5}a31455d8bd93c939300d19ef4c0c8524'
==> puppet.demo: 2017-02-02 22:21:02,522 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-activity as pe-activity-write]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-activity as pe-activity-write (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-activity as pe-activity-write (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-activity as pe-activity-write (ipv4)]/ensure: defined content as '{md5}76db3d326df15710c6d520d4fded8adc'
==> puppet.demo: 2017-02-02 22:21:02,535 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-activity as pe-activity-write]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-activity as pe-activity-write (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-activity as pe-activity-write (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-activity as pe-activity-write (ipv6)]/ensure: defined content as '{md5}b0e4fc2fb0461d6d0e020873a2b5de1f'
==> puppet.demo: 2017-02-02 22:21:02,543 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-activity as pe-activity-write]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-activity as pe-activity-write]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-activity as pe-activity-write ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-activity as pe-activity-write ident rule fragment]/ensure: defined content as '{md5}38dc0ea996406d9ec55584acdcde6264'
==> puppet.demo: 2017-02-02 22:21:02,556 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator (ipv4)]/ensure: defined content as '{md5}2766e82c40af55c999a085481cd168e6'
==> puppet.demo: 2017-02-02 22:21:02,566 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator (ipv6)]/ensure: defined content as '{md5}0c0a02b27e0a1ce3a2515e0d84c1751c'
==> puppet.demo: 2017-02-02 22:21:02,575 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator ident rule fragment]/ensure: defined content as '{md5}e6a0d996132f987c1aefd834f96112d5'
==> puppet.demo: 2017-02-02 22:21:02,587 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-read]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-read (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-read (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-read (ipv4)]/ensure: defined content as '{md5}2e16ca13065ca3e27b852bc6e497073c'
==> puppet.demo: 2017-02-02 22:21:02,594 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-read]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-read (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-read (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-read (ipv6)]/ensure: defined content as '{md5}f5c55c990bbc10ddfb41a13785c72197'
==> puppet.demo: 2017-02-02 22:21:02,604 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-read]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-read]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-read ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-read ident rule fragment]/ensure: defined content as '{md5}849445343af7d212b5be515c83d17da6'
==> puppet.demo: 2017-02-02 22:21:02,611 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-write]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-write (ipv4)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-write (ipv4)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/0_pg_hba_rule_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-write (ipv4)]/ensure: defined content as '{md5}0b32542f9db532fb3232048367093a71'
==> puppet.demo: 2017-02-02 22:21:02,621 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-write]/Pe_postgresql::Server::Pg_hba_rule[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-write (ipv6)]/Pe_concat::Fragment[pg_hba_rule_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-write (ipv6)]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_hba.conf/fragments/1_pg_hba_rule_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-write (ipv6)]/ensure: defined content as '{md5}90629ac73d9c8416e1f4f8a6a9292923'
==> puppet.demo: 2017-02-02 22:21:02,765 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/Exec[pe_concat_/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:02,835 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/Exec[pe_concat_/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]: Triggered 'refresh' from 35 events
==> puppet.demo: 2017-02-02 22:21:02,843 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/File[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/content: content changed '{md5}7f6cacec3610d9a75a774b2350301106' to '{md5}41f965ce2843ab998b769de31450dd4d'
==> puppet.demo: 2017-02-02 22:21:02,844 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/File[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/mode: mode changed '0600' to '0640'
==> puppet.demo: 2017-02-02 22:21:02,847 - [Notice]: /Stage[main]/Pe_postgresql::Server::Config/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/File[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_hba.conf]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:21:02,856 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Cert_whitelist_entry[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-write]/Puppet_enterprise::Pg::Ident_entry[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-write]/Pe_concat::Fragment[Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-write ident rule fragment]/File[/opt/puppetlabs/puppet/cache/pe_concat/_opt_puppetlabs_server_data_postgresql_9.4_data_pg_ident.conf/fragments/10_Allow puppet.demo to connect to pe-orchestrator as pe-orchestrator-write ident rule fragment]/ensure: defined content as '{md5}b07ea15224fb7d8e9be644833453a2dd'
==> puppet.demo: 2017-02-02 22:21:02,942 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/Exec[pe_concat_/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:02,985 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/Exec[pe_concat_/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]: Triggered 'refresh' from 15 events
==> puppet.demo: 2017-02-02 22:21:02,993 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/File[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/content: content changed '{md5}f11c8332d3f444148c0b8ee83ec5fc6d' to '{md5}b835a868f1b96b4c0185e0dc8ff10171'
==> puppet.demo: 2017-02-02 22:21:02,994 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/File[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/mode: mode changed '0600' to '0640'
==> puppet.demo: 2017-02-02 22:21:02,997 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_concat[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/File[/opt/puppetlabs/server/data/postgresql/9.4/data/pg_ident.conf]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:21:03,002 - [Notice]: /Stage[main]/Pe_postgresql::Server::Service/Pe_anchor[pe_postgresql::server::service::begin]: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:04,271 - [Notice]: /Stage[main]/Pe_postgresql::Server::Service/Service[postgresqld]/ensure: ensure changed 'stopped' to 'running'
==> puppet.demo: 2017-02-02 22:21:04,340 - [Notice]: /Stage[main]/Pe_postgresql::Server::Service/Pe_postgresql::Validate_db_connection[validate_service_is_running]/Exec[validate postgres connection for /pe-postgres]: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:04,343 - [Notice]: /Stage[main]/Pe_postgresql::Server::Service/Pe_anchor[pe_postgresql::server::service::end]: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:04,399 - [Notice]: /Stage[main]/Pe_postgresql::Server::Reload/Exec[postgresql_reload]: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:04,434 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Role[pe-ha-replication]/Pe_postgresql_psql[CREATE ROLE "pe-ha-replication"  LOGIN NOCREATEROLE NOCREATEDB SUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-ha-replication"  LOGIN NOCREATEROLE NOCREATEDB SUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:04,574 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Database[postgres]/Pe_postgresql_psql[Check for existence of db 'postgres']/command: command changed '' to 'SELECT 1'
==> puppet.demo: 2017-02-02 22:21:04,875 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Database[postgres]/Exec[/opt/puppetlabs/server/bin/createdb --port='5432' --owner='pe-postgres' --template=template0 --encoding 'UTF8' --lc-ctype=en_US.UTF-8 --lc-collate=en_US.UTF-8  'postgres']: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:04,891 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Pe_postgresql::Server::Database[postgres]/Pe_postgresql_psql[REVOKE CONNECT ON DATABASE "postgres" FROM public]: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:04,921 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Pe_postgresql::Server::Tablespace[pe-puppetdb]/File[/opt/puppetlabs/server/data/postgresql/puppetdb]/ensure: created
==> puppet.demo: 2017-02-02 22:21:04,954 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Pe_postgresql::Server::Tablespace[pe-puppetdb]/Pe_postgresql_psql[Create tablespace 'pe-puppetdb']/command: command changed '' to 'CREATE TABLESPACE "pe-puppetdb"  LOCATION '/opt/puppetlabs/server/data/postgresql/puppetdb''
==> puppet.demo: 2017-02-02 22:21:04,990 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Pe_postgresql::Server::Role[pe-puppetdb]/Pe_postgresql_psql[CREATE ROLE "pe-puppetdb"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-puppetdb"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:05,125 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Pe_postgresql::Server::Tablespace[pe-classifier]/File[/opt/puppetlabs/server/data/postgresql/classifier]/ensure: created
==> puppet.demo: 2017-02-02 22:21:05,157 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Pe_postgresql::Server::Tablespace[pe-classifier]/Pe_postgresql_psql[Create tablespace 'pe-classifier']/command: command changed '' to 'CREATE TABLESPACE "pe-classifier"  LOCATION '/opt/puppetlabs/server/data/postgresql/classifier''
==> puppet.demo: 2017-02-02 22:21:05,196 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Pe_postgresql::Server::Role[pe-classifier]/Pe_postgresql_psql[CREATE ROLE "pe-classifier"  LOGIN NOCREATEROLE NOCREATEDB SUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-classifier"  LOGIN NOCREATEROLE NOCREATEDB SUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:05,321 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Pe_postgresql::Server::Tablespace[pe-rbac]/File[/opt/puppetlabs/server/data/postgresql/rbac]/ensure: created
==> puppet.demo: 2017-02-02 22:21:05,351 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Pe_postgresql::Server::Tablespace[pe-rbac]/Pe_postgresql_psql[Create tablespace 'pe-rbac']/command: command changed '' to 'CREATE TABLESPACE "pe-rbac"  LOCATION '/opt/puppetlabs/server/data/postgresql/rbac''
==> puppet.demo: 2017-02-02 22:21:05,388 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Pe_postgresql::Server::Role[pe-rbac]/Pe_postgresql_psql[CREATE ROLE "pe-rbac"  LOGIN NOCREATEROLE NOCREATEDB SUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-rbac"  LOGIN NOCREATEROLE NOCREATEDB SUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:05,512 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Pe_postgresql::Server::Tablespace[pe-activity]/File[/opt/puppetlabs/server/data/postgresql/activity]/ensure: created
==> puppet.demo: 2017-02-02 22:21:05,544 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Pe_postgresql::Server::Tablespace[pe-activity]/Pe_postgresql_psql[Create tablespace 'pe-activity']/command: command changed '' to 'CREATE TABLESPACE "pe-activity"  LOCATION '/opt/puppetlabs/server/data/postgresql/activity''
==> puppet.demo: 2017-02-02 22:21:05,585 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Pe_postgresql::Server::Role[pe-activity]/Pe_postgresql_psql[CREATE ROLE "pe-activity"  LOGIN NOCREATEROLE NOCREATEDB SUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-activity"  LOGIN NOCREATEROLE NOCREATEDB SUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:05,716 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Pe_postgresql::Server::Tablespace[pe-orchestrator]/File[/opt/puppetlabs/server/data/postgresql/orchestrator]/ensure: created
==> puppet.demo: 2017-02-02 22:21:05,749 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Pe_postgresql::Server::Tablespace[pe-orchestrator]/Pe_postgresql_psql[Create tablespace 'pe-orchestrator']/command: command changed '' to 'CREATE TABLESPACE "pe-orchestrator"  LOCATION '/opt/puppetlabs/server/data/postgresql/orchestrator''
==> puppet.demo: 2017-02-02 22:21:05,793 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Pe_postgresql::Server::Role[pe-orchestrator]/Pe_postgresql_psql[CREATE ROLE "pe-orchestrator"  LOGIN NOCREATEROLE NOCREATEDB SUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-orchestrator"  LOGIN NOCREATEROLE NOCREATEDB SUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:05,933 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Pe_postgresql::Server::Db[pe-puppetdb]/Pe_postgresql::Server::Database[pe-puppetdb]/Pe_postgresql_psql[Check for existence of db 'pe-puppetdb']/command: command changed '' to 'SELECT 1'
==> puppet.demo: 2017-02-02 22:21:06,230 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Pe_postgresql::Server::Db[pe-puppetdb]/Pe_postgresql::Server::Database[pe-puppetdb]/Exec[/opt/puppetlabs/server/bin/createdb --port='5432' --owner='pe-postgres' --template=template0 --encoding 'UTF8' --lc-ctype=en_US.UTF-8 --lc-collate=en_US.UTF-8 --tablespace='pe-puppetdb'  'pe-puppetdb']: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:06,246 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Pe_postgresql::Server::Db[pe-puppetdb]/Pe_postgresql::Server::Database[pe-puppetdb]/Pe_postgresql_psql[REVOKE CONNECT ON DATABASE "pe-puppetdb" FROM public]: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:06,296 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Pe_postgresql::Server::Db[pe-classifier]/Pe_postgresql::Server::Database[pe-classifier]/Pe_postgresql_psql[Check for existence of db 'pe-classifier']/command: command changed '' to 'SELECT 1'
==> puppet.demo: 2017-02-02 22:21:06,595 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Pe_postgresql::Server::Db[pe-classifier]/Pe_postgresql::Server::Database[pe-classifier]/Exec[/opt/puppetlabs/server/bin/createdb --port='5432' --owner='pe-postgres' --template=template0 --encoding 'UTF8' --lc-ctype=en_US.UTF-8 --lc-collate=en_US.UTF-8 --tablespace='pe-classifier'  'pe-classifier']: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:06,611 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Pe_postgresql::Server::Db[pe-classifier]/Pe_postgresql::Server::Database[pe-classifier]/Pe_postgresql_psql[REVOKE CONNECT ON DATABASE "pe-classifier" FROM public]: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:06,665 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Pe_postgresql::Server::Db[pe-rbac]/Pe_postgresql::Server::Database[pe-rbac]/Pe_postgresql_psql[Check for existence of db 'pe-rbac']/command: command changed '' to 'SELECT 1'
==> puppet.demo: 2017-02-02 22:21:06,955 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Pe_postgresql::Server::Db[pe-rbac]/Pe_postgresql::Server::Database[pe-rbac]/Exec[/opt/puppetlabs/server/bin/createdb --port='5432' --owner='pe-postgres' --template=template0 --encoding 'UTF8' --lc-ctype=en_US.UTF-8 --lc-collate=en_US.UTF-8 --tablespace='pe-rbac'  'pe-rbac']: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:06,972 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Pe_postgresql::Server::Db[pe-rbac]/Pe_postgresql::Server::Database[pe-rbac]/Pe_postgresql_psql[REVOKE CONNECT ON DATABASE "pe-rbac" FROM public]: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:07,031 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Pe_postgresql::Server::Db[pe-activity]/Pe_postgresql::Server::Database[pe-activity]/Pe_postgresql_psql[Check for existence of db 'pe-activity']/command: command changed '' to 'SELECT 1'
==> puppet.demo: 2017-02-02 22:21:07,332 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Pe_postgresql::Server::Db[pe-activity]/Pe_postgresql::Server::Database[pe-activity]/Exec[/opt/puppetlabs/server/bin/createdb --port='5432' --owner='pe-postgres' --template=template0 --encoding 'UTF8' --lc-ctype=en_US.UTF-8 --lc-collate=en_US.UTF-8 --tablespace='pe-activity'  'pe-activity']: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:07,347 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Pe_postgresql::Server::Db[pe-activity]/Pe_postgresql::Server::Database[pe-activity]/Pe_postgresql_psql[REVOKE CONNECT ON DATABASE "pe-activity" FROM public]: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:07,402 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Pe_postgresql::Server::Db[pe-orchestrator]/Pe_postgresql::Server::Database[pe-orchestrator]/Pe_postgresql_psql[Check for existence of db 'pe-orchestrator']/command: command changed '' to 'SELECT 1'
==> puppet.demo: 2017-02-02 22:21:07,693 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Pe_postgresql::Server::Db[pe-orchestrator]/Pe_postgresql::Server::Database[pe-orchestrator]/Exec[/opt/puppetlabs/server/bin/createdb --port='5432' --owner='pe-postgres' --template=template0 --encoding 'UTF8' --lc-ctype=en_US.UTF-8 --lc-collate=en_US.UTF-8 --tablespace='pe-orchestrator'  'pe-orchestrator']: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:07,709 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Pe_postgresql::Server::Db[pe-orchestrator]/Pe_postgresql::Server::Database[pe-orchestrator]/Pe_postgresql_psql[REVOKE CONNECT ON DATABASE "pe-orchestrator" FROM public]: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:21:07,771 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Pe_postgresql::Server::Db[pe-puppetdb]/Pe_postgresql::Server::Database_grant[GRANT pe-puppetdb - ALL - pe-puppetdb]/Pe_postgresql::Server::Grant[database:GRANT pe-puppetdb - ALL - pe-puppetdb]/Pe_postgresql_psql[GRANT ALL ON DATABASE "pe-puppetdb" TO "pe-puppetdb"]/command: command changed '' to 'GRANT ALL ON DATABASE "pe-puppetdb" TO "pe-puppetdb"'
==> puppet.demo: 2017-02-02 22:21:07,811 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Puppet_enterprise::Psql[pe-puppetdb revoke public table create perms]/Pe_postgresql_psql[pe-puppetdb revoke public table create perms]/command: command changed '' to 'REVOKE CREATE ON SCHEMA public FROM public'
==> puppet.demo: 2017-02-02 22:21:07,850 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Puppet_enterprise::Psql[grant table create to pe-puppetdb on pe-puppetdb]/Pe_postgresql_psql[grant table create to pe-puppetdb on pe-puppetdb]/command: command changed '' to 'GRANT CREATE ON SCHEMA public TO "pe-puppetdb"'
==> puppet.demo: 2017-02-02 22:21:07,901 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Puppet_enterprise::Pg::Extension[pe-puppetdb/pg_trgm]/Puppet_enterprise::Psql[pe-puppetdb/pg_trgm/sql]/Pe_postgresql_psql[pe-puppetdb/pg_trgm/sql]/command: command changed '' to 'CREATE EXTENSION pg_trgm;'
==> puppet.demo: 2017-02-02 22:21:07,942 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[puppetdb]/Puppet_enterprise::Pg::Extension[pe-puppetdb/pgcrypto]/Puppet_enterprise::Psql[pe-puppetdb/pgcrypto/sql]/Pe_postgresql_psql[pe-puppetdb/pgcrypto/sql]/command: command changed '' to 'CREATE EXTENSION pgcrypto;'
==> puppet.demo: 2017-02-02 22:21:07,993 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Psql[pe-classifier revoke public table create perms]/Pe_postgresql_psql[pe-classifier revoke public table create perms]/command: command changed '' to 'REVOKE CREATE ON SCHEMA public FROM public'
==> puppet.demo: 2017-02-02 22:21:08,093 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Ordinary_user[pe-classifier-read]/Pe_postgresql::Server::Role[pe-classifier-read]/Pe_postgresql_psql[CREATE ROLE "pe-classifier-read"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-classifier-read"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:08,248 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Ordinary_user[pe-classifier-write]/Pe_postgresql::Server::Role[pe-classifier-write]/Pe_postgresql_psql[CREATE ROLE "pe-classifier-write"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-classifier-write"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:08,393 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Ordinary_user[pe-classifier-read]/Puppet_enterprise::Pg::Grant_connect[pe-classifier grant connect perms to pe-classifier-read]/Puppet_enterprise::Psql[pe-classifier grant connect perms to pe-classifier-read/sql]/Pe_postgresql_psql[pe-classifier grant connect perms to pe-classifier-read/sql]/command: command changed '' to 'GRANT CONNECT ON DATABASE "pe-classifier"
==> puppet.demo:                 TO "pe-classifier-read"'
==> puppet.demo: 2017-02-02 22:21:08,429 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Ordinary_user[pe-classifier-read]/Puppet_enterprise::Pg::Default_read_grant[pe-classifier grant read perms on new objects from pe-classifier to pe-classifier-read]/Puppet_enterprise::Psql[pe-classifier grant read perms on new objects from pe-classifier to pe-classifier-read/sql]/Pe_postgresql_psql[pe-classifier grant read perms on new objects from pe-classifier to pe-classifier-read/sql]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-classifier"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                 GRANT SELECT ON TABLES
==> puppet.demo:                   TO "pe-classifier-read"'
==> puppet.demo: 2017-02-02 22:21:08,468 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Ordinary_user[pe-classifier-read]/Puppet_enterprise::Pg::Default_read_grant[pe-classifier grant read perms on new objects from pe-ha-replication to pe-classifier-read]/Puppet_enterprise::Psql[pe-classifier grant read perms on new objects from pe-ha-replication to pe-classifier-read/sql]/Pe_postgresql_psql[pe-classifier grant read perms on new objects from pe-ha-replication to pe-classifier-read/sql]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-ha-replication"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                 GRANT SELECT ON TABLES
==> puppet.demo:                   TO "pe-classifier-read"'
==> puppet.demo: 2017-02-02 22:21:08,512 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Ordinary_user[pe-classifier-write]/Puppet_enterprise::Pg::Grant_connect[pe-classifier grant connect perms to pe-classifier-write]/Puppet_enterprise::Psql[pe-classifier grant connect perms to pe-classifier-write/sql]/Pe_postgresql_psql[pe-classifier grant connect perms to pe-classifier-write/sql]/command: command changed '' to 'GRANT CONNECT ON DATABASE "pe-classifier"
==> puppet.demo:                 TO "pe-classifier-write"'
==> puppet.demo: 2017-02-02 22:21:08,611 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Ordinary_user[pe-classifier-write]/Puppet_enterprise::Pg::Default_write_grant[pe-classifier grant write perms on new objects from pe-classifier to pe-classifier-write]/Puppet_enterprise::Psql[pe-classifier grant write perms on new objects from pe-classifier to pe-classifier-write/tables]/Pe_postgresql_psql[pe-classifier grant write perms on new objects from pe-classifier to pe-classifier-write/tables]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                     FOR USER "pe-classifier"
==> puppet.demo:                     IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON TABLES
==> puppet.demo:                     TO "pe-classifier-write"'
==> puppet.demo: 2017-02-02 22:21:08,647 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Ordinary_user[pe-classifier-write]/Puppet_enterprise::Pg::Default_write_grant[pe-classifier grant write perms on new objects from pe-classifier to pe-classifier-write]/Puppet_enterprise::Psql[pe-classifier grant write perms on new objects from pe-classifier to pe-classifier-write/sequences]/Pe_postgresql_psql[pe-classifier grant write perms on new objects from pe-classifier to pe-classifier-write/sequences]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-classifier"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON SEQUENCES
==> puppet.demo:                   TO "pe-classifier-write"'
==> puppet.demo: 2017-02-02 22:21:08,699 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Ordinary_user[pe-classifier-write]/Puppet_enterprise::Pg::Default_write_grant[pe-classifier grant write perms on new objects from pe-classifier to pe-classifier-write]/Puppet_enterprise::Psql[pe-classifier grant write perms on new objects from pe-classifier to pe-classifier-write/functions]/Pe_postgresql_psql[pe-classifier grant write perms on new objects from pe-classifier to pe-classifier-write/functions]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-classifier"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON FUNCTIONS
==> puppet.demo:                   TO "pe-classifier-write"'
==> puppet.demo: 2017-02-02 22:21:08,745 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Ordinary_user[pe-classifier-write]/Puppet_enterprise::Pg::Default_write_grant[pe-classifier grant write perms on new objects from pe-ha-replication to pe-classifier-write]/Puppet_enterprise::Psql[pe-classifier grant write perms on new objects from pe-ha-replication to pe-classifier-write/tables]/Pe_postgresql_psql[pe-classifier grant write perms on new objects from pe-ha-replication to pe-classifier-write/tables]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                     FOR USER "pe-ha-replication"
==> puppet.demo:                     IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON TABLES
==> puppet.demo:                     TO "pe-classifier-write"'
==> puppet.demo: 2017-02-02 22:21:08,782 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Ordinary_user[pe-classifier-write]/Puppet_enterprise::Pg::Default_write_grant[pe-classifier grant write perms on new objects from pe-ha-replication to pe-classifier-write]/Puppet_enterprise::Psql[pe-classifier grant write perms on new objects from pe-ha-replication to pe-classifier-write/sequences]/Pe_postgresql_psql[pe-classifier grant write perms on new objects from pe-ha-replication to pe-classifier-write/sequences]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-ha-replication"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON SEQUENCES
==> puppet.demo:                   TO "pe-classifier-write"'
==> puppet.demo: 2017-02-02 22:21:08,829 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[classifier]/Puppet_enterprise::Pg::Ordinary_user[pe-classifier-write]/Puppet_enterprise::Pg::Default_write_grant[pe-classifier grant write perms on new objects from pe-ha-replication to pe-classifier-write]/Puppet_enterprise::Psql[pe-classifier grant write perms on new objects from pe-ha-replication to pe-classifier-write/functions]/Pe_postgresql_psql[pe-classifier grant write perms on new objects from pe-ha-replication to pe-classifier-write/functions]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-ha-replication"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON FUNCTIONS
==> puppet.demo:                   TO "pe-classifier-write"'
==> puppet.demo: 2017-02-02 22:21:08,888 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Psql[pe-rbac revoke public table create perms]/Pe_postgresql_psql[pe-rbac revoke public table create perms]/command: command changed '' to 'REVOKE CREATE ON SCHEMA public FROM public'
==> puppet.demo: 2017-02-02 22:21:08,978 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Ordinary_user[pe-rbac-read]/Pe_postgresql::Server::Role[pe-rbac-read]/Pe_postgresql_psql[CREATE ROLE "pe-rbac-read"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-rbac-read"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:09,122 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Ordinary_user[pe-rbac-write]/Pe_postgresql::Server::Role[pe-rbac-write]/Pe_postgresql_psql[CREATE ROLE "pe-rbac-write"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-rbac-write"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:09,289 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Extension[pe-rbac/citext]/Puppet_enterprise::Psql[pe-rbac/citext/sql]/Pe_postgresql_psql[pe-rbac/citext/sql]/command: command changed '' to 'CREATE EXTENSION citext;'
==> puppet.demo: 2017-02-02 22:21:09,328 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Extension[pe-rbac/pgcrypto]/Puppet_enterprise::Psql[pe-rbac/pgcrypto/sql]/Pe_postgresql_psql[pe-rbac/pgcrypto/sql]/command: command changed '' to 'CREATE EXTENSION pgcrypto;'
==> puppet.demo: 2017-02-02 22:21:09,365 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Ordinary_user[pe-rbac-read]/Puppet_enterprise::Pg::Grant_connect[pe-rbac grant connect perms to pe-rbac-read]/Puppet_enterprise::Psql[pe-rbac grant connect perms to pe-rbac-read/sql]/Pe_postgresql_psql[pe-rbac grant connect perms to pe-rbac-read/sql]/command: command changed '' to 'GRANT CONNECT ON DATABASE "pe-rbac"
==> puppet.demo:                 TO "pe-rbac-read"'
==> puppet.demo: 2017-02-02 22:21:09,408 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Ordinary_user[pe-rbac-read]/Puppet_enterprise::Pg::Default_read_grant[pe-rbac grant read perms on new objects from pe-rbac to pe-rbac-read]/Puppet_enterprise::Psql[pe-rbac grant read perms on new objects from pe-rbac to pe-rbac-read/sql]/Pe_postgresql_psql[pe-rbac grant read perms on new objects from pe-rbac to pe-rbac-read/sql]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-rbac"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                 GRANT SELECT ON TABLES
==> puppet.demo:                   TO "pe-rbac-read"'
==> puppet.demo: 2017-02-02 22:21:09,444 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Ordinary_user[pe-rbac-read]/Puppet_enterprise::Pg::Default_read_grant[pe-rbac grant read perms on new objects from pe-ha-replication to pe-rbac-read]/Puppet_enterprise::Psql[pe-rbac grant read perms on new objects from pe-ha-replication to pe-rbac-read/sql]/Pe_postgresql_psql[pe-rbac grant read perms on new objects from pe-ha-replication to pe-rbac-read/sql]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-ha-replication"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                 GRANT SELECT ON TABLES
==> puppet.demo:                   TO "pe-rbac-read"'
==> puppet.demo: 2017-02-02 22:21:09,482 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Ordinary_user[pe-rbac-write]/Puppet_enterprise::Pg::Grant_connect[pe-rbac grant connect perms to pe-rbac-write]/Puppet_enterprise::Psql[pe-rbac grant connect perms to pe-rbac-write/sql]/Pe_postgresql_psql[pe-rbac grant connect perms to pe-rbac-write/sql]/command: command changed '' to 'GRANT CONNECT ON DATABASE "pe-rbac"
==> puppet.demo:                 TO "pe-rbac-write"'
==> puppet.demo: 2017-02-02 22:21:09,579 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Ordinary_user[pe-rbac-write]/Puppet_enterprise::Pg::Default_write_grant[pe-rbac grant write perms on new objects from pe-rbac to pe-rbac-write]/Puppet_enterprise::Psql[pe-rbac grant write perms on new objects from pe-rbac to pe-rbac-write/tables]/Pe_postgresql_psql[pe-rbac grant write perms on new objects from pe-rbac to pe-rbac-write/tables]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                     FOR USER "pe-rbac"
==> puppet.demo:                     IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON TABLES
==> puppet.demo:                     TO "pe-rbac-write"'
==> puppet.demo: 2017-02-02 22:21:09,614 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Ordinary_user[pe-rbac-write]/Puppet_enterprise::Pg::Default_write_grant[pe-rbac grant write perms on new objects from pe-rbac to pe-rbac-write]/Puppet_enterprise::Psql[pe-rbac grant write perms on new objects from pe-rbac to pe-rbac-write/sequences]/Pe_postgresql_psql[pe-rbac grant write perms on new objects from pe-rbac to pe-rbac-write/sequences]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-rbac"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON SEQUENCES
==> puppet.demo:                   TO "pe-rbac-write"'
==> puppet.demo: 2017-02-02 22:21:09,662 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Ordinary_user[pe-rbac-write]/Puppet_enterprise::Pg::Default_write_grant[pe-rbac grant write perms on new objects from pe-rbac to pe-rbac-write]/Puppet_enterprise::Psql[pe-rbac grant write perms on new objects from pe-rbac to pe-rbac-write/functions]/Pe_postgresql_psql[pe-rbac grant write perms on new objects from pe-rbac to pe-rbac-write/functions]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-rbac"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON FUNCTIONS
==> puppet.demo:                   TO "pe-rbac-write"'
==> puppet.demo: 2017-02-02 22:21:09,700 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Ordinary_user[pe-rbac-write]/Puppet_enterprise::Pg::Default_write_grant[pe-rbac grant write perms on new objects from pe-ha-replication to pe-rbac-write]/Puppet_enterprise::Psql[pe-rbac grant write perms on new objects from pe-ha-replication to pe-rbac-write/tables]/Pe_postgresql_psql[pe-rbac grant write perms on new objects from pe-ha-replication to pe-rbac-write/tables]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                     FOR USER "pe-ha-replication"
==> puppet.demo:                     IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON TABLES
==> puppet.demo:                     TO "pe-rbac-write"'
==> puppet.demo: 2017-02-02 22:21:09,750 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Ordinary_user[pe-rbac-write]/Puppet_enterprise::Pg::Default_write_grant[pe-rbac grant write perms on new objects from pe-ha-replication to pe-rbac-write]/Puppet_enterprise::Psql[pe-rbac grant write perms on new objects from pe-ha-replication to pe-rbac-write/sequences]/Pe_postgresql_psql[pe-rbac grant write perms on new objects from pe-ha-replication to pe-rbac-write/sequences]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-ha-replication"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON SEQUENCES
==> puppet.demo:                   TO "pe-rbac-write"'
==> puppet.demo: 2017-02-02 22:21:09,786 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[rbac]/Puppet_enterprise::Pg::Ordinary_user[pe-rbac-write]/Puppet_enterprise::Pg::Default_write_grant[pe-rbac grant write perms on new objects from pe-ha-replication to pe-rbac-write]/Puppet_enterprise::Psql[pe-rbac grant write perms on new objects from pe-ha-replication to pe-rbac-write/functions]/Pe_postgresql_psql[pe-rbac grant write perms on new objects from pe-ha-replication to pe-rbac-write/functions]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-ha-replication"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON FUNCTIONS
==> puppet.demo:                   TO "pe-rbac-write"'
==> puppet.demo: 2017-02-02 22:21:09,849 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Psql[pe-activity revoke public table create perms]/Pe_postgresql_psql[pe-activity revoke public table create perms]/command: command changed '' to 'REVOKE CREATE ON SCHEMA public FROM public'
==> puppet.demo: 2017-02-02 22:21:09,936 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Ordinary_user[pe-activity-read]/Pe_postgresql::Server::Role[pe-activity-read]/Pe_postgresql_psql[CREATE ROLE "pe-activity-read"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-activity-read"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:10,083 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Ordinary_user[pe-activity-write]/Pe_postgresql::Server::Role[pe-activity-write]/Pe_postgresql_psql[CREATE ROLE "pe-activity-write"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-activity-write"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo:
==> puppet.demo: 2017-02-02 22:21:10,234 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Ordinary_user[pe-activity-read]/Puppet_enterprise::Pg::Grant_connect[pe-activity grant connect perms to pe-activity-read]/Puppet_enterprise::Psql[pe-activity grant connect perms to pe-activity-read/sql]/Pe_postgresql_psql[pe-activity grant connect perms to pe-activity-read/sql]/command: command changed '' to 'GRANT CONNECT ON DATABASE "pe-activity"
==> puppet.demo:                 TO "pe-activity-read"'
==> puppet.demo: 2017-02-02 22:21:10,270 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Ordinary_user[pe-activity-read]/Puppet_enterprise::Pg::Default_read_grant[pe-activity grant read perms on new objects from pe-activity to pe-activity-read]/Puppet_enterprise::Psql[pe-activity grant read perms on new objects from pe-activity to pe-activity-read/sql]/Pe_postgresql_psql[pe-activity grant read perms on new objects from pe-activity to pe-activity-read/sql]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-activity"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                 GRANT SELECT ON TABLES
==> puppet.demo:                   TO "pe-activity-read"'
==> puppet.demo: 2017-02-02 22:21:10,310 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Ordinary_user[pe-activity-read]/Puppet_enterprise::Pg::Default_read_grant[pe-activity grant read perms on new objects from pe-ha-replication to pe-activity-read]/Puppet_enterprise::Psql[pe-activity grant read perms on new objects from pe-ha-replication to pe-activity-read/sql]/Pe_postgresql_psql[pe-activity grant read perms on new objects from pe-ha-replication to pe-activity-read/sql]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-ha-replication"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                 GRANT SELECT ON TABLES
==> puppet.demo:                   TO "pe-activity-read"'
==> puppet.demo: 2017-02-02 22:21:10,349 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Ordinary_user[pe-activity-write]/Puppet_enterprise::Pg::Grant_connect[pe-activity grant connect perms to pe-activity-write]/Puppet_enterprise::Psql[pe-activity grant connect perms to pe-activity-write/sql]/Pe_postgresql_psql[pe-activity grant connect perms to pe-activity-write/sql]/command: command changed '' to 'GRANT CONNECT ON DATABASE "pe-activity"
==> puppet.demo:                 TO "pe-activity-write"'
==> puppet.demo: 2017-02-02 22:21:10,449 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Ordinary_user[pe-activity-write]/Puppet_enterprise::Pg::Default_write_grant[pe-activity grant write perms on new objects from pe-activity to pe-activity-write]/Puppet_enterprise::Psql[pe-activity grant write perms on new objects from pe-activity to pe-activity-write/tables]/Pe_postgresql_psql[pe-activity grant write perms on new objects from pe-activity to pe-activity-write/tables]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                     FOR USER "pe-activity"
==> puppet.demo:                     IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON TABLES
==> puppet.demo:                     TO "pe-activity-write"'
==> puppet.demo: 2017-02-02 22:21:10,482 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Ordinary_user[pe-activity-write]/Puppet_enterprise::Pg::Default_write_grant[pe-activity grant write perms on new objects from pe-activity to pe-activity-write]/Puppet_enterprise::Psql[pe-activity grant write perms on new objects from pe-activity to pe-activity-write/sequences]/Pe_postgresql_psql[pe-activity grant write perms on new objects from pe-activity to pe-activity-write/sequences]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-activity"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON SEQUENCES
==> puppet.demo:                   TO "pe-activity-write"'
==> puppet.demo: 2017-02-02 22:21:10,523 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Ordinary_user[pe-activity-write]/Puppet_enterprise::Pg::Default_write_grant[pe-activity grant write perms on new objects from pe-activity to pe-activity-write]/Puppet_enterprise::Psql[pe-activity grant write perms on new objects from pe-activity to pe-activity-write/functions]/Pe_postgresql_psql[pe-activity grant write perms on new objects from pe-activity to pe-activity-write/functions]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-activity"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON FUNCTIONS
==> puppet.demo:                   TO "pe-activity-write"'
==> puppet.demo: 2017-02-02 22:21:10,562 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Ordinary_user[pe-activity-write]/Puppet_enterprise::Pg::Default_write_grant[pe-activity grant write perms on new objects from pe-ha-replication to pe-activity-write]/Puppet_enterprise::Psql[pe-activity grant write perms on new objects from pe-ha-replication to pe-activity-write/tables]/Pe_postgresql_psql[pe-activity grant write perms on new objects from pe-ha-replication to pe-activity-write/tables]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                     FOR USER "pe-ha-replication"
==> puppet.demo:                     IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON TABLES
==> puppet.demo:                     TO "pe-activity-write"'
==> puppet.demo: 2017-02-02 22:21:10,614 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Ordinary_user[pe-activity-write]/Puppet_enterprise::Pg::Default_write_grant[pe-activity grant write perms on new objects from pe-ha-replication to pe-activity-write]/Puppet_enterprise::Psql[pe-activity grant write perms on new objects from pe-ha-replication to pe-activity-write/sequences]/Pe_postgresql_psql[pe-activity grant write perms on new objects from pe-ha-replication to pe-activity-write/sequences]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-ha-replication"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON SEQUENCES
==> puppet.demo:                   TO "pe-activity-write"'
==> puppet.demo: 2017-02-02 22:21:10,648 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[activity]/Puppet_enterprise::Pg::Ordinary_user[pe-activity-write]/Puppet_enterprise::Pg::Default_write_grant[pe-activity grant write perms on new objects from pe-ha-replication to pe-activity-write]/Puppet_enterprise::Psql[pe-activity grant write perms on new objects from pe-ha-replication to pe-activity-write/functions]/Pe_postgresql_psql[pe-activity grant write perms on new objects from pe-ha-replication to pe-activity-write/functions]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-ha-replication"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON FUNCTIONS
==> puppet.demo:                   TO "pe-activity-write"'
==> puppet.demo: 2017-02-02 22:21:10,718 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Psql[pe-orchestrator revoke public table create perms]/Pe_postgresql_psql[pe-orchestrator revoke public table create perms]/command: command changed '' to 'REVOKE CREATE ON SCHEMA public FROM public'
==> puppet.demo: 2017-02-02 22:21:10,813 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Ordinary_user[pe-orchestrator-read]/Pe_postgresql::Server::Role[pe-orchestrator-read]/Pe_postgresql_psql[CREATE ROLE "pe-orchestrator-read"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-orchestrator-read"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:10,959 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Ordinary_user[pe-orchestrator-write]/Pe_postgresql::Server::Role[pe-orchestrator-write]/Pe_postgresql_psql[CREATE ROLE "pe-orchestrator-write"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1]/command: command changed '' to 'CREATE ROLE "pe-orchestrator-write"  LOGIN NOCREATEROLE NOCREATEDB NOSUPERUSER  CONNECTION LIMIT -1'
==> puppet.demo: 2017-02-02 22:21:11,103 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Ordinary_user[pe-orchestrator-read]/Puppet_enterprise::Pg::Grant_connect[pe-orchestrator grant connect perms to pe-orchestrator-read]/Puppet_enterprise::Psql[pe-orchestrator grant connect perms to pe-orchestrator-read/sql]/Pe_postgresql_psql[pe-orchestrator grant connect perms to pe-orchestrator-read/sql]/command: command changed '' to 'GRANT CONNECT ON DATABASE "pe-orchestrator"
==> puppet.demo:                 TO "pe-orchestrator-read"'
==> puppet.demo: 2017-02-02 22:21:11,136 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Ordinary_user[pe-orchestrator-read]/Puppet_enterprise::Pg::Default_read_grant[pe-orchestrator grant read perms on new objects from pe-orchestrator to pe-orchestrator-read]/Puppet_enterprise::Psql[pe-orchestrator grant read perms on new objects from pe-orchestrator to pe-orchestrator-read/sql]/Pe_postgresql_psql[pe-orchestrator grant read perms on new objects from pe-orchestrator to pe-orchestrator-read/sql]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-orchestrator"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                 GRANT SELECT ON TABLES
==> puppet.demo:                   TO "pe-orchestrator-read"'
==> puppet.demo: 2017-02-02 22:21:11,180 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Ordinary_user[pe-orchestrator-read]/Puppet_enterprise::Pg::Default_read_grant[pe-orchestrator grant read perms on new objects from pe-ha-replication to pe-orchestrator-read]/Puppet_enterprise::Psql[pe-orchestrator grant read perms on new objects from pe-ha-replication to pe-orchestrator-read/sql]/Pe_postgresql_psql[pe-orchestrator grant read perms on new objects from pe-ha-replication to pe-orchestrator-read/sql]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-ha-replication"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                 GRANT SELECT ON TABLES
==> puppet.demo:                   TO "pe-orchestrator-read"'
==> puppet.demo: 2017-02-02 22:21:11,217 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Ordinary_user[pe-orchestrator-write]/Puppet_enterprise::Pg::Grant_connect[pe-orchestrator grant connect perms to pe-orchestrator-write]/Puppet_enterprise::Psql[pe-orchestrator grant connect perms to pe-orchestrator-write/sql]/Pe_postgresql_psql[pe-orchestrator grant connect perms to pe-orchestrator-write/sql]/command: command changed '' to 'GRANT CONNECT ON DATABASE "pe-orchestrator"
==> puppet.demo:                 TO "pe-orchestrator-write"'
==> puppet.demo: 2017-02-02 22:21:11,321 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Ordinary_user[pe-orchestrator-write]/Puppet_enterprise::Pg::Default_write_grant[pe-orchestrator grant write perms on new objects from pe-orchestrator to pe-orchestrator-write]/Puppet_enterprise::Psql[pe-orchestrator grant write perms on new objects from pe-orchestrator to pe-orchestrator-write/tables]/Pe_postgresql_psql[pe-orchestrator grant write perms on new objects from pe-orchestrator to pe-orchestrator-write/tables]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                     FOR USER "pe-orchestrator"
==> puppet.demo:                     IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON TABLES
==> puppet.demo:                     TO "pe-orchestrator-write"'
==> puppet.demo: 2017-02-02 22:21:11,361 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Ordinary_user[pe-orchestrator-write]/Puppet_enterprise::Pg::Default_write_grant[pe-orchestrator grant write perms on new objects from pe-orchestrator to pe-orchestrator-write]/Puppet_enterprise::Psql[pe-orchestrator grant write perms on new objects from pe-orchestrator to pe-orchestrator-write/sequences]/Pe_postgresql_psql[pe-orchestrator grant write perms on new objects from pe-orchestrator to pe-orchestrator-write/sequences]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-orchestrator"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON SEQUENCES
==> puppet.demo:                   TO "pe-orchestrator-write"'
==> puppet.demo: 2017-02-02 22:21:11,396 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Ordinary_user[pe-orchestrator-write]/Puppet_enterprise::Pg::Default_write_grant[pe-orchestrator grant write perms on new objects from pe-orchestrator to pe-orchestrator-write]/Puppet_enterprise::Psql[pe-orchestrator grant write perms on new objects from pe-orchestrator to pe-orchestrator-write/functions]/Pe_postgresql_psql[pe-orchestrator grant write perms on new objects from pe-orchestrator to pe-orchestrator-write/functions]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-orchestrator"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON FUNCTIONS
==> puppet.demo:                   TO "pe-orchestrator-write"'
==> puppet.demo: 2017-02-02 22:21:11,435 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Ordinary_user[pe-orchestrator-write]/Puppet_enterprise::Pg::Default_write_grant[pe-orchestrator grant write perms on new objects from pe-ha-replication to pe-orchestrator-write]/Puppet_enterprise::Psql[pe-orchestrator grant write perms on new objects from pe-ha-replication to pe-orchestrator-write/tables]/Pe_postgresql_psql[pe-orchestrator grant write perms on new objects from pe-ha-replication to pe-orchestrator-write/tables]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                     FOR USER "pe-ha-replication"
==> puppet.demo:                     IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON TABLES
==> puppet.demo:                     TO "pe-orchestrator-write"'
==> puppet.demo: 2017-02-02 22:21:11,477 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Ordinary_user[pe-orchestrator-write]/Puppet_enterprise::Pg::Default_write_grant[pe-orchestrator grant write perms on new objects from pe-ha-replication to pe-orchestrator-write]/Puppet_enterprise::Psql[pe-orchestrator grant write perms on new objects from pe-ha-replication to pe-orchestrator-write/sequences]/Pe_postgresql_psql[pe-orchestrator grant write perms on new objects from pe-ha-replication to pe-orchestrator-write/sequences]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-ha-replication"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON SEQUENCES
==> puppet.demo:                   TO "pe-orchestrator-write"'
==> puppet.demo: 2017-02-02 22:21:11,513 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Database/Puppet_enterprise::App_database[orchestrator]/Puppet_enterprise::Pg::Ordinary_user[pe-orchestrator-write]/Puppet_enterprise::Pg::Default_write_grant[pe-orchestrator grant write perms on new objects from pe-ha-replication to pe-orchestrator-write]/Puppet_enterprise::Psql[pe-orchestrator grant write perms on new objects from pe-ha-replication to pe-orchestrator-write/functions]/Pe_postgresql_psql[pe-orchestrator grant write perms on new objects from pe-ha-replication to pe-orchestrator-write/functions]/command: command changed '' to 'ALTER DEFAULT PRIVILEGES
==> puppet.demo:                   FOR USER "pe-ha-replication"
==> puppet.demo:                   IN SCHEMA "public"
==> puppet.demo:                   GRANT ALL PRIVILEGES ON FUNCTIONS
==> puppet.demo:                   TO "pe-orchestrator-write"'
==> puppet.demo: 2017-02-02 22:21:14,473 - [Notice]: /Stage[main]/Puppet_enterprise::Packages/Package[pe-puppetdb]/ensure: created
==> puppet.demo: 2017-02-02 22:21:18,043 - [Notice]: /Stage[main]/Puppet_enterprise::Packages/Package[pe-console-services]/ensure: created
==> puppet.demo: 2017-02-02 22:21:21,857 - [Notice]: /Stage[main]/Puppet_enterprise::Packages/Package[pe-orchestration-services]/ensure: created
==> puppet.demo: 2017-02-02 22:21:21,861 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Pe_ini_setting[puppetserver puppetconf app_management]/ensure: created
==> puppet.demo: 2017-02-02 22:21:21,868 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Pe_hocon_setting[metrics.reporters.graphite.host]/ensure: created
==> puppet.demo: 2017-02-02 22:21:21,875 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Pe_hocon_setting[metrics.reporters.graphite.port]/ensure: created
==> puppet.demo: 2017-02-02 22:21:21,884 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Pe_hocon_setting[metrics.reporters.graphite.update-interval-seconds]/ensure: created
==> puppet.demo: 2017-02-02 22:21:21,924 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/etc/puppetlabs/puppet/ssl/private_keys/pe-internal-mcollective-servers.pem]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:21:21,928 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/etc/puppetlabs/puppet/ssl/private_keys/pe-internal-peadmin-mcollective-client.pem]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:21:21,937 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Pe_ini_setting[module_groups]/ensure: created
==> puppet.demo: 2017-02-02 22:21:21,941 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Pe_ini_setting[environmentpath_setting]/ensure: created
==> puppet.demo: 2017-02-02 22:21:21,944 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Pe_ini_setting[codedir_setting]/ensure: created
==> puppet.demo: 2017-02-02 22:21:21,951 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise]/ensure: created
==> puppet.demo: 2017-02-02 22:21:21,973 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/etc/puppetlabs/puppetserver/opt-out]/ensure: created
==> puppet.demo: 2017-02-02 22:21:21,985 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/File[/etc/sysconfig/pe-activemq]/content: content changed '{md5}acb5a7fbc5e6e9e2c75897e08ddfb334' to '{md5}4067d5d3ee95a3391897eafe14b725e5'
==> puppet.demo: 2017-02-02 22:21:22,432 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Certs/Pe_java_ks[puppet.demo:keystore]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,435 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Certs/File[/etc/puppetlabs/activemq/broker.ts]/group: group changed 'root' to 'pe-activemq'
==> puppet.demo: 2017-02-02 22:21:22,435 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Certs/File[/etc/puppetlabs/activemq/broker.ts]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:21:22,437 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Certs/File[/etc/puppetlabs/activemq/broker.ts]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:21:22,441 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Certs/File[/etc/puppetlabs/activemq/broker.ks]/group: group changed 'root' to 'pe-activemq'
==> puppet.demo: 2017-02-02 22:21:22,441 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Certs/File[/etc/puppetlabs/activemq/broker.ks]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:21:22,442 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Certs/File[/etc/puppetlabs/activemq/broker.ks]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:21:22,451 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/File[/etc/puppetlabs/orchestration-services/conf.d/webserver.conf]/owner: owner changed 'root' to 'pe-orchestration-services'
==> puppet.demo: 2017-02-02 22:21:22,451 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/File[/etc/puppetlabs/orchestration-services/conf.d/webserver.conf]/group: group changed 'root' to 'pe-orchestration-services'
==> puppet.demo: 2017-02-02 22:21:22,452 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/File[/etc/puppetlabs/orchestration-services/conf.d/webserver.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:21:22,467 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.global.certs.ssl-ca-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,476 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.global.certs.ssl-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,480 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.global.certs.ssl-key]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,534 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.webserver.pcp-broker.ssl-ca-cert]/value: value changed ['/opt/puppetlabs/server/data/orchestration-services/certs/orchestration-services.localhost.ca_cert.pem'] to '/etc/puppetlabs/puppet/ssl/certs/ca.pem'
==> puppet.demo: 2017-02-02 22:21:22,657 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.webserver.pcp-broker.ssl-cert]/value: value changed ['/opt/puppetlabs/server/data/orchestration-services/certs/orchestration-services.localhost.cert.pem'] to '/etc/puppetlabs/orchestration-services/ssl/puppet.demo.cert.pem'
==> puppet.demo: 2017-02-02 22:21:22,670 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.webserver.pcp-broker.ssl-key]/value: value changed ['/opt/puppetlabs/server/data/orchestration-services/certs/orchestration-services.localhost.private_key.pem'] to '/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pem'
==> puppet.demo: 2017-02-02 22:21:22,684 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.webserver.pcp-broker.ssl-crl-path]/value: value changed ['/opt/puppetlabs/server/data/orchestration-services/certs/orchestration-services.localhost.ca_crl.pem'] to '/etc/puppetlabs/puppet/ssl/crl.pem'
==> puppet.demo: 2017-02-02 22:21:22,694 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.web-router-service.broker-service]/value: value changed [{'metrics' => {'route' => '/', 'server' => 'pcp-broker'}, 'websocket' => {'route' => '/pcp', 'server' => 'pcp-broker'}}] to '{"websocket"=>{"route"=>"/pcp", "server"=>"pcp-broker"}, "v1"=>{"route"=>"/pcp", "server"=>"pcp-broker"}, "metrics"=>{"route"=>"/", "server"=>"pcp-broker"}}'
==> puppet.demo: 2017-02-02 22:21:22,710 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.webserver.orchestrator.client-auth]/value: value changed ['none'] to 'want'
==> puppet.demo: 2017-02-02 22:21:22,719 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.webserver.orchestrator.access-log-config]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,769 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.webserver.orchestrator.ssl-ca-cert]/value: value changed ['/opt/puppetlabs/server/data/orchestration-services/certs/orchestration-services.localhost.ca_cert.pem'] to '/etc/puppetlabs/puppet/ssl/certs/ca.pem'
==> puppet.demo: 2017-02-02 22:21:22,783 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.webserver.orchestrator.ssl-cert]/value: value changed ['/opt/puppetlabs/server/data/orchestration-services/certs/orchestration-services.localhost.cert.pem'] to '/etc/puppetlabs/orchestration-services/ssl/puppet.demo.cert.pem'
==> puppet.demo: 2017-02-02 22:21:22,796 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.webserver.orchestrator.ssl-key]/value: value changed ['/opt/puppetlabs/server/data/orchestration-services/certs/orchestration-services.localhost.private_key.pem'] to '/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pem'
==> puppet.demo: 2017-02-02 22:21:22,809 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.webserver.orchestrator.ssl-crl-path]/value: value changed ['/opt/puppetlabs/server/data/orchestration-services/certs/orchestration-services.localhost.ca_crl.pem'] to '/etc/puppetlabs/puppet/ssl/crl.pem'
==> puppet.demo: 2017-02-02 22:21:22,821 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.web-router-service.status-service]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,833 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Pe_hocon_setting[orchestration-services.web-router-service.metrics-webservice]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,839 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/File[/etc/puppetlabs/orchestration-services/ssl]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,845 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Jetty_ini/File[/etc/puppetlabs/puppetdb/conf.d/jetty.ini]/owner: owner changed 'root' to 'pe-puppetdb'
==> puppet.demo: 2017-02-02 22:21:22,846 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Jetty_ini/File[/etc/puppetlabs/puppetdb/conf.d/jetty.ini]/group: group changed 'root' to 'pe-puppetdb'
==> puppet.demo: 2017-02-02 22:21:22,847 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Jetty_ini/File[/etc/puppetlabs/puppetdb/conf.d/jetty.ini]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:21:22,851 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Jetty_ini/Pe_ini_setting[puppetdb_host]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,858 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Jetty_ini/Pe_ini_setting[puppetdb_sslhost]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,861 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Jetty_ini/Pe_ini_setting[puppetdb_sslport]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,865 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Jetty_ini/Pe_ini_setting[puppetdb_ssl_key]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,868 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Jetty_ini/Pe_ini_setting[puppetdb_ssl_cert]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,871 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Jetty_ini/Pe_ini_setting[puppetdb_ssl_ca_cert]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,877 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Jetty_ini/Pe_ini_setting[puppetdb_request_header_max_size]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,879 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Rbac_consumer_conf/File[/etc/puppetlabs/puppetdb/conf.d/rbac_consumer.conf]/owner: owner changed 'root' to 'pe-puppetdb'
==> puppet.demo: 2017-02-02 22:21:22,880 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Rbac_consumer_conf/File[/etc/puppetlabs/puppetdb/conf.d/rbac_consumer.conf]/group: group changed 'root' to 'pe-puppetdb'
==> puppet.demo: 2017-02-02 22:21:22,881 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Rbac_consumer_conf/File[/etc/puppetlabs/puppetdb/conf.d/rbac_consumer.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:21:22,892 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Rbac_consumer_conf/Pe_hocon_setting[puppetdb_rbac_consumer_ssl_key]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,896 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Rbac_consumer_conf/Pe_hocon_setting[puppetdb_rbac_consumer_ssl_cert]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,903 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Rbac_consumer_conf/Pe_hocon_setting[puppetdb_rbac_consumer_ssl_ca_cert]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,911 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Rbac_consumer_conf/Pe_hocon_setting[puppetdb_rbac_consumer_api_url]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,913 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Config_ini/File[/etc/puppetlabs/puppetdb/conf.d/config.ini]/owner: owner changed 'root' to 'pe-puppetdb'
==> puppet.demo: 2017-02-02 22:21:22,914 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Config_ini/File[/etc/puppetlabs/puppetdb/conf.d/config.ini]/group: group changed 'root' to 'pe-puppetdb'
==> puppet.demo: 2017-02-02 22:21:22,915 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Config_ini/File[/etc/puppetlabs/puppetdb/conf.d/config.ini]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:21:22,921 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Config_ini/Pe_ini_setting[config.ini threads command-processing section]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,926 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Config_ini/Pe_ini_setting[config.ini concurrent-writes command-processing section]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,928 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb/File[/var/log/puppetlabs/puppetdb]/mode: mode changed '0700' to '0750'
==> puppet.demo: 2017-02-02 22:21:22,937 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb/File[/var/log/puppetlabs/puppetdb/puppetdb.log]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,942 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb/Pe_ini_setting[pe-puppetdb initconf user]/value: value changed '"pe-puppetdb"' to 'pe-puppetdb'
==> puppet.demo: 2017-02-02 22:21:22,945 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb/Pe_ini_setting[pe-puppetdb initconf group]/value: value changed '"pe-puppetdb"' to 'pe-puppetdb'
==> puppet.demo: 2017-02-02 22:21:22,951 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Puppetdb/File[/etc/puppetlabs/puppetdb/ssl]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,960 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Puppetdb/File[/etc/puppetlabs/puppetdb/certificate-whitelist]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,962 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Jetty_ini/Pe_ini_setting[puppetdb-certificate-whitelist]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,969 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Certs/File[/opt/puppetlabs/server/data/console-services/certs]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,984 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.console.access-log-config]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,992 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.console.host]/ensure: created
==> puppet.demo: 2017-02-02 22:21:22,996 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.console.port]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,001 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.console.default-server]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,009 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.console.request-header-max-size]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,016 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.console.ssl-host]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,025 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.console.ssl-port]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,030 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.console.ssl-key]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,038 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.console.ssl-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,045 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.console.ssl-ca-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,057 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.console.client-auth]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,064 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.api.access-log-config]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,069 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.api.host]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,078 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.api.port]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,097 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.api.ssl-host]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,105 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.api.ssl-port]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,112 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.api.ssl-key]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,118 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.api.ssl-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,127 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.api.ssl-ca-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,139 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[webserver.api.client-auth]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,155 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[web-router-service."puppetlabs.activity.services/activity-service"]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,162 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[web-router-service."puppetlabs.rbac.services.http.api/rbac-http-api-service"]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,176 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[web-router-service."puppetlabs.pe-console-ui.service/pe-console-ui-service".pe-console-app]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,185 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[web-router-service."puppetlabs.pe-console-auth-ui.service/pe-console-auth-ui-service".authn-app]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,210 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[web-router-service."puppetlabs.classifier.main/classifier-service"]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,220 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[web-router-service."puppetlabs.trapperkeeper.services.status.status-service/status-service"]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,264 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/File[/etc/puppetlabs/console-services/conf.d/global.conf]/owner: owner changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:21:23,265 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/File[/etc/puppetlabs/console-services/conf.d/global.conf]/group: group changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:21:23,265 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/File[/etc/puppetlabs/console-services/conf.d/global.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:21:23,268 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[global.logging-config]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,276 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[global.version-path]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,279 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[global.login-path]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,282 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_hocon_setting[global.replication-mode]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,289 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/File[/etc/puppetlabs/console-services/rbac-certificate-whitelist]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,301 - [Notice]: /Stage[main]/Pe_install::Install/File[/opt/puppetlabs/server/bin/set_console_admin_password.rb]/ensure: defined content as '{md5}8122ef7746d5adc56aae08b14d96524e'
==> puppet.demo: 2017-02-02 22:21:23,310 - [Notice]: /Stage[main]/Pe_infrastructure::Puppet_infra_shims/File[/opt/puppetlabs/server/apps/enterprise]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,313 - [Notice]: /Stage[main]/Pe_infrastructure::Puppet_infra_shims/File[/opt/puppetlabs/server/apps/enterprise/bin]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,319 - [Notice]: /Stage[main]/Pe_infrastructure::Puppet_infra_shims/File[/opt/puppetlabs/server/apps/enterprise/bin/puppet-infra]/ensure: defined content as '{md5}bc81e112583ded55c7c9d12852f508f7'
==> puppet.demo: 2017-02-02 22:21:23,323 - [Notice]: /Stage[main]/Pe_infrastructure::Puppet_infra_shims/File[/opt/puppetlabs/bin/puppet-infra]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,338 - [Notice]: /Stage[main]/Pe_infrastructure::Puppet_infra_shims/File[/opt/puppetlabs/server/apps/enterprise/bin/puppet-infrastructure]/ensure: defined content as '{md5}bc81e112583ded55c7c9d12852f508f7'
==> puppet.demo: 2017-02-02 22:21:23,344 - [Notice]: /Stage[main]/Pe_infrastructure::Puppet_infra_shims/File[/opt/puppetlabs/bin/puppet-infrastructure]/ensure: created
==> puppet.demo: 2017-02-02 22:21:23,475 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Puppet_enterprise::Fileserver_conf[pe_packages]/Augeas[fileserver.conf pe_packages]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:23,607 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Broker[remove default localhost]/Augeas[localhost: AMQ broker: remove default localhost]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:23,712 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Broker[puppet.demo]/Augeas[puppet.demo: AMQ broker: puppet.demo]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:23,812 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Ssl_context[puppet.demo-ssl-context]/Augeas[puppet.demo: AMQ sslContext: puppet.demo-ssl-context]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:23,910 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Management_context[puppet.demo - managementContext]/Augeas[puppet.demo: AMQ managementContext: puppet.demo - managementContext]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:24,008 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Destination_policy_entry[puppet.demo-topic->]/Augeas[puppet.demo: AMQ destinationPolicyEntry: puppet.demo-topic->]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:24,122 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Destination_policy_entry[puppet.demo-queue->]/Augeas[puppet.demo: AMQ destinationPolicyEntry: puppet.demo-queue->]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:24,229 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Destination_policy_entry[puppet.demo-queue-*.reply.>]/Augeas[puppet.demo: AMQ destinationPolicyEntry: puppet.demo-queue-*.reply.>]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:24,327 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Transport_connector[puppet.demo-openwire-transport]/Augeas[puppet.demo: AMQ transportConnector: puppet.demo-openwire-transport]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:24,429 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Transport_connector[puppet.demo-stomp-transport]/Augeas[puppet.demo: AMQ transportConnector: puppet.demo-stomp-transport]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:24,535 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Statistics_broker_plugin[puppet.demo-statisticsBrokerPlugin]/Augeas[puppet.demo: AMQ statisticsBrokerPlugin: puppet.demo-statisticsBrokerPlugin]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:24,649 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Timestamping_broker_plugin[puppet.demo-timeStampingBrokerPlugin]/Augeas[puppet.demo: AMQ timeStampingBrokerPlugin: puppet.demo-timeStampingBrokerPlugin]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:24,756 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Simple_authentication_user[puppet.demo-simple_auth_user-mcollective]/Augeas[puppet.demo: AMQ simpleAuthentication user: puppet.demo-simple_auth_user-mcollective]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:24,858 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Authorization_plugin_entry[puppet.demo-authorization-queue->]/Augeas[puppet.demo: AMQ authorizationPlugin entry: puppet.demo-authorization-queue->]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:24,963 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Authorization_plugin_entry[puppet.demo-authorization-topic->]/Augeas[puppet.demo: AMQ authorizationPlugin entry: puppet.demo-authorization-topic->]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:25,074 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Authorization_plugin_entry[puppet.demo-authorization-queue-mcollective.>]/Augeas[puppet.demo: AMQ authorizationPlugin entry: puppet.demo-authorization-queue-mcollective.>]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:25,188 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Authorization_plugin_entry[puppet.demo-authorization-topic-mcollective.>]/Augeas[puppet.demo: AMQ authorizationPlugin entry: puppet.demo-authorization-topic-mcollective.>]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:25,296 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Authorization_plugin_entry[puppet.demo-authorization-topic-ActiveMQ.Advisory.>]/Augeas[puppet.demo: AMQ authorizationPlugin entry: puppet.demo-authorization-topic-ActiveMQ.Advisory.>]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:25,394 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::Web_console[puppet.demo - web console - false]/Augeas[AMQ webConsole: puppet.demo - web console - false]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:25,497 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Amq::Broker/Puppet_enterprise::Amq::Config::System_usage[puppet.demo - systemusage]/Augeas[puppet.demo: AMQ systemUsage: puppet.demo - systemusage]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:25,837 - [Notice]: /Stage[main]/Puppet_enterprise::Amq::Service/Service[pe-activemq]/ensure: ensure changed 'stopped' to 'running'
==> puppet.demo: 2017-02-02 22:21:25,842 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/File[/etc/puppetlabs/orchestration-services/conf.d/orchestrator.conf]/owner: owner changed 'root' to 'pe-orchestration-services'
==> puppet.demo: 2017-02-02 22:21:25,843 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/File[/etc/puppetlabs/orchestration-services/conf.d/orchestrator.conf]/group: group changed 'root' to 'pe-orchestration-services'
==> puppet.demo: 2017-02-02 22:21:25,843 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/File[/etc/puppetlabs/orchestration-services/conf.d/orchestrator.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:21:25,854 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.orchestrator.master-url]/value: value changed ['https://puppet:8140'] to 'https://puppet.demo:8140'
==> puppet.demo: 2017-02-02 22:21:25,863 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.orchestrator.puppetdb-url]/value: value changed ['https://puppetdb:8081'] to 'https://puppet.demo:8081'
==> puppet.demo: 2017-02-02 22:21:25,870 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.orchestrator.classifier-service]/value: value changed ['https://classifier:4433/classifier-api'] to 'https://puppet.demo:4433/classifier-api'
==> puppet.demo: 2017-02-02 22:21:25,888 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.orchestrator.console-services-url]/ensure: created
==> puppet.demo: 2017-02-02 22:21:25,898 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.rbac-consumer.api-url]/ensure: created
==> puppet.demo: 2017-02-02 22:21:25,922 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.activity-consumer.api-url]/ensure: created
==> puppet.demo: 2017-02-02 22:21:25,932 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.orchestrator.pcp-broker-url]/ensure: created
==> puppet.demo: 2017-02-02 22:21:25,940 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.orchestrator.console-url]/ensure: created
==> puppet.demo: 2017-02-02 22:21:25,960 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.orchestrator.ssl-ca-cert]/value: value changed ['ca-cert.pem'] to '/etc/puppetlabs/puppet/ssl/certs/ca.pem'
==> puppet.demo: 2017-02-02 22:21:25,976 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.orchestrator.ssl-cert]/value: value changed ['cert.pem'] to '/etc/puppetlabs/orchestration-services/ssl/puppet.demo.cert.pem'
==> puppet.demo: 2017-02-02 22:21:25,997 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.orchestrator.ssl-key]/value: value changed ['key.pem'] to '/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pem'
==> puppet.demo: 2017-02-02 22:21:26,046 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.orchestrator.database.subname]/value: value changed ['//localhost:5432/orchestrator'] to '//puppet.demo:5432/pe-orchestrator?ssl=true&sslfactory=org.postgresql.ssl.jdbc4.LibPQFactory&sslmode=verify-full&sslrootcert=/etc/puppetlabs/puppet/ssl/certs/ca.pem&sslkey=/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pk8&sslcert=/etc/puppetlabs/puppet/ssl/certs/puppet.demo.pem'
==> puppet.demo: 2017-02-02 22:21:26,061 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.orchestrator.database.user]/value: value changed ['orchestrator'] to 'pe-orchestrator-write'
==> puppet.demo: 2017-02-02 22:21:26,069 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Pe_hocon_setting[orchestration-services.orchestrator.database.migration-user]/ensure: created
==> puppet.demo: 2017-02-02 22:21:26,076 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/File[/etc/puppetlabs/orchestration-services/conf.d/pcp-broker.conf]/owner: owner changed 'root' to 'pe-orchestration-services'
==> puppet.demo: 2017-02-02 22:21:26,076 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/File[/etc/puppetlabs/orchestration-services/conf.d/pcp-broker.conf]/group: group changed 'root' to 'pe-orchestration-services'
==> puppet.demo: 2017-02-02 22:21:26,078 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/File[/etc/puppetlabs/orchestration-services/conf.d/pcp-broker.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:21:26,089 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/Pe_hocon_setting[orchestration-services.pcp-broker.accept-consumers]/ensure: created
==> puppet.demo: 2017-02-02 22:21:26,097 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/Pe_hocon_setting[orchestration-services.pcp-broker.delivery-consumers]/ensure: created
==> puppet.demo: 2017-02-02 22:21:26,099 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/File[/etc/puppetlabs/orchestration-services/conf.d/authorization.conf]/owner: owner changed 'root' to 'pe-orchestration-services'
==> puppet.demo: 2017-02-02 22:21:26,101 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/File[/etc/puppetlabs/orchestration-services/conf.d/authorization.conf]/group: group changed 'root' to 'pe-orchestration-services'
==> puppet.demo: 2017-02-02 22:21:26,101 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/File[/etc/puppetlabs/orchestration-services/conf.d/authorization.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:21:26,132 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Certs[puppet.demo]/File[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.cert.pem]/ensure: defined content as '{md5}56d99eabb442b5f760c2d3954322db17'
==> puppet.demo: 2017-02-02 22:21:26,155 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Certs[puppet.demo]/File[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pem]/ensure: defined content as '{md5}9d42b8c175ca315355d5e424c00d7523'
==> puppet.demo: 2017-02-02 22:21:26,199 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Certs[puppet.demo]/File[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.public_key.pem]/ensure: defined content as '{md5}f297d2a3b3d9e8de223be7e1ca4deec3'
==> puppet.demo: 2017-02-02 22:21:26,253 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Certs::Pk8_cert[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pk8]/Exec[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pk8]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:26,255 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Certs::Pk8_cert[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pk8]/File[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pk8]/owner: owner changed 'root' to 'pe-orchestration-services'
==> puppet.demo: 2017-02-02 22:21:26,256 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Certs::Pk8_cert[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pk8]/File[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pk8]/group: group changed 'root' to 'pe-orchestration-services'
==> puppet.demo: 2017-02-02 22:21:26,256 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Certs::Pk8_cert[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pk8]/File[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pk8]/mode: mode changed '0644' to '0400'
==> puppet.demo: 2017-02-02 22:21:26,258 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Certs::Pk8_cert[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pk8]/File[/etc/puppetlabs/orchestration-services/ssl/puppet.demo.private_key.pk8]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:21:26,263 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Java_args[orchestration-services]/Pe_ini_subsetting[pe-orchestration-services_'Xmx']/value: value changed '2g' to '192m'
==> puppet.demo: 2017-02-02 22:21:26,267 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Java_args[orchestration-services]/Pe_ini_subsetting[pe-orchestration-services_'Xms']/ensure: created
==> puppet.demo: 2017-02-02 22:21:26,405 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Certificate_authority/Pe_puppet_authorization::Rule[puppetlabs certificate status]/Pe_puppet_authorization_hocon_rule[rule-puppetlabs certificate status]/ensure: created
==> puppet.demo: 2017-02-02 22:21:26,455 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Certificate_authority/Puppet_enterprise::Fileserver_conf[pe_modules]/Augeas[fileserver.conf pe_modules]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:21:26,577 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules]/ensure: created
==> puppet.demo: 2017-02-02 22:21:26,584 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/install_modules.txt]/ensure: defined content as '{md5}c61c37402a8cfff5955bbcd82a6da378'
==> puppet.demo: 2017-02-02 22:21:26,590 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_accounts-2.0.2-6-gd2f698c.tar.gz]/ensure: defined content as '{md5}c3c2553cee99eae2ff0b600be8aeea60'
==> puppet.demo: 2017-02-02 22:21:26,596 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_concat-1.1.2-7-g77ec55b.tar.gz]/ensure: defined content as '{md5}afda3cb036181703efb3c17f2f3701a5'
==> puppet.demo: 2017-02-02 22:21:26,603 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_console_prune-0.1.1-9-gfc256c0.tar.gz]/ensure: defined content as '{md5}63338cd0b44b0539c9cb82a91c60bd96'
==> puppet.demo: 2017-02-02 22:21:26,615 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_hocon-2016.2.0.tar.gz]/ensure: defined content as '{md5}b780d51a69610fc46f3b0a2d1a4438fa'
==> puppet.demo: 2017-02-02 22:21:26,632 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_infrastructure-2016.5.0.tar.gz]/ensure: defined content as '{md5}07a600f0c8a8c3094b18cb26ef8c59d0'
==> puppet.demo: 2017-02-02 22:21:26,640 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_inifile-2016.5.0.tar.gz]/ensure: defined content as '{md5}bc19fa541a3b4bdd864c93f51505428e'
==> puppet.demo: 2017-02-02 22:21:26,647 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_install-2016.5.0.tar.gz]/ensure: defined content as '{md5}cb4fa3c48cba4d1048b2268333bc9a03'
==> puppet.demo: 2017-02-02 22:21:26,653 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_java_ks-1.2.4-37-g2d86015.tar.gz]/ensure: defined content as '{md5}000cbab6af4ef88b0c2a2ae96bca7cdd'
==> puppet.demo: 2017-02-02 22:21:26,668 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_manager-2016.5.0.tar.gz]/ensure: defined content as '{md5}14841cf3170b5a444d4bf8d3249d02cb'
==> puppet.demo: 2017-02-02 22:21:26,678 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_nginx-2016.4.0.tar.gz]/ensure: defined content as '{md5}3b433d9d1c0b9830f4e4f69b82565372'
==> puppet.demo: 2017-02-02 22:21:26,685 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_postgresql-2016.5.0.tar.gz]/ensure: defined content as '{md5}7d920b7f582f59621f6307f0dc56099a'
==> puppet.demo: 2017-02-02 22:21:26,708 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_puppet_authorization-2016.2.0-rc1.tar.gz]/ensure: defined content as '{md5}ce529e58399cf417386fe23986d126a1'
==> puppet.demo: 2017-02-02 22:21:26,732 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_r10k-2016.2.0.tar.gz]/ensure: defined content as '{md5}5ff7e9a7a09ee88069ef331438c681b4'
==> puppet.demo: 2017-02-02 22:21:26,749 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_razor-1.0.1.tar.gz]/ensure: defined content as '{md5}c18d50a381452a05b409aebac6bdcc5b'
==> puppet.demo: 2017-02-02 22:21:26,796 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_repo-2016.5.0.tar.gz]/ensure: defined content as '{md5}65602d41e4e92a200469afdfe5dc37d9'
==> puppet.demo: 2017-02-02 22:21:26,820 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_staging-2015.3.0.tar.gz]/ensure: defined content as '{md5}a28dd759b8cb77d213b1a0176884b86f'
==> puppet.demo: 2017-02-02 22:21:26,850 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-pe_support_script-2016.5.0.tar.gz]/ensure: defined content as '{md5}cf615629d2f9a8bb4b9944b58b44f199'
==> puppet.demo: 2017-02-02 22:21:26,889 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/puppetlabs-puppet_enterprise-2016.5.0.tar.gz]/ensure: defined content as '{md5}5fc06e3b304b09993b97d39091d70272'
==> puppet.demo: 2017-02-02 22:21:26,915 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/File[/opt/puppetlabs/server/share/puppet_enterprise/pe_modules/install.sh]/ensure: defined content as '{md5}ce7a986aa077097b7def8ce0e7f30d72'
==> puppet.demo: 2017-02-02 22:22:00,157 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Exec[Extract PE Modules]: Triggered 'refresh' from 1 events
==> puppet.demo: 2017-02-02 22:22:00,160 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Database_ini/Puppet_enterprise::Puppetdb::Shared_database_settings[database]/File[/etc/puppetlabs/puppetdb/conf.d/database.ini]/owner: owner changed 'root' to 'pe-puppetdb'
==> puppet.demo: 2017-02-02 22:22:00,162 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Database_ini/Puppet_enterprise::Puppetdb::Shared_database_settings[database]/File[/etc/puppetlabs/puppetdb/conf.d/database.ini]/group: group changed 'root' to 'pe-puppetdb'
==> puppet.demo: 2017-02-02 22:22:00,163 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Database_ini/Puppet_enterprise::Puppetdb::Shared_database_settings[database]/File[/etc/puppetlabs/puppetdb/conf.d/database.ini]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:22:00,167 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Database_ini/Pe_ini_setting[puppetdb_gc_interval]/ensure: created
==> puppet.demo: 2017-02-02 22:22:00,169 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Database_ini/Pe_ini_setting[puppetdb_node_ttl]/ensure: created
==> puppet.demo: 2017-02-02 22:22:00,171 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Database_ini/Pe_ini_setting[puppetdb_node_purge_ttl]/ensure: created
==> puppet.demo: 2017-02-02 22:22:00,174 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Database_ini/Pe_ini_setting[puppetdb_report_ttl]/ensure: created
==> puppet.demo: 2017-02-02 22:22:00,176 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Database_ini/Puppet_enterprise::Puppetdb::Shared_database_settings[database]/Pe_ini_setting[[database]-puppetdb_psdatabase_username]/ensure: created
==> puppet.demo: 2017-02-02 22:22:00,179 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Database_ini/Puppet_enterprise::Puppetdb::Shared_database_settings[database]/Pe_ini_setting[[database]-puppetdb_subname]/value: value changed '//localhost:5432/puppetdb' to '//puppet.demo:5432/pe-puppetdb?ssl=true&sslfactory=org.postgresql.ssl.jdbc4.LibPQFactory&sslmode=verify-full&sslrootcert=/etc/puppetlabs/puppet/ssl/certs/ca.pem&sslkey=/etc/puppetlabs/puppetdb/ssl/puppet.demo.private_key.pk8&sslcert=/etc/puppetlabs/puppetdb/ssl/puppet.demo.cert.pem'
==> puppet.demo: 2017-02-02 22:22:00,182 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Database_ini/Puppet_enterprise::Puppetdb::Shared_database_settings[database]/Pe_ini_setting[[database]-maximum-pool-size]/ensure: created
==> puppet.demo: 2017-02-02 22:22:00,188 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb/Puppet_enterprise::Puppetdb::Shared_database_settings[read-database]/File[/etc/puppetlabs/puppetdb/conf.d/read_database.ini]/ensure: created
==> puppet.demo: 2017-02-02 22:22:00,193 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb/Puppet_enterprise::Puppetdb::Shared_database_settings[read-database]/Pe_ini_setting[[read-database]-puppetdb_psdatabase_username]/ensure: created
==> puppet.demo: 2017-02-02 22:22:00,194 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb/Puppet_enterprise::Puppetdb::Shared_database_settings[read-database]/Pe_ini_setting[[read-database]-puppetdb_subname]/ensure: created
==> puppet.demo: 2017-02-02 22:22:00,202 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb/Puppet_enterprise::Puppetdb::Shared_database_settings[read-database]/Pe_ini_setting[[read-database]-maximum-pool-size]/ensure: created
==> puppet.demo: 2017-02-02 22:22:00,205 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb/Puppet_enterprise::Trapperkeeper::Java_args[puppetdb]/Pe_ini_subsetting[pe-puppetdb_'Xmx']/value: value changed '192m' to '256m'
==> puppet.demo: 2017-02-02 22:22:00,208 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb/Puppet_enterprise::Trapperkeeper::Java_args[puppetdb]/Pe_ini_subsetting[pe-puppetdb_'Xms']/ensure: created
==> puppet.demo: 2017-02-02 22:22:00,227 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Puppetdb/Puppet_enterprise::Certs[pe-puppetdb]/File[/etc/puppetlabs/puppetdb/ssl/puppet.demo.cert.pem]/ensure: defined content as '{md5}56d99eabb442b5f760c2d3954322db17'
==> puppet.demo: 2017-02-02 22:22:00,238 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Puppetdb/Puppet_enterprise::Certs[pe-puppetdb]/File[/etc/puppetlabs/puppetdb/ssl/puppet.demo.private_key.pem]/ensure: defined content as '{md5}9d42b8c175ca315355d5e424c00d7523'
==> puppet.demo: 2017-02-02 22:22:00,245 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Puppetdb/Puppet_enterprise::Certs[pe-puppetdb]/File[/etc/puppetlabs/puppetdb/ssl/puppet.demo.public_key.pem]/ensure: defined content as '{md5}f297d2a3b3d9e8de223be7e1ca4deec3'
==> puppet.demo: 2017-02-02 22:22:00,269 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Puppetdb/Puppet_enterprise::Certs::Pk8_cert[/etc/puppetlabs/puppetdb/ssl/puppet.demo.private_key.pk8]/Exec[/etc/puppetlabs/puppetdb/ssl/puppet.demo.private_key.pk8]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:00,270 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Puppetdb/Puppet_enterprise::Certs::Pk8_cert[/etc/puppetlabs/puppetdb/ssl/puppet.demo.private_key.pk8]/File[/etc/puppetlabs/puppetdb/ssl/puppet.demo.private_key.pk8]/owner: owner changed 'root' to 'pe-puppetdb'
==> puppet.demo: 2017-02-02 22:22:00,271 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Puppetdb/Puppet_enterprise::Certs::Pk8_cert[/etc/puppetlabs/puppetdb/ssl/puppet.demo.private_key.pk8]/File[/etc/puppetlabs/puppetdb/ssl/puppet.demo.private_key.pk8]/group: group changed 'root' to 'pe-puppetdb'
==> puppet.demo: 2017-02-02 22:22:00,271 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Puppetdb/Puppet_enterprise::Certs::Pk8_cert[/etc/puppetlabs/puppetdb/ssl/puppet.demo.private_key.pk8]/File[/etc/puppetlabs/puppetdb/ssl/puppet.demo.private_key.pk8]/mode: mode changed '0644' to '0400'
==> puppet.demo: 2017-02-02 22:22:00,273 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Puppetdb/Puppet_enterprise::Certs::Pk8_cert[/etc/puppetlabs/puppetdb/ssl/puppet.demo.private_key.pk8]/File[/etc/puppetlabs/puppetdb/ssl/puppet.demo.private_key.pk8]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:22:00,278 - [Notice]: /Stage[main]/Puppet_enterprise::Certs::Puppetdb_whitelist/Puppet_enterprise::Certs::Whitelist_entry[puppet_enterprise::certs::puppetdb_whitelist entry: puppet.demo]/Pe_file_line[/etc/puppetlabs/puppetdb/certificate-whitelist:puppet.demo]/ensure: created
==> puppet.demo: 2017-02-02 22:22:37,784 - [Notice]: /Stage[main]/Puppet_enterprise::Puppetdb::Service/Service[pe-puppetdb]/ensure: ensure changed 'stopped' to 'running'
==> puppet.demo: 2017-02-02 22:22:37,816 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Certs/Puppet_enterprise::Certs[pe-console-services::server_cert]/File[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.cert.pem]/ensure: defined content as '{md5}56d99eabb442b5f760c2d3954322db17'
==> puppet.demo: 2017-02-02 22:22:37,838 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Certs/Puppet_enterprise::Certs[pe-console-services::server_cert]/File[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.private_key.pem]/ensure: defined content as '{md5}9d42b8c175ca315355d5e424c00d7523'
==> puppet.demo: 2017-02-02 22:22:37,868 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Certs/Puppet_enterprise::Certs[pe-console-services::server_cert]/File[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.public_key.pem]/ensure: defined content as '{md5}f297d2a3b3d9e8de223be7e1ca4deec3'
==> puppet.demo: 2017-02-02 22:22:37,871 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/File[/etc/puppetlabs/console-services/conf.d/webserver.conf]/owner: owner changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:22:37,875 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/File[/etc/puppetlabs/console-services/conf.d/webserver.conf]/group: group changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:22:37,880 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/File[/etc/puppetlabs/console-services/conf.d/webserver.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:22:38,000 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Certs/Puppet_enterprise::Certs::Pk8_cert[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.private_key.pk8]/Exec[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.private_key.pk8]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:38,002 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Certs/Puppet_enterprise::Certs::Pk8_cert[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.private_key.pk8]/File[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.private_key.pk8]/owner: owner changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:22:38,003 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Certs/Puppet_enterprise::Certs::Pk8_cert[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.private_key.pk8]/File[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.private_key.pk8]/group: group changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:22:38,003 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Certs/Puppet_enterprise::Certs::Pk8_cert[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.private_key.pk8]/File[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.private_key.pk8]/mode: mode changed '0644' to '0400'
==> puppet.demo: 2017-02-02 22:22:38,005 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Certs/Puppet_enterprise::Certs::Pk8_cert[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.private_key.pk8]/File[/opt/puppetlabs/server/data/console-services/certs/puppet.demo.private_key.pk8]/seluser: seluser changed 'unconfined_u' to 'system_u'
==> puppet.demo: 2017-02-02 22:22:38,013 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/File[/etc/puppetlabs/nginx/conf.d/proxy.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,066 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/File[/etc/puppetlabs/nginx/dhparam_puppetproxy.pem]/ensure: defined content as '{md5}4d695d75538adacfce6333a83bd7b015'
==> puppet.demo: 2017-02-02 22:22:38,074 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_concat[/etc/puppetlabs/console-services/bootstrap.cfg]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,087 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_concat[/etc/puppetlabs/console-services/bootstrap.cfg]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,090 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_concat[/etc/puppetlabs/console-services/bootstrap.cfg]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments.concat]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,098 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_concat[/etc/puppetlabs/console-services/bootstrap.cfg]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments.concat.out]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,105 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/File[/etc/puppetlabs/console-services/conf.d/activity.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,110 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/Pe_hocon_setting[activity.rbac-base-url]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,112 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/Pe_hocon_setting[activity.cors-origin-pattern]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,117 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/File[/etc/puppetlabs/console-services/conf.d/activity-database.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,121 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/Pe_hocon_setting[activity.database.subprotocol]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,132 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/Pe_hocon_setting[activity.database.subname]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,140 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/Pe_hocon_setting[activity.database.user]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,146 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/Pe_hocon_setting[activity.database.migration-user]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,160 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/Pe_hocon_setting[activity.database.maximum-pool-size]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,169 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/Pe_hocon_setting[activity.database.connection-timeout]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,178 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/Pe_hocon_setting[activity.database.connection-check-timeout]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,181 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/File[/etc/puppetlabs/console-services/conf.d/rbac.conf]/owner: owner changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:22:38,182 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/File[/etc/puppetlabs/console-services/conf.d/rbac.conf]/group: group changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:22:38,182 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/File[/etc/puppetlabs/console-services/conf.d/rbac.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:22:38,187 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Pe_hocon_setting[console-services.rbac.certificate-whitelist]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,247 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Pe_hocon_setting[console-services.rbac.token-private-key]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,251 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Pe_hocon_setting[console-services.rbac.token-public-key]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,254 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Pe_hocon_setting[console-services.rbac.token-maximum-lifetime]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,275 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/File[/etc/puppetlabs/console-services/conf.d/rbac-database.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,278 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Pe_hocon_setting[console-services.rbac.database.subprotocol]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,282 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Pe_hocon_setting[console-services.rbac.database.subname]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,287 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Pe_hocon_setting[console-services.rbac.database.user]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,296 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Pe_hocon_setting[console-services.rbac.database.migration-user]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,306 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Pe_hocon_setting[console-services.rbac.database.maximum-pool-size]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,314 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Pe_hocon_setting[console-services.rbac.database.connection-timeout]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,319 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Pe_hocon_setting[console-services.rbac.database.connection-check-timeout]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,327 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Certs::Whitelist_entry[rbac cert whitelist entry: puppet.demo]/Pe_file_line[/etc/puppetlabs/console-services/rbac-certificate-whitelist:puppet.demo]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,331 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/File[/etc/puppetlabs/console-services/conf.d/classifier.conf]/owner: owner changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:22:38,332 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/File[/etc/puppetlabs/console-services/conf.d/classifier.conf]/group: group changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:22:38,332 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/File[/etc/puppetlabs/console-services/conf.d/classifier.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:22:38,335 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/Pe_hocon_setting[console-services.classifier.puppet-master]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,338 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/Pe_hocon_setting[console-services.classifier.ssl-key]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,345 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/Pe_hocon_setting[console-services.classifier.ssl-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,349 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/Pe_hocon_setting[console-services.classifier.ssl-ca-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,355 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/Pe_hocon_setting[console-services.classifier.synchronization-period]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,363 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/Pe_hocon_setting[console-services.classifier.prune-days-threshold]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,366 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/File[/etc/puppetlabs/console-services/conf.d/classifier-database.conf]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,369 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/Pe_hocon_setting[classifier.database.subprotocol]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,372 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/Pe_hocon_setting[console-services.classifier.database.subname]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,375 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/Pe_hocon_setting[console-services.classifier.database.user]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,379 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/Pe_hocon_setting[console-services.classifier.database.migration-user]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,382 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/File[/etc/puppetlabs/console-services/conf.d/console.conf]/owner: owner changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:22:38,382 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/File[/etc/puppetlabs/console-services/conf.d/console.conf]/group: group changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:22:38,382 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/File[/etc/puppetlabs/console-services/conf.d/console.conf]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:22:38,386 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.assets-dir]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,388 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.puppet-master]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,391 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.rbac-server]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,396 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.classifier-server]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,404 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.activity-server]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,414 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.orchestrator-server]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,423 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.display-local-time]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,427 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.puppetdb-server]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,432 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.certs.ssl-key]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,438 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.certs.ssl-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,453 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.certs.ssl-ca-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,462 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.proxy-idle-timeout]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,468 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.license-key]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,480 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.pcp-broker-url]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,487 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.certs.pcp-ssl-key]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,499 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.certs.pcp-ssl-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,514 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.certs.pcp-ssl-ca-cert]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,520 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.pcp-client-type]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,533 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.pcp-request-timeout]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,546 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.service-alert]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,553 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.service-alert-timeout]/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,562 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/File[/etc/puppetlabs/console-services/conf.d/console_secret_key.conf]/ensure: defined content as '{md5}61714d01d2cb3d0bd9bdb97ff75e6cc3'
==> puppet.demo: 2017-02-02 22:22:38,571 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Java_args[console-services]/Pe_ini_subsetting[pe-console-services_'Xmx']/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,578 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Java_args[console-services]/Pe_ini_subsetting[pe-console-services_'Xms']/ensure: created
==> puppet.demo: 2017-02-02 22:22:38,626 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[server_name]/Augeas[pe_nginx::directive for server_name]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:38,679 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[listen]/Augeas[pe_nginx::directive for listen]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:38,726 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[ssl_certificate]/Augeas[pe_nginx::directive for ssl_certificate]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:38,778 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[ssl_certificate_key]/Augeas[pe_nginx::directive for ssl_certificate_key]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:38,828 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[ssl_crl]/Augeas[pe_nginx::directive for ssl_crl]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:38,875 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[ssl_prefer_server_ciphers]/Augeas[pe_nginx::directive for ssl_prefer_server_ciphers]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:38,929 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[ssl_ciphers]/Augeas[pe_nginx::directive for ssl_ciphers]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:38,983 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[ssl_protocols]/Augeas[pe_nginx::directive for ssl_protocols]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,036 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[ssl_dhparam]/Augeas[pe_nginx::directive for ssl_dhparam]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,085 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[ssl_verify_client]/Augeas[pe_nginx::directive for ssl_verify_client]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,135 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[ssl_verify_depth]/Augeas[pe_nginx::directive for ssl_verify_depth]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,180 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[ssl_session_timeout]/Augeas[pe_nginx::directive for ssl_session_timeout]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,234 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[ssl_session_cache]/Augeas[pe_nginx::directive for ssl_session_cache]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,286 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[proxy_pass]/Augeas[pe_nginx::directive for proxy_pass]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,332 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[proxy_redirect]/Augeas[pe_nginx::directive for proxy_redirect]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,388 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[proxy_read_timeout]/Augeas[pe_nginx::directive for proxy_read_timeout]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,443 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[proxy_set_header x-ssl-subject]/Augeas[pe_nginx::directive for proxy_set_header x-ssl-subject]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,491 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[proxy_set_header x-client-dn]/Augeas[pe_nginx::directive for proxy_set_header x-client-dn]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,546 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[proxy_set_header x-client-verify]/Augeas[pe_nginx::directive for proxy_set_header x-client-verify]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,600 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Proxy/Pe_nginx::Directive[proxy_set_header x-forwarded-for]/Augeas[pe_nginx::directive for proxy_set_header x-forwarded-for]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:39,809 - [Notice]: /Stage[main]/Pe_nginx/Service[pe-nginx]/ensure: ensure changed 'stopped' to 'running'
==> puppet.demo: 2017-02-02 22:22:39,816 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[certificate-authority-service]/Pe_concat[/etc/puppetlabs/puppetserver/bootstrap.cfg]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg]/ensure: created
==> puppet.demo: 2017-02-02 22:22:39,826 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[certificate-authority-service]/Pe_concat[/etc/puppetlabs/puppetserver/bootstrap.cfg]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments]/ensure: created
==> puppet.demo: 2017-02-02 22:22:39,831 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[certificate-authority-service]/Pe_concat[/etc/puppetlabs/puppetserver/bootstrap.cfg]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments.concat]/ensure: created
==> puppet.demo: 2017-02-02 22:22:39,837 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[certificate-authority-service]/Pe_concat[/etc/puppetlabs/puppetserver/bootstrap.cfg]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments.concat.out]/ensure: created
==> puppet.demo: 2017-02-02 22:22:39,847 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[certificate-authority-service]/Pe_concat::Fragment[puppetserver certificate-authority-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver certificate-authority-service]/ensure: defined content as '{md5}386c6767f62267ecd4c8ebbf38205b91'
==> puppet.demo: 2017-02-02 22:22:39,854 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[puppetserver:master jetty9-service]/Pe_concat::Fragment[puppetserver jetty9-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver jetty9-service]/ensure: defined content as '{md5}9ad7a87cc2b4b19be088e8307c55a9fe'
==> puppet.demo: 2017-02-02 22:22:39,867 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[pe-master-service]/Pe_concat::Fragment[puppetserver pe-master-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver pe-master-service]/ensure: defined content as '{md5}cf957034fe8f6f43bc3ee7f51c5ade11'
==> puppet.demo: 2017-02-02 22:22:39,879 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[request-handler-service]/Pe_concat::Fragment[puppetserver request-handler-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver request-handler-service]/ensure: defined content as '{md5}293dd489b96822c81b6b2cf74fbb420e'
==> puppet.demo: 2017-02-02 22:22:39,886 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[jruby-puppet-pooled-service]/Pe_concat::Fragment[puppetserver jruby-puppet-pooled-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver jruby-puppet-pooled-service]/ensure: defined content as '{md5}6ab00d0cb043bdc78de452e0c9410fd5'
==> puppet.demo: 2017-02-02 22:22:39,898 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[jruby-pool-manager-service]/Pe_concat::Fragment[puppetserver jruby-pool-manager-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver jruby-pool-manager-service]/ensure: defined content as '{md5}98be696c338e8326bbf2fc5620089984'
==> puppet.demo: 2017-02-02 22:22:39,908 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[metrics-puppet-profiler-service]/Pe_concat::Fragment[puppetserver metrics-puppet-profiler-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver metrics-puppet-profiler-service]/ensure: defined content as '{md5}65ead768de3372c4e0dc0413386736f7'
==> puppet.demo: 2017-02-02 22:22:39,918 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[pe-metrics-service]/Pe_concat::Fragment[puppetserver pe-metrics-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver pe-metrics-service]/ensure: defined content as '{md5}99a6354ce0d6abfbcaa02e763ff3bd3e'
==> puppet.demo: 2017-02-02 22:22:39,933 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[puppet-server-config-service]/Pe_concat::Fragment[puppetserver puppet-server-config-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver puppet-server-config-service]/ensure: defined content as '{md5}2ae1c78b8a39d5e5e4fec6cdbfec4093'
==> puppet.demo: 2017-02-02 22:22:39,945 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[puppet-admin-service]/Pe_concat::Fragment[puppetserver puppet-admin-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver puppet-admin-service]/ensure: defined content as '{md5}4557e6371b9fde9075e3fe3f0fceb064'
==> puppet.demo: 2017-02-02 22:22:39,959 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[webrouting-service]/Pe_concat::Fragment[puppetserver webrouting-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver webrouting-service]/ensure: defined content as '{md5}448493bf4fcaf3ff5620806789b924fc'
==> puppet.demo: 2017-02-02 22:22:39,968 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[legacy-routes-service]/Pe_concat::Fragment[puppetserver legacy-routes-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver legacy-routes-service]/ensure: defined content as '{md5}1061605a7504383d4aa4a0e0f8a1c435'
==> puppet.demo: 2017-02-02 22:22:39,980 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[status-service]/Pe_concat::Fragment[puppetserver status-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver status-service]/ensure: defined content as '{md5}94a1afeaec9862224e0ea413660dc339'
==> puppet.demo: 2017-02-02 22:22:39,989 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[authorization-service]/Pe_concat::Fragment[puppetserver authorization-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver authorization-service]/ensure: defined content as '{md5}8cc75be0a7bc287193015434f2332e0e'
==> puppet.demo: 2017-02-02 22:22:40,002 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[scheduler-service]/Pe_concat::Fragment[puppetserver scheduler-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver scheduler-service]/ensure: defined content as '{md5}be34915aab4cd09c65eb9d5780bc9d72'
==> puppet.demo: 2017-02-02 22:22:40,017 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[pe-jruby-metrics-service]/Pe_concat::Fragment[puppetserver pe-jruby-metrics-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver pe-jruby-metrics-service]/ensure: defined content as '{md5}93e77dfe22a761338b8c546be2bd9aaf'
==> puppet.demo: 2017-02-02 22:22:40,031 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[analytics-service]/Pe_concat::Fragment[puppetserver analytics-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver analytics-service]/ensure: defined content as '{md5}fdcd435c26cc198ea37f6761a8ed31ec'
==> puppet.demo: 2017-02-02 22:22:40,039 - [Notice]: /Stage[main]/Puppet_enterprise::Master::File_sync_disabled/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[versioned-code-service]/Pe_concat::Fragment[puppetserver versioned-code-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_puppetserver_bootstrap.cfg/fragments/10_puppetserver versioned-code-service]/ensure: defined content as '{md5}dd5596101640da3a9e8da3d5d9875960'
==> puppet.demo: 2017-02-02 22:22:40,139 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[certificate-authority-service]/Pe_concat[/etc/puppetlabs/puppetserver/bootstrap.cfg]/Exec[pe_concat_/etc/puppetlabs/puppetserver/bootstrap.cfg]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:22:40,188 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[certificate-authority-service]/Pe_concat[/etc/puppetlabs/puppetserver/bootstrap.cfg]/Exec[pe_concat_/etc/puppetlabs/puppetserver/bootstrap.cfg]: Triggered 'refresh' from 20 events
==> puppet.demo: 2017-02-02 22:22:40,198 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Master/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[certificate-authority-service]/Pe_concat[/etc/puppetlabs/puppetserver/bootstrap.cfg]/File[/etc/puppetlabs/puppetserver/bootstrap.cfg]/content: content changed '{md5}5aacc2fd04e3f0579726eb3202b1860b' to '{md5}49aa06818b9c496279e2543e57bfe6ab'
==> puppet.demo: 2017-02-02 22:23:13,297 - [Notice]: /Stage[main]/Puppet_enterprise::Master::Puppetserver/Service[pe-puppetserver]/ensure: ensure changed 'stopped' to 'running'
==> puppet.demo: 2017-02-02 22:23:13,317 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/Pe_puppet_authorization::Rule[pxp commands]/Pe_puppet_authorization_hocon_rule[rule-pxp commands]/ensure: created
==> puppet.demo: 2017-02-02 22:23:13,380 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/Pe_puppet_authorization::Rule[inventory request]/Pe_puppet_authorization_hocon_rule[rule-inventory request]/ensure: created
==> puppet.demo: 2017-02-02 22:23:13,415 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/Pe_puppet_authorization::Rule[multi-cast with destination_report]/Pe_puppet_authorization_hocon_rule[rule-multi-cast with destination_report]/ensure: created
==> puppet.demo: 2017-02-02 22:23:13,464 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/Pe_puppet_authorization::Rule[pcp-broker message]/Pe_puppet_authorization_hocon_rule[rule-pcp-broker message]/ensure: created
==> puppet.demo: 2017-02-02 22:23:13,487 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services webrouting-service]/Pe_concat[/etc/puppetlabs/orchestration-services/bootstrap.cfg]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg]/ensure: created
==> puppet.demo: 2017-02-02 22:23:13,498 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services webrouting-service]/Pe_concat[/etc/puppetlabs/orchestration-services/bootstrap.cfg]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments]/ensure: created
==> puppet.demo: 2017-02-02 22:23:13,503 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services webrouting-service]/Pe_concat[/etc/puppetlabs/orchestration-services/bootstrap.cfg]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments.concat]/ensure: created
==> puppet.demo: 2017-02-02 22:23:13,511 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services webrouting-service]/Pe_concat[/etc/puppetlabs/orchestration-services/bootstrap.cfg]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments.concat.out]/ensure: created
==> puppet.demo: 2017-02-02 22:23:13,517 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services webrouting-service]/Pe_concat::Fragment[orchestration-services webrouting-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments/10_orchestration-services webrouting-service]/ensure: defined content as '{md5}448493bf4fcaf3ff5620806789b924fc'
==> puppet.demo: 2017-02-02 22:23:13,533 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services:orchestrator orchestrator-service]/Pe_concat::Fragment[orchestration-services orchestrator-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments/10_orchestration-services orchestrator-service]/ensure: defined content as '{md5}1600c149c2cda3ba35f0ff34e43a1e10'
==> puppet.demo: 2017-02-02 22:23:13,545 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services:orchestrator status-service]/Pe_concat::Fragment[orchestration-services status-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments/10_orchestration-services status-service]/ensure: defined content as '{md5}94a1afeaec9862224e0ea413660dc339'
==> puppet.demo: 2017-02-02 22:23:13,551 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services:orchestrator metrics-service]/Pe_concat::Fragment[orchestration-services metrics-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments/10_orchestration-services metrics-service]/ensure: defined content as '{md5}33dfd879076c65157a5eb65df1b6937c'
==> puppet.demo: 2017-02-02 22:23:13,561 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services:orchestrator metrics-webservice]/Pe_concat::Fragment[orchestration-services metrics-webservice]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments/10_orchestration-services metrics-webservice]/ensure: defined content as '{md5}f4ea7d715f98fd75018ac073d2f61611'
==> puppet.demo: 2017-02-02 22:23:13,570 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services:orchestrator jetty9-service]/Pe_concat::Fragment[orchestration-services jetty9-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments/10_orchestration-services jetty9-service]/ensure: defined content as '{md5}9ad7a87cc2b4b19be088e8307c55a9fe'
==> puppet.demo: 2017-02-02 22:23:13,581 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services:orchestrator remote-rbac-consumer-service]/Pe_concat::Fragment[orchestration-services remote-rbac-consumer-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments/10_orchestration-services remote-rbac-consumer-service]/ensure: defined content as '{md5}82a1aef13f1443e8473a84e7203ecae7'
==> puppet.demo: 2017-02-02 22:23:13,587 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Orchestrator[orchestration-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services:orchestrator remote-activity-reporter]/Pe_concat::Fragment[orchestration-services remote-activity-reporter]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments/10_orchestration-services remote-activity-reporter]/ensure: defined content as '{md5}8b6d5ea7c1890cef59c57c00e06cc5a8'
==> puppet.demo: 2017-02-02 22:23:13,598 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services:pcp-broker broker-service]/Pe_concat::Fragment[orchestration-services broker-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments/10_orchestration-services broker-service]/ensure: defined content as '{md5}43463e041863acc7dcf2fba7dcce301e'
==> puppet.demo: 2017-02-02 22:23:13,607 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Pcp_broker[orchestration-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services:pcp-broker authorization-service]/Pe_concat::Fragment[orchestration-services authorization-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_orchestration-services_bootstrap.cfg/fragments/10_orchestration-services authorization-service]/ensure: defined content as '{md5}8cc75be0a7bc287193015434f2332e0e'
==> puppet.demo: 2017-02-02 22:23:13,683 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services webrouting-service]/Pe_concat[/etc/puppetlabs/orchestration-services/bootstrap.cfg]/Exec[pe_concat_/etc/puppetlabs/orchestration-services/bootstrap.cfg]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:23:13,719 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services webrouting-service]/Pe_concat[/etc/puppetlabs/orchestration-services/bootstrap.cfg]/Exec[pe_concat_/etc/puppetlabs/orchestration-services/bootstrap.cfg]: Triggered 'refresh' from 12 events
==> puppet.demo: 2017-02-02 22:23:13,736 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[orchestration-services webrouting-service]/Pe_concat[/etc/puppetlabs/orchestration-services/bootstrap.cfg]/File[/etc/puppetlabs/orchestration-services/bootstrap.cfg]/content: content changed '{md5}801a183345d4debd78aa617d3eb0744f' to '{md5}5a6ff043efdc8f0c849f0b3095029fab'
==> puppet.demo: 2017-02-02 22:23:42,657 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Orchestrator/Service[pe-orchestration-services]/ensure: ensure changed 'stopped' to 'running'
==> puppet.demo: 2017-02-02 22:23:42,668 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:activity activity-service]/Pe_concat::Fragment[console-services activity-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services activity-service]/ensure: defined content as '{md5}47afd4109a470e8c8efd0c1f57bffcae'
==> puppet.demo: 2017-02-02 22:23:42,677 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Activity[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:activity jetty9-service]/Pe_concat::Fragment[console-services jetty9-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services jetty9-service]/ensure: defined content as '{md5}9ad7a87cc2b4b19be088e8307c55a9fe'
==> puppet.demo: 2017-02-02 22:23:42,690 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:rbac rbac-service]/Pe_concat::Fragment[console-services rbac-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services rbac-service]/ensure: defined content as '{md5}6fef98df31db6afd6a8a2dba78b0bfb7'
==> puppet.demo: 2017-02-02 22:23:42,699 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:rbac rbac-storage-service]/Pe_concat::Fragment[console-services rbac-storage-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services rbac-storage-service]/ensure: defined content as '{md5}aa75d3801ed8495a3529208c1aed924a'
==> puppet.demo: 2017-02-02 22:23:42,710 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:rbac rbac-http-api-service]/Pe_concat::Fragment[console-services rbac-http-api-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services rbac-http-api-service]/ensure: defined content as '{md5}149d240e484608065f0972ba80f84819'
==> puppet.demo: 2017-02-02 22:23:42,720 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:rbac rbac-authn-middleware]/Pe_concat::Fragment[console-services rbac-authn-middleware]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services rbac-authn-middleware]/ensure: defined content as '{md5}3bd93e27c6743c13679198b2ff29cac8'
==> puppet.demo: 2017-02-02 22:23:42,731 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Rbac[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:rbac activity-reporting-service]/Pe_concat::Fragment[console-services activity-reporting-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services activity-reporting-service]/ensure: defined content as '{md5}58898605473f84d60e4361d03d7aa563'
==> puppet.demo: 2017-02-02 22:23:42,744 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console/Puppet_enterprise::Trapperkeeper::Classifier[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:classifier classifier-service]/Pe_concat::Fragment[console-services classifier-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services classifier-service]/ensure: defined content as '{md5}d2c65d98b4816220822fa8be98fd56fb'
==> puppet.demo: 2017-02-02 22:23:42,762 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:console webrouting-service]/Pe_concat::Fragment[console-services webrouting-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services webrouting-service]/ensure: defined content as '{md5}448493bf4fcaf3ff5620806789b924fc'
==> puppet.demo: 2017-02-02 22:23:42,773 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:console rbac-consumer-service]/Pe_concat::Fragment[console-services rbac-consumer-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services rbac-consumer-service]/ensure: defined content as '{md5}4ef6bf61fc2d120a6e0477a64e8e23b0'
==> puppet.demo: 2017-02-02 22:23:42,780 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:console rbac-status-service]/Pe_concat::Fragment[console-services rbac-status-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services rbac-status-service]/ensure: defined content as '{md5}bf6ade9c8cd2984f1066dd397a0dbd54'
==> puppet.demo: 2017-02-02 22:23:42,797 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:console rbac-authn-service]/Pe_concat::Fragment[console-services rbac-authn-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services rbac-authn-service]/ensure: defined content as '{md5}e6b019ab7145ccfaf20c64038517db43'
==> puppet.demo: 2017-02-02 22:23:42,809 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:console rbac-authz-service]/Pe_concat::Fragment[console-services rbac-authz-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services rbac-authz-service]/ensure: defined content as '{md5}8cd2301f3705cf1c6d073c1c9854b59d'
==> puppet.demo: 2017-02-02 22:23:42,816 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:console pe-console-ui-service]/Pe_concat::Fragment[console-services pe-console-ui-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services pe-console-ui-service]/ensure: defined content as '{md5}977888cb59bad06f4d57954dd9c1130e'
==> puppet.demo: 2017-02-02 22:23:42,831 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:console pe-console-auth-ui-service]/Pe_concat::Fragment[console-services pe-console-auth-ui-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services pe-console-auth-ui-service]/ensure: defined content as '{md5}ede73330af7d192d4bddd18b629ec283'
==> puppet.demo: 2017-02-02 22:23:42,845 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Puppet_enterprise::Trapperkeeper::Bootstrap_cfg[console-services:console status-service]/Pe_concat::Fragment[console-services status-service]/File[/opt/puppetlabs/puppet/cache/pe_concat/_etc_puppetlabs_console-services_bootstrap.cfg/fragments/10_console-services status-service]/ensure: defined content as '{md5}94a1afeaec9862224e0ea413660dc339'
==> puppet.demo: 2017-02-02 22:23:42,937 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_concat[/etc/puppetlabs/console-services/bootstrap.cfg]/Exec[pe_concat_/etc/puppetlabs/console-services/bootstrap.cfg]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:23:42,980 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_concat[/etc/puppetlabs/console-services/bootstrap.cfg]/Exec[pe_concat_/etc/puppetlabs/console-services/bootstrap.cfg]: Triggered 'refresh' from 18 events
==> puppet.demo: 2017-02-02 22:23:42,994 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_concat[/etc/puppetlabs/console-services/bootstrap.cfg]/File[/etc/puppetlabs/console-services/bootstrap.cfg]/content: content changed '{md5}0ae0b3991ec92ca03bb5f9ecf7f32ea2' to '{md5}f31b2b0b39a5232da0ba36c893bfcef2'
==> puppet.demo: 2017-02-02 22:23:42,995 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_concat[/etc/puppetlabs/console-services/bootstrap.cfg]/File[/etc/puppetlabs/console-services/bootstrap.cfg]/owner: owner changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:23:42,997 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_concat[/etc/puppetlabs/console-services/bootstrap.cfg]/File[/etc/puppetlabs/console-services/bootstrap.cfg]/group: group changed 'root' to 'pe-console-services'
==> puppet.demo: 2017-02-02 22:23:42,998 - [Notice]: /Stage[main]/Puppet_enterprise::Profile::Console::Console_services_config/Pe_concat[/etc/puppetlabs/console-services/bootstrap.cfg]/File[/etc/puppetlabs/console-services/bootstrap.cfg]/mode: mode changed '0644' to '0640'
==> puppet.demo: 2017-02-02 22:24:17,403 - [Notice]: /Stage[main]/Puppet_enterprise::Console_services/Service[pe-console-services]/ensure: ensure changed 'stopped' to 'running'
==> puppet.demo: 2017-02-02 22:24:41,883 - [Notice]: /Stage[main]/Pe_install::Install::Classification/Pe_node_group[PE Infrastructure]/ensure: created
==> puppet.demo: 2017-02-02 22:24:42,344 - [Notice]: /Stage[main]/Pe_install::Install::Classification/Pe_node_group[PE Certificate Authority]/ensure: created
==> puppet.demo: 2017-02-02 22:24:42,585 - [Notice]: /Stage[main]/Pe_install::Install::Classification/Pe_node_group[PE Master]/ensure: created
==> puppet.demo: 2017-02-02 22:24:42,858 - [Notice]: /Stage[main]/Pe_install::Install::Classification/Pe_node_group[PE ActiveMQ Broker]/ensure: created
==> puppet.demo: 2017-02-02 22:24:43,045 - [Notice]: /Stage[main]/Pe_install::Install::Classification/Pe_node_group[PE Orchestrator]/ensure: created
==> puppet.demo: 2017-02-02 22:24:43,254 - [Notice]: /Stage[main]/Pe_install::Install::Classification/Pe_node_group[PE Console]/ensure: created
==> puppet.demo: 2017-02-02 22:24:43,452 - [Notice]: /Stage[main]/Pe_install::Install::Classification/Pe_node_group[PE PuppetDB]/ensure: created
==> puppet.demo: 2017-02-02 22:24:43,602 - [Notice]: /Stage[main]/Pe_install::Install::Classification/Pe_node_group[PE MCollective]/ensure: created
==> puppet.demo: 2017-02-02 22:24:43,747 - [Notice]: /Stage[main]/Pe_install::Install::Classification/Pe_node_group[PE Agent]/ensure: created
==> puppet.demo: 2017-02-02 22:24:43,898 - [Notice]: /Stage[main]/Pe_install::Install::Classification/Pe_node_group[PE Infrastructure Agent]/ensure: created
==> puppet.demo: 2017-02-02 22:24:44,001 - [Notice]: /Stage[main]/Pe_install::Install::Classification/Pe_node_group[Production environment]/ensure: created
==> puppet.demo: 2017-02-02 22:24:44,169 - [Notice]: /Stage[main]/Pe_install::Install::Classification/Pe_node_group[Agent-specified environment]/ensure: created
==> puppet.demo: 2017-02-02 22:24:45,684 - [Notice]: /Stage[main]/Pe_install::Install/Exec[set console admin password]/returns: executed successfully
==> puppet.demo: 2017-02-02 22:24:46,180 - [Notice]: Applied catalog in 276.58 seconds
==> puppet.demo: * /opt/puppetlabs/puppet/bin/puppet infrastructure configure  --detailed-exitcodes --modulepath /opt/puppetlabs/server/data/enterprise/modules
==> puppet.demo: * returned: 2
==> puppet.demo:
==> puppet.demo: ## Puppet Enterprise configuration complete!
==> puppet.demo:
==> puppet.demo: Documentation: https://docs.puppet.com/pe/2016.5/index.html
==> puppet.demo: Release notes: https://docs.puppet.com/pe/2016.5/release_notes.html
==> puppet.demo:
==> puppet.demo: If this is a monolithic configuration, run 'puppet agent -t' to
==> puppet.demo: complete the setup of this system.
==> puppet.demo:
==> puppet.demo: If this is a split configuration, install or upgrade the remaining
==> puppet.demo: PE components, and then run puppet agent -t on the Puppet master,
==> puppet.demo: PuppetDB, and PE console, in that order.
==> puppet.demo: /home/vagrant
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-47944-1i26u8e.sh
==> puppet.demo: ### Installing dependencies needed for puppet apply mode
==> puppet.demo: Notice: /Package[rubygems]/ensure: created
==> puppet.demo: package { 'rubygems':
==> puppet.demo:   ensure => '2.0.14.1-29.el7',
==> puppet.demo: }
==> puppet.demo: ### Installing gems with provider gem
==> puppet.demo: Notice: /Package[hiera-eyaml]/ensure: created
==> puppet.demo: package { 'hiera-eyaml':
==> puppet.demo:   ensure => ['2.1.0'],
==> puppet.demo: }
==> puppet.demo: Notice: /Package[deep_merge]/ensure: created
==> puppet.demo: package { 'deep_merge':
==> puppet.demo:   ensure => ['1.1.1'],
==> puppet.demo: }
==> puppet.demo: ### Installing gems with provider puppet_gem
==> puppet.demo: Notice: /Package[hiera-eyaml]/ensure: created
==> puppet.demo: package { 'hiera-eyaml':
==> puppet.demo:   ensure => ['2.1.0'],
==> puppet.demo: }
==> puppet.demo: package { 'deep_merge':
==> puppet.demo:   ensure => ['1.0.1'],
==> puppet.demo: }
==> puppet.demo: ### Installing git
==> puppet.demo: Notice: /Package[git]/ensure: created
==> puppet.demo: package { 'git':
==> puppet.demo:   ensure => '1.8.3.1-6.el7_2.1',
==> puppet.demo: }
==> puppet.demo: /opt/puppetlabs/bin/puppetserver
==> puppet.demo: ### Installing gems for puppetserver
==> puppet.demo: Successfully installed highline-1.6.21
==> puppet.demo: Successfully installed trollop-2.1.2
==> puppet.demo: Successfully installed hiera-eyaml-2.1.0
==> puppet.demo: 3 gems installed
==> puppet.demo: Successfully installed deep_merge-1.1.1
==> puppet.demo: 1 gem installed
==> puppet.demo: Redirecting to /bin/systemctl restart  pe-puppetserver.service
==> puppet.demo: Running provisioner: pe_agent...
==> puppet.demo: The Puppet Server on puppet.demo is configured with Agent repositories for:
==> puppet.demo:   el-7-x86_64
==> puppet.demo: Puppet agent 4.8.1 is already installed, skipping installation.
==> puppet.demo: No pending signing request for puppet.demo on puppet.demo. Skipping autosign.
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-47944-e6mapy.sh
==> puppet.demo: ## Running puppet agent --server puppet.demo
==> puppet.demo: Info: Using configured environment 'production'
==> puppet.demo: Info: Retrieving pluginfacts
==> puppet.demo: Info: Retrieving plugin
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/aio_agent_build.rb]/ensure: defined content as '{md5}cdcc1ff07bc245c66cc1d46be56b3af5'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/aio_agent_version.rb]/ensure: defined content as '{md5}d05c8cbf788f47d33efd46a935dda61e'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/pe_build.rb]/ensure: defined content as '{md5}ee54c728457b32d6622c3985448918fa'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/pe_concat_basedir.rb]/ensure: defined content as '{md5}0ccd3500f29b9dd346a45a61268c7c18'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/pe_razor_server_version.rb]/ensure: defined content as '{md5}ec91d8b92e03d5f952c789308d26dcd0'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/pe_server_version.rb]/ensure: defined content as '{md5}17c2795fe8a56b731ae0fc81ba147e6a'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/pe_version.rb]/ensure: defined content as '{md5}b0cd9b5b3fed73bc0d6424d8ac1d6639'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/platform_symlink_writable.rb]/ensure: defined content as '{md5}fc1e2766ff9994fa5df95cdc14b9bcd2'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/platform_tag.rb]/ensure: defined content as '{md5}ba51554600d31251f66baaf81b00639a'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/puppet_files_dir_present.rb]/ensure: defined content as '{md5}3900e124be2f377638dd1522079856bf'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/staging_http_get.rb]/ensure: defined content as '{md5}2c27beb47923ce3acda673703f395e68'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/windows.rb]/ensure: defined content as '{md5}d8880f6f32905f040f3355e2a40cf088'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/application]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/application/enterprise.rb]/ensure: defined content as '{md5}b0e6f1b94578dde29a3af39fe7652fb0'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/face]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/face/enterprise]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/face/enterprise.rb]/ensure: defined content as '{md5}8b5e646f362d8d9df27d32ef5fdde7b2'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/face/enterprise/support.rb]/ensure: defined content as '{md5}4fc00117ec19622caf90d5ccae4bd134'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/face/node]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/face/node/purge.rb]/ensure: defined content as '{md5}2dc21d637a51cdb5b4e7997409eee1fc'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/feature]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/feature/pe_hocon.rb]/ensure: defined content as '{md5}bbd4eca7117850bcef6f3be059cf250c'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/feature/pe_puppet_authorization.rb]/ensure: defined content as '{md5}c673198b8d2117318558170c0a7f5ced'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/meep_function.rb]/ensure: defined content as '{md5}05147a7c4231967ba2321cad04381e01'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_infrastructure]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_infrastructure/data.rb]/ensure: defined content as '{md5}cd7ff9c440206ae723595d05b8e8ebc0'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_infrastructure_nodes.rb]/ensure: defined content as '{md5}9ff0caba835d0a5888cfc22bb9aad008'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_is_infrastructure.rb]/ensure: defined content as '{md5}64a8e3c34d07088c21ceb297c49495bb'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_is_node_a.rb]/ensure: defined content as '{md5}7853c74c1ba8e2cc277b0271e9471166'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_list_certificate_authority_nodes.rb]/ensure: defined content as '{md5}28a991a9f3723810c4104d8e5c7d631b'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_list_compile_master_nodes.rb]/ensure: defined content as '{md5}d8772d3dc4c5a440156e630b83fd1435'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_list_console_nodes.rb]/ensure: defined content as '{md5}263fe5d548f12a50c00931c35f487a45'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_list_database_nodes.rb]/ensure: defined content as '{md5}947657ddb73d0f5682fe48684cde2bd5'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_list_enabled_replica_nodes.rb]/ensure: defined content as '{md5}a84b12bb067504db565b549654640aa7'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_list_mco_broker_nodes.rb]/ensure: defined content as '{md5}f2405633c529c4e35e4de5131706ebe4'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_list_mco_hub_nodes.rb]/ensure: defined content as '{md5}731ec7ae6fa35516563ee5aa114c180f'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_list_orchestrator_nodes.rb]/ensure: defined content as '{md5}d6907d11986d3ae2d16a8455b4522e6d'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_list_primary_master_nodes.rb]/ensure: defined content as '{md5}37c2bae5b5125f08a0713e54d6cb8fdc'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_list_provisioned_replica_nodes.rb]/ensure: defined content as '{md5}3b907e0df419f6ef8e69ddc8a66f6a6c'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_list_puppetdb_nodes.rb]/ensure: defined content as '{md5}78f889b8d79af5ff7b9d4209e9de6b34'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_meep_master.rb]/ensure: defined content as '{md5}2fe44f31f093e64403f5330b609ffe53'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_role.rb]/ensure: defined content as '{md5}3e53d875ae455e904cbcbb4cfca77afc'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/pe_services_list.rb]/ensure: defined content as '{md5}749622b46068115a70cf1de7a1e693bd'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/build_mcollective_metadata_cron_minute_array.rb]/ensure: defined content as '{md5}d657907920f0d58902578b23b93a7aab'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/cookie_secret_key.rb]/ensure: defined content as '{md5}a1a48191d1f0cb934b0c63d8fec70566'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/create_java_args_subsettings_hash.rb]/ensure: defined content as '{md5}b54be02c9f0b0eeee699764df57a2db3'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_any2array.rb]/ensure: defined content as '{md5}3384ea4d25dc66d898717c9ca6bb5507'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_bool2str.rb]/ensure: defined content as '{md5}f6189451331df6fd24ec69d7cdc76abe'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_build_version.rb]/ensure: defined content as '{md5}cc956210f4ef17fb396513dffdee1ed7'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_chomp.rb]/ensure: defined content as '{md5}b4f0cb35578710dc4ac315d35e9571a2'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_compile_master.rb]/ensure: defined content as '{md5}73a4baa192f4461b5d82856094bc6ffb'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_compiling_server_aio_build.rb]/ensure: defined content as '{md5}d01e0cac62411df5140da0956a79544c'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_compiling_server_version.rb]/ensure: defined content as '{md5}dfa2285cae91d2985408274b24692d69'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_concat.rb]/ensure: defined content as '{md5}915afa8db34797eea1bcbd0260eb5821'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_concat_getparam.rb]/ensure: defined content as '{md5}46df3de760f918b120fb2254f85eff2a'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_concat_is_bool.rb]/ensure: defined content as '{md5}b511d7545ede5abae00951199b67674d'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_count.rb]/ensure: defined content as '{md5}eba067719da25b908662eec256ebc9b4'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_create_amq_augeas_command.rb]/ensure: defined content as '{md5}a62e6f52c8a5bdc002436dc6c292fd48'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_current_server_version.rb]/ensure: defined content as '{md5}f08526ad8a79c173dc0759584fb2e397'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_delete_undef_values.rb]/ensure: defined content as '{md5}c25bbcdfc6bca2d219e5f42f3eb8fa0b'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_directory_exists.rb]/ensure: defined content as '{md5}18df1a47e5e04af8278b937953bf3179'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_empty.rb]/ensure: defined content as '{md5}01a6574fab1ed1cf94ef1fea4954eeca'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_flatten.rb]/ensure: defined content as '{md5}c781954451d1860ca8f63fd6d2b6cf76'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_format_urls.rb]/ensure: defined content as '{md5}b03ddf9f0600bc0122dfe3ba814c3ba7'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_getvar.rb]/ensure: defined content as '{md5}f445be97e6541d0ae577ea5450479067'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_grep.rb]/ensure: defined content as '{md5}ae92a94aa1c964ff2af58d74df115af8'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_hash2dsn.rb]/ensure: defined content as '{md5}7054876d056975b7e96c73d0044a5b10'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_hash_array_sort.rb]/ensure: defined content as '{md5}a0dcbf882e8d7d99032c440b6a597d2c'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_is_array.rb]/ensure: defined content as '{md5}b451e133e015fc7e8dc4dcfdf059a8d8'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_is_bool.rb]/ensure: defined content as '{md5}2dfe2be70aaff951b59e9fba3e85aa5d'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_is_integer.rb]/ensure: defined content as '{md5}a410ba3f3586b7df90e532b2eb99da37'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_is_string.rb]/ensure: defined content as '{md5}5fe6741e70f2bbb93a0ae43d233eeebc'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_join.rb]/ensure: defined content as '{md5}4f433ea29dffc79247671fb4271d0a10'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_join_keys_to_values.rb]/ensure: defined content as '{md5}3066c3bd5e181a996729691a57cf3d21'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_keys.rb]/ensure: defined content as '{md5}3dfe5f84d009070df735b8d51f8614fc'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_loadyaml.rb]/ensure: defined content as '{md5}6adef0c167fbe0167a8e7aec7c65317b'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_max.rb]/ensure: defined content as '{md5}e04acd17070545133c83ec5a0e11c022'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_merge.rb]/ensure: defined content as '{md5}0971d635342b84a3a5c5a40ac36d9807'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_min.rb]/ensure: defined content as '{md5}e6d2b8c614168f4224e3f76f32d9f9cb'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_pick.rb]/ensure: defined content as '{md5}06b3a9e63faf3ca5d64c65fa14803cdf'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_postgresql_acls_to_resources_hash.rb]/ensure: defined content as '{md5}851d972daf92e9e0600f8991a15311be'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_postgresql_escape.rb]/ensure: defined content as '{md5}cc58b659957328d9577336353bc246b2'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_postgresql_password.rb]/ensure: defined content as '{md5}72c33c3b7e4a6e8128fbb0a52bf30282'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_prefix.rb]/ensure: defined content as '{md5}554fcaf9362a544f91bb192047dd5341'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_puppetserver_static_content_list.rb]/ensure: defined content as '{md5}3955ef0b5cd765be892a3043386cf91f'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_servername.rb]/ensure: defined content as '{md5}c60209498856941f6f794d4c3cfb5d1f'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_size.rb]/ensure: defined content as '{md5}876097c7df6d07296524bb2236f60a1d'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_sort.rb]/ensure: defined content as '{md5}26047743025f2fdcf5e7b5420d5382ea'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_strip.rb]/ensure: defined content as '{md5}8d60a607f04fc6622eca8ae46e2fef2f'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_suffix.rb]/ensure: defined content as '{md5}a44749c5ef30e258866cb18fd83f77d2'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_to_bytes.rb]/ensure: defined content as '{md5}6ee36cabe336db4c281c7d3b1b1d771e'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_union.rb]/ensure: defined content as '{md5}da3ea966f5468bbdb8420975576d4a3f'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_unique.rb]/ensure: defined content as '{md5}5edb2c537d80f003d71a250bf203c79e'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_upcase.rb]/ensure: defined content as '{md5}4ea67e96c4da45092fb70fcdf1f0692f'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_validate_absolute_path.rb]/ensure: defined content as '{md5}d4bd539a3d7db93d4563cbbe571a16ac'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_validate_array.rb]/ensure: defined content as '{md5}0ab10b81de351aa9f6114c1880cc7155'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_validate_bool.rb]/ensure: defined content as '{md5}4a74954e0502837f11d2eadedb71bc1f'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_validate_hash.rb]/ensure: defined content as '{md5}36a223b1648dec8cb30fd229e3bb74c6'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_validate_re.rb]/ensure: defined content as '{md5}bccac35a2607bf15f1e7d1c565c1d98b'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_validate_single_integer.rb]/ensure: defined content as '{md5}ef8c455e5d58954bc4e78e36534a340c'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_validate_string.rb]/ensure: defined content as '{md5}c4d83c3ef14c2e3e47c4408d49c22437'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pe_zip.rb]/ensure: defined content as '{md5}77f42491eaa279803a36b02601206b33'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/scope_defaults.rb]/ensure: defined content as '{md5}da916d46f3ff3be8359f75c93c2b5532'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/staging_parse.rb]/ensure: defined content as '{md5}605c4de803c65f2c3613653b68921002'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_file_line]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_file_line/ruby.rb]/ensure: defined content as '{md5}79d77c28f8a311684aceec3e08c1a084'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_hocon_setting]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_hocon_setting/ruby.rb]/ensure: defined content as '{md5}c0bad8a42357896675e209aab7ee6a0d'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_ini_setting]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_ini_setting/ruby.rb]/ensure: defined content as '{md5}d0520f108a6f0e55320a97f8285a0843'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_ini_subsetting]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_ini_subsetting/ruby.rb]/ensure: defined content as '{md5}7245892fe493f361b4f2fb34188e71db'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_java_ks]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_java_ks/keytool.rb]/ensure: defined content as '{md5}6e16c71a9e74550cfe9aad4ecbb8fd22'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_postgresql_conf]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_postgresql_conf/parsed.rb]/ensure: defined content as '{md5}f0e7fc6f14420d46ebf64635939243af'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_postgresql_psql]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_postgresql_psql/ruby.rb]/ensure: defined content as '{md5}68b0e90ab501fc36b821c4c27c74fb17'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_postgresql_replication_slot]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_postgresql_replication_slot/ruby.rb]/ensure: defined content as '{md5}9f6646f8e075fff785e1c40f27e60311'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_puppet_authorization_hocon_rule]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/provider/pe_puppet_authorization_hocon_rule/ruby.rb]/ensure: defined content as '{md5}1aaaa7466dc6d830cb25332cc2910c07'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/type]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/type/pe_anchor.rb]/ensure: defined content as '{md5}5505f2e5850c0dd2e56583d214baf197'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/type/pe_file_line.rb]/ensure: defined content as '{md5}5cecf4e63d31bc89f31a9be54a248359'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/type/pe_hocon_setting.rb]/ensure: defined content as '{md5}204b2889d1c6db8f986f02ed17239ef5'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/type/pe_ini_setting.rb]/ensure: defined content as '{md5}516aadd69157e2bc540ee3e87f5de6cc'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/type/pe_ini_subsetting.rb]/ensure: defined content as '{md5}022dc2b30ed8daa8ce2226017bc95a38'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/type/pe_java_ks.rb]/ensure: defined content as '{md5}9bb59c04ff805eb7e824fc4e5b4c9767'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/type/pe_postgresql_conf.rb]/ensure: defined content as '{md5}140d5cb21ae1b8554f40c71f2b73b332'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/type/pe_postgresql_psql.rb]/ensure: defined content as '{md5}ffabdb11eb481e45c76795195672436c'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/type/pe_postgresql_replication_slot.rb]/ensure: defined content as '{md5}f5ff4b1210fdfd969e6bd45cc11def62'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/type/pe_puppet_authorization_hocon_rule.rb]/ensure: defined content as '{md5}2a9e64fd982a8c0b118d0ce803c92bfb'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/util]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/util/external_iterator.rb]/ensure: defined content as '{md5}69ad1eb930ca6d8d6b6faea343b4a22e'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/util/pe_ini_file]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/util/pe_ini_file.rb]/ensure: defined content as '{md5}9ba01a79162a1d69ab8e90e725d07d3a'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/util/pe_ini_file/section.rb]/ensure: defined content as '{md5}652d2b45e5defc13fb7989f020e6080f'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/util/setting_value.rb]/ensure: defined content as '{md5}a649418f4c767d976f4bf13985575b3c'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet_x]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet_x/puppetlabs]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet_x/puppetlabs/meep]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet_x/puppetlabs/meep/config.rb]/ensure: defined content as '{md5}eb2565ae435eb3a3c5e42ee1ff1aba26'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet_x/puppetlabs/support_script]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet_x/puppetlabs/support_script/v1]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet_x/puppetlabs/support_script/v1/puppet-enterprise-support.sh]/ensure: defined content as '{md5}dd0eb4126654904416cb5f7848300086'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/shared]/ensure: created
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/shared/aio_build.rb]/ensure: defined content as '{md5}d0fe0c2b31687ea03c1ede01a460f3a0'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/shared/pe_build.rb]/ensure: defined content as '{md5}4f4652af20c4f0391b9ca2976940a710'
==> puppet.demo: Notice: /File[/opt/puppetlabs/puppet/cache/lib/shared/pe_server_version.rb]/ensure: defined content as '{md5}f3d3fc8776512ae73d3293c97b8f3dfe'
==> puppet.demo: Info: Loading facts
==> puppet.demo: Info: Caching catalog for puppet.demo
==> puppet.demo: Info: Applying configuration version '1486074441'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Cli_config/Pe_hocon_setting[/etc/puppetlabs/client-tools/services.conf/nodes]/value: value changed [] to '{"role"=>"primary_master", "display_name"=>"Primary Master", "certname"=>"puppet.demo"}'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/mcollective-private.pem]/content: content changed '{md5}d41d8cd98f00b204e9800998ecf8427e' to '{md5}92b619f9d7d43d76996f072bdf1fa7f9'
==> puppet.demo: Info: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/mcollective-private.pem]: Scheduling refresh of Service[mcollective]
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/mcollective-public.pem]/content: content changed '{md5}d41d8cd98f00b204e9800998ecf8427e' to '{md5}1d57e87c04073dde2823868adc51b8ba'
==> puppet.demo: Info: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/mcollective-public.pem]: Scheduling refresh of Service[mcollective]
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/clients/peadmin-public.pem]/content: content changed '{md5}d41d8cd98f00b204e9800998ecf8427e' to '{md5}2d34f9c62f4453e7a503a491df9a5ef0'
==> puppet.demo: Info: /Stage[main]/Puppet_enterprise::Mcollective::Server::Certs/File[/etc/puppetlabs/mcollective/ssl/clients/peadmin-public.pem]: Scheduling refresh of Service[mcollective]
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Mcollective::Service/Service[mcollective]: Triggered 'refresh' from 3 events
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Profile::Master::Mcollective/Puppet_enterprise::Master::Keypair[pe-internal-mcollective-servers]/File[pe-internal-mcollective-servers.cert.pem]/mode: mode changed '0644' to '0640'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Profile::Master::Mcollective/Puppet_enterprise::Master::Keypair[pe-internal-mcollective-servers]/File[pe-internal-mcollective-servers.public_key.pem]/mode: mode changed '0644' to '0640'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Profile::Master::Mcollective/Puppet_enterprise::Master::Keypair[pe-internal-puppet-console-mcollective-client]/File[pe-internal-puppet-console-mcollective-client.cert.pem]/ensure: defined content as '{md5}d41d8cd98f00b204e9800998ecf8427e'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Profile::Master::Mcollective/Puppet_enterprise::Master::Keypair[pe-internal-puppet-console-mcollective-client]/File[pe-internal-puppet-console-mcollective-client.private_key.pem]/ensure: defined content as '{md5}d41d8cd98f00b204e9800998ecf8427e'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Profile::Master::Mcollective/Puppet_enterprise::Master::Keypair[pe-internal-puppet-console-mcollective-client]/File[pe-internal-puppet-console-mcollective-client.public_key.pem]/ensure: defined content as '{md5}d41d8cd98f00b204e9800998ecf8427e'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Profile::Master::Mcollective/Puppet_enterprise::Master::Keypair[pe-internal-peadmin-mcollective-client]/File[pe-internal-peadmin-mcollective-client.cert.pem]/mode: mode changed '0644' to '0640'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Profile::Master::Mcollective/Puppet_enterprise::Master::Keypair[pe-internal-peadmin-mcollective-client]/File[pe-internal-peadmin-mcollective-client.public_key.pem]/mode: mode changed '0644' to '0640'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::Certs[peadmin]/File[/var/lib/peadmin/.mcollective.d/peadmin-private.pem]/content: content changed '{md5}d41d8cd98f00b204e9800998ecf8427e' to '{md5}e8c04a0dd59bd81b62a54c81eb3077fe'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::Certs[peadmin]/File[/var/lib/peadmin/.mcollective.d/peadmin-public.pem]/content: content changed '{md5}d41d8cd98f00b204e9800998ecf8427e' to '{md5}2d34f9c62f4453e7a503a491df9a5ef0'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Profile::Mcollective::Peadmin/Puppet_enterprise::Mcollective::Client[peadmin]/Puppet_enterprise::Mcollective::Client::Certs[peadmin]/File[/var/lib/peadmin/.mcollective.d/mcollective-public.pem]/content: content changed '{md5}d41d8cd98f00b204e9800998ecf8427e' to '{md5}1d57e87c04073dde2823868adc51b8ba'
==> puppet.demo: Notice: Applied catalog in 9.12 seconds


al@mule pe_demo [ci] $ **vagrant provision puppet.demo**
==> puppet.demo: [vagrant-hostsupdater] Checking for host entries
==> puppet.demo: [vagrant-hostsupdater]   found entry for: 10.42.42.101 puppet.demo
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-48110-1nwxn63.sh
==> puppet.demo: ### Setting hostname puppet.demo
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-48110-1pjp2ln.sh
==> puppet.demo: /opt/puppetlabs/bin/puppet
==> puppet.demo: Running provisioner: pe_bootstrap...
==> puppet.demo: Puppet Enterprise is already installed, skipping installation.
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-48110-xsxpoo.sh
==> puppet.demo: ### Found /var/tmp/vagrant-setup_papply.lock. Skipping installation of dependencies needed for puppet apply mode
==> puppet.demo: ## Remove /var/tmp/vagrant-setup_papply.lock on the Vagrant VM to retry their installation
==> puppet.demo: Running provisioner: pe_agent...
==> puppet.demo: The Puppet Server on puppet.demo is configured with Agent repositories for:
==> puppet.demo:   el-7-x86_64
==> puppet.demo: Puppet agent 4.8.1 is already installed, skipping installation.
==> puppet.demo: No pending signing request for puppet.demo on puppet.demo. Skipping autosign.
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-48110-qjh5fo.sh
==> puppet.demo: ## Running puppet agent --server puppet.demo
==> puppet.demo: Info: Using configured environment 'production'
==> puppet.demo: Info: Retrieving pluginfacts
==> puppet.demo: Info: Retrieving plugin
==> puppet.demo: Info: Loading facts
==> puppet.demo: Info: Caching catalog for puppet.demo
==> puppet.demo: Info: Applying configuration version '1486074591'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Cli_config/Pe_hocon_setting[/etc/puppetlabs/client-tools/services.conf/services]/value: value changed [] to '{"type"=>"classifier", "url"=>"https://puppet.demo:4433/classifier-api", "server"=>"puppet.demo", "port"=>"4433", "prefix"=>"classifier-api", "status_url"=>"https://puppet.demo:4433/status", "status_prefix"=>"status", "status_key"=>"classifier-service", "node_certname"=>"puppet.demo", "display_name"=>"Classifier"} {"type"=>"rbac", "url"=>"https://puppet.demo:4433/rbac-api", "server"=>"puppet.demo", "port"=>"4433", "prefix"=>"rbac-api", "status_url"=>"https://puppet.demo:4433/status", "status_prefix"=>"status", "status_key"=>"rbac-service", "node_certname"=>"puppet.demo", "display_name"=>"RBAC"} {"type"=>"activity", "url"=>"https://puppet.demo:4433/activity-api", "server"=>"puppet.demo", "port"=>"4433", "prefix"=>"activity-api", "status_url"=>"https://puppet.demo:4433/status", "status_prefix"=>"status", "status_key"=>"activity-service", "node_certname"=>"puppet.demo", "display_name"=>"Activity Service"} {"type"=>"master", "url"=>"https://puppet.demo:8140/", "server"=>"puppet.demo", "port"=>8140, "prefix"=>"", "status_url"=>"https://puppet.demo:8140/status", "status_prefix"=>"status", "status_key"=>"pe-master", "node_certname"=>"puppet.demo", "display_name"=>"Puppet Server"} {"type"=>"orchestrator", "url"=>"https://puppet.demo:8143/orchestrator", "server"=>"puppet.demo", "port"=>8143, "prefix"=>"orchestrator", "status_url"=>"https://puppet.demo:8143/status", "status_prefix"=>"status", "status_key"=>"orchestrator-service", "node_certname"=>"puppet.demo", "display_name"=>"Orchestrator"} {"type"=>"pcp-broker", "url"=>"wss://puppet.demo:8142/pcp", "server"=>"puppet.demo", "port"=>8142, "prefix"=>"pcp", "status_url"=>"https://puppet.demo:8143/status", "status_prefix"=>"status", "status_key"=>"broker-service", "node_certname"=>"puppet.demo", "display_name"=>"PCP Broker"} {"type"=>"puppetdb", "url"=>"https://puppet.demo:8081/pdb", "server"=>"puppet.demo", "port"=>8081, "prefix"=>"pdb", "status_url"=>"https://puppet.demo:8081/status", "status_prefix"=>"status", "status_key"=>"puppetdb-status", "node_certname"=>"puppet.demo", "display_name"=>"PuppetDB"}'
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.service-alert]/value: value changed [] to '{"type"=>"activity", "url"=>"https://puppet.demo:4433", "replication_mode"=>"none"} {"type"=>"classifier", "url"=>"https://puppet.demo:4433", "replication_mode"=>"none"} {"type"=>"master", "url"=>"https://puppet.demo:8140", "replication_mode"=>"none"} {"type"=>"orchestrator", "url"=>"https://puppet.demo:8143", "replication_mode"=>"none"} {"type"=>"puppetdb", "url"=>"https://puppet.demo:8081", "replication_mode"=>"none"} {"type"=>"rbac", "url"=>"https://puppet.demo:4433", "replication_mode"=>"none"}'
==> puppet.demo: Info: /Stage[main]/Puppet_enterprise::Console_services/Puppet_enterprise::Trapperkeeper::Console_services[console-services]/Pe_hocon_setting[console-services.console.service-alert]: Scheduling refresh of Service[pe-console-services]
==> puppet.demo: Info: Puppet_enterprise::Trapperkeeper::Console_services[console-services]: Scheduling refresh of Service[pe-console-services]
==> puppet.demo: Notice: /Stage[main]/Puppet_enterprise::Console_services/Service[pe-console-services]: Triggered 'refresh' from 2 events
==> puppet.demo: Notice: Applied catalog in 53.88 seconds


al@mule pe_demo [ci] $ **vagrant provision puppet.demo**
==> puppet.demo: [vagrant-hostsupdater] Checking for host entries
==> puppet.demo: [vagrant-hostsupdater]   found entry for: 10.42.42.101 puppet.demo
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-48247-1y2iceu.sh
==> puppet.demo: ### Setting hostname puppet.demo
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-48247-11bd0pt.sh
==> puppet.demo: /opt/puppetlabs/bin/puppet
==> puppet.demo: Running provisioner: pe_bootstrap...
==> puppet.demo: Puppet Enterprise is already installed, skipping installation.
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-48247-1xpvm77.sh
==> puppet.demo: ### Found /var/tmp/vagrant-setup_papply.lock. Skipping installation of dependencies needed for puppet apply mode
==> puppet.demo: ## Remove /var/tmp/vagrant-setup_papply.lock on the Vagrant VM to retry their installation
==> puppet.demo: Running provisioner: pe_agent...
==> puppet.demo: The Puppet Server on puppet.demo is configured with Agent repositories for:
==> puppet.demo:   el-7-x86_64
==> puppet.demo: Puppet agent 4.8.1 is already installed, skipping installation.
==> puppet.demo: No pending signing request for puppet.demo on puppet.demo. Skipping autosign.
==> puppet.demo: Running provisioner: shell...
    puppet.demo: Running: /var/folders/y7/nr9q_gys5klb129t61wxxzz80000gn/T/vagrant-shell20170202-48247-1xhaqhe.sh
==> puppet.demo: ## Running puppet agent --server puppet.demo
==> puppet.demo: Info: Using configured environment 'production'
==> puppet.demo: Info: Retrieving pluginfacts
==> puppet.demo: Info: Retrieving plugin
==> puppet.demo: Info: Loading facts
==> puppet.demo: Info: Caching catalog for puppet.demo
==> puppet.demo: Info: Applying configuration version '1486074883'
==> puppet.demo: Notice: Applied catalog in 9.59 seconds


al@mule pe_demo [ci] $ **vagrant ssh puppet.demo**
[vagrant@puppet ~]$ **sudo su -**
[root@puppet ~]# **ls -l /etc/puppetlabs/code/environments/**
total 0
drwxr-xr-x. 1 vagrant   vagrant   1428 Feb  2 18:26 host
drwxr-xr-x. 5 pe-puppet pe-puppet   79 Feb  2 22:19 production


[root@puppet ~]# **puppet agent -t --environment=host**
Notice: Local environment: 'host' doesn't match server specified node environment 'production', switching agent to 'production'.
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Loading facts
Info: Caching catalog for puppet.demo
Info: Applying configuration version '1486075736'
Notice: Applied catalog in 15.07 seconds

[root@puppet ~]# **puppet agent -t --environment=host**
Info: Using configured environment 'host'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Notice: /File[/opt/puppetlabs/puppet/cache/lib/.gitkeep]/ensure: defined content as '{md5}d41d8cd98f00b204e9800998ecf8427e'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/archive_windir.rb]/ensure: defined content as '{md5}a646f8234e87041223c97dd919801ad8'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/facter_dot_d.rb]/ensure: defined content as '{md5}d71e93183a680ac78bc0389fd50470a0'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/ip6tables_version.rb]/ensure: defined content as '{md5}091123ad703f1706686bca4398c5b06f'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/iptables_persistent_version.rb]/ensure: defined content as '{md5}8ea76fecb8032174823ef6fb846c83c9'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/iptables_version.rb]/ensure: defined content as '{md5}facbd760223f236538b731c1d1f6cf8f'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/last_run.rb]/ensure: defined content as '{md5}12e7349e61a34e74901a0050f6db9ead'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/ostempdir.rb]/ensure: defined content as '{md5}652dac95805ad41fbf0bc5493a354e11'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/puppet_settings.rb]/ensure: defined content as '{md5}9e128c61600a7237cb5ed1ff25025d13'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/puppi_projects.rb]/ensure: defined content as '{md5}52c607131dc7a65db70d52f60e19bd09'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/root_home.rb]/ensure: defined content as '{md5}35702ae0c7410ec4d2101113e2f697fa'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/service_provider.rb]/ensure: defined content as '{md5}66cc42526eae631e306b397391f1f01c'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/util]/ensure: created
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/util/puppet_settings.rb]/ensure: defined content as '{md5}9f1d2593d0ae56bfca89d4b9266aeee1'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/vagrantversion.rb]/ensure: defined content as '{md5}3721c018d7051ff3087f95fabd1bc0ad'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter/windows_common_appdata.rb]/ensure: defined content as '{md5}ce068ea5a6d68a6f3cad50a919caa75f'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter_extra]/ensure: created
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter_extra/groups.rb]/ensure: defined content as '{md5}6152226a25f5c25f881de463f95ccda8'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter_extra/packages.rb]/ensure: defined content as '{md5}2961b92059d890bca3b2509ae5ba4d86'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter_extra/services.rb]/ensure: defined content as '{md5}8f4935baa7d525851890f0b2a17157a0'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter_extra/upgradable_packages.rb]/ensure: defined content as '{md5}23180420087a734c7606a6d5c1bafaff'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/facter_extra/users.rb]/ensure: defined content as '{md5}ad2ced1a9fb2bba3f90da47f8740b629'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/application/preview.rb]/ensure: defined content as '{md5}66df9ab588140c14cc629a3f7be5c59e'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/application/tp.rb]/ensure: defined content as '{md5}9ba96b22999374ddd71b36299cad62bd'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/commons]/ensure: created
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/commons/cache.rb]/ensure: defined content as '{md5}98dfe8b334e7e4b8d25de6d7803a0feb'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/face/tp.rb]/ensure: defined content as '{md5}876427a7c5d10101f3cf51f28d4d2e60'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/feature/aws.rb]/ensure: defined content as '{md5}c44c40a85419b991fb66d58130c05215'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/feature/retries.rb]/ensure: defined content as '{md5}12b8e31efe31fbf396663fac754211cb'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/deprecation.rb]/ensure: defined content as '{md5}a015e39d808300b4a0758674374ae001'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/gitlab_get_id.rb]/ensure: defined content as '{md5}e84028ebc0079d47647869566157efc4'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/is_a.rb]/ensure: defined content as '{md5}9dad7f8c9b75348cd97aca986ac0b29a'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/is_absolute_path.rb]/ensure: defined content as '{md5}96b217f26d06dbac87a2c6a8cfd2d8c8'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/is_array.rb]/ensure: defined content as '{md5}9292a646010d167417a1936b0b0c17b9'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/is_bool.rb]/ensure: defined content as '{md5}73957f9efd75ed8a7ab867f9de6da117'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/is_float.rb]/ensure: defined content as '{md5}af3bd6bb56878bac8cc4fe4f7564e4f9'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/is_ip_address.rb]/ensure: defined content as '{md5}ee231c66c3e039778bf46702d89815a6'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/is_ipv4_address.rb]/ensure: defined content as '{md5}900d33249906c4daa02aa79cac896548'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/is_ipv6_address.rb]/ensure: defined content as '{md5}568fba9af6a83c8b536fafcda82eb448'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/is_numeric.rb]/ensure: defined content as '{md5}33051800b886cc3b2119826b77c9821a'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/is_string.rb]/ensure: defined content as '{md5}230e9eabc5c9e1d8d5fb7b3c6c12b300'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/params_lookup.rb]/ensure: defined content as '{md5}030d49c52f1a8eaca578cbba1a852a96'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/type_of.rb]/ensure: defined content as '{md5}71e19f89e167c45ec691ea6c7d319625'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_absolute_path.rb]/ensure: defined content as '{md5}54a610baa115c7505f1b35976b632a8e'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_array.rb]/ensure: defined content as '{md5}9052b0026da174636c276a2512cf5acc'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_bool.rb]/ensure: defined content as '{md5}fe979e402a5a3a19d013ce84b39ef06a'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_hash.rb]/ensure: defined content as '{md5}92ea8fc21bbbf6cc41f6bb9cfcaefce7'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_integer.rb]/ensure: defined content as '{md5}b0982b68a599262da2c6f2e032bc7713'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_ip_address.rb]/ensure: defined content as '{md5}65a12af9a2c2a9c70d820d04d19ec891'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_ipv4_address.rb]/ensure: defined content as '{md5}4a5039b99ac97cc0447faa343b9f7416'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_ipv6_address.rb]/ensure: defined content as '{md5}fbdf685432416505fed27d5647c26f9c'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_legacy.rb]/ensure: defined content as '{md5}d9f115f30c511cef536a821b94826094'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_numeric.rb]/ensure: defined content as '{md5}41b2cc7335395f617c2bfbeac8f579da'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_re.rb]/ensure: defined content as '{md5}42092f592ebf89b8a504b10c900230d8'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_slength.rb]/ensure: defined content as '{md5}3ae6fcc3f60032c923d06ab3e457b84e'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/functions/validate_string.rb]/ensure: defined content as '{md5}cc967a9d0ea156b2208d1760d7f6e1b2'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/indirector]/ensure: created
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/indirector/catalog]/ensure: created
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/indirector/catalog/diff_compiler.rb]/ensure: defined content as '{md5}7701b452310c827ae65d9225a32d61a8'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/indirector/facts]/ensure: created
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/indirector/facts/diff_puppetdb.rb]/ensure: defined content as '{md5}3ad3fe57736651c636b8fd5532b4482b'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/abs.rb]/ensure: defined content as '{md5}32161bd0435fdfc2aec2fc559d2b454b'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/any2array.rb]/ensure: defined content as '{md5}a81e71d6b67a551d38770ba9a1948a75'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/any2bool.rb]/ensure: defined content as '{md5}9a33c68686b26701e2289f553bed78e5'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/artifactory_sha1.rb]/ensure: defined content as '{md5}4838e5244aa4c24c3a3581faa7863ada'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/assemble_nexus_url.rb]/ensure: defined content as '{md5}d37ee34c8b63728eefeca30ee3965509'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/assert_private.rb]/ensure: defined content as '{md5}1365284f9e474ecec24cfe43ee8e7cf4'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/base64.rb]/ensure: defined content as '{md5}ac8d0565df2931470447effa502c9ad3'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/basename.rb]/ensure: defined content as '{md5}c61952b3f68fd86408c84fca2c3febb1'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/bool2ensure.rb]/ensure: defined content as '{md5}7ed40cbdcb65556f5c9295a4088422a8'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/bool2num.rb]/ensure: defined content as '{md5}f953f5fc094c2ae3908a72d8840ba291'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/bool2str.rb]/ensure: defined content as '{md5}6334ac6d24a8aa49a2243fb425f47311'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/camelcase.rb]/ensure: defined content as '{md5}71c67b71eac4b7f46a0dd22cb915d2e6'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/capitalize.rb]/ensure: defined content as '{md5}da131748a9d32da9eb0b6438e39377eb'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/ceiling.rb]/ensure: defined content as '{md5}dfa9b1c75ce89344026b3b5aed2d190f'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/chomp.rb]/ensure: defined content as '{md5}2b7dc42f9967edd34cfa0ba9a97229ca'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/chop.rb]/ensure: defined content as '{md5}0ec76f54afd94201f35785dfeb2092b5'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/clamp.rb]/ensure: defined content as '{md5}d19b8dfc573ed2eff7e3536ae1e5d596'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/concat.rb]/ensure: defined content as '{md5}a1b0233e58f1f8095a74fe9300c74a9b'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/convert_base.rb]/ensure: defined content as '{md5}c3b3e59a49318af98dcb88aed7156629'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/count.rb]/ensure: defined content as '{md5}9eb74eccd93e2b3c87fd5ea14e329eba'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/deep_merge.rb]/ensure: defined content as '{md5}d83696855578fb81b64b9e92b9c7cc7c'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/defined_with_params.rb]/ensure: defined content as '{md5}80eed5cedb1b5134e6a1cf44e86ae60a'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/delete.rb]/ensure: defined content as '{md5}873d8244e7ecf7b2e56a46c2b3e09b4e'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/delete_at.rb]/ensure: defined content as '{md5}6bc24b79390d463d8be95396c963381a'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/delete_regex.rb]/ensure: defined content as '{md5}2fd4485e2526510dfde0a6687e23ee6e'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/delete_undef_values.rb]/ensure: defined content as '{md5}b32d4a3925753b2eb2c318cbd7f14404'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/delete_values.rb]/ensure: defined content as '{md5}39b147f7d369bb5f809044b6341954a2'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/deprecation.rb]/ensure: defined content as '{md5}edb7a9b440f0577a26aa04dbbdf37f9e'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/difference.rb]/ensure: defined content as '{md5}e31b95fbaf974cf853a510177368bfb9'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/dig.rb]/ensure: defined content as '{md5}1a2a8918f646c13dcb9876a22f9295ab'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/dig44.rb]/ensure: defined content as '{md5}8f4255bd98fe6a558cdb43a851e58ad3'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/dirname.rb]/ensure: defined content as '{md5}8a5579f9a9a13fd737ba65eccf8e6d5a'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/dos2unix.rb]/ensure: defined content as '{md5}be8359a5106a7832be4180e8207dd586'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/downcase.rb]/ensure: defined content as '{md5}73121616d73339cf8dd10e0de61a6c50'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/empty.rb]/ensure: defined content as '{md5}b4ad0c3c00cbc56f745fbc05af1efa00'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/enclose_ipv6.rb]/ensure: defined content as '{md5}581bc163291824909d1700909db96512'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/ensure_packages.rb]/ensure: defined content as '{md5}81a8edbd7b6f85fc90e458568184c356'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/ensure_resource.rb]/ensure: defined content as '{md5}de703fe63392b939fc2b4392975263de'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/ensure_resources.rb]/ensure: defined content as '{md5}e9543e167972dd6a9a88aa5e02a9b4a5'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/flatten.rb]/ensure: defined content as '{md5}25777b76f9719162a8bab640e5595b7a'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/floor.rb]/ensure: defined content as '{md5}42cad4c689231a51526c55a6f0985d1f'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/fqdn_rand_string.rb]/ensure: defined content as '{md5}9ac5f18e563094aee62ef7586267025d'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/fqdn_rotate.rb]/ensure: defined content as '{md5}770d510a2e50d19b2dd42b6edef3fb1f'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/get_class_args.rb]/ensure: defined content as '{md5}3a830d0d3af0f7c30002fa0213ccf555'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/get_insecure_authorized_key.rb]/ensure: defined content as '{md5}4e9f034d7bf645034790015ab029665a'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/get_latest_vagrant_version.rb]/ensure: defined content as '{md5}3881ad3e126c6fbbd525c78283f8f10c'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/get_magicvar.rb]/ensure: defined content as '{md5}24c1abf9c43e7cf7290efeda7d5dd403'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/get_module_path.rb]/ensure: defined content as '{md5}d4bf50da25c0b98d26b75354fa1bcc45'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/getparam.rb]/ensure: defined content as '{md5}440a9c381b9ad589504e2e9919e83c06'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/getvar.rb]/ensure: defined content as '{md5}0c8c5cef7e158e232a8cf6e42c10d0ff'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/go_md5.rb]/ensure: defined content as '{md5}845b2d433175a617d9a28cd33c25c3c5'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/grep.rb]/ensure: defined content as '{md5}5682995af458b05f3b53dd794c4bf896'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/has_interface_with.rb]/ensure: defined content as '{md5}e135f09dbecc038c3aa9ae03127617ef'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/has_ip_address.rb]/ensure: defined content as '{md5}ee207f47906455a5aa49c4fb219dd325'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/has_ip_network.rb]/ensure: defined content as '{md5}b4d726c8b2a0afac81ced8a3a28aa731'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/has_key.rb]/ensure: defined content as '{md5}7cd9728c38f0b0065f832dabd62b0e7e'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/hash.rb]/ensure: defined content as '{md5}784f8d2d114eb4c9414ebd8a6868f82f'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/intersection.rb]/ensure: defined content as '{md5}c8f4f8b861c9c297c87b08bdbfb94caa'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_absolute_path.rb]/ensure: defined content as '{md5}1ce9a6d1cd0a79087d73cb879ed04542'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_array.rb]/ensure: defined content as '{md5}343cdcafdb6d353773f14e6d8864d915'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_bool.rb]/ensure: defined content as '{md5}92589666ef0b0cccafb2c80bb786b3ff'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_domain_name.rb]/ensure: defined content as '{md5}6ca1f2708add756a6803b29d593d5830'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_email_address.rb]/ensure: defined content as '{md5}82573a431edf5a0bf9847393af27566a'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_float.rb]/ensure: defined content as '{md5}363e152a18e18997be12ab61b56c3160'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_function_available.rb]/ensure: defined content as '{md5}628428bbcd9313ce09783d9484330e09'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_hash.rb]/ensure: defined content as '{md5}8c7d9a05084dab0389d1b779c8a05b1a'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_integer.rb]/ensure: defined content as '{md5}c5f4aeb52da82e1d87f36b4b34349767'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_ip_address.rb]/ensure: defined content as '{md5}87316b88db72b2359351c7ab4426cdb4'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_ipv4_address.rb]/ensure: defined content as '{md5}0e2862f6280bff0f4c189b9f5f37a420'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_ipv6_address.rb]/ensure: defined content as '{md5}066706256a142573a96afb4615fe99a6'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_mac_address.rb]/ensure: defined content as '{md5}6dd3c96437d49e68630869b0b464e7f2'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_numeric.rb]/ensure: defined content as '{md5}72d25c5f9daae0220d64636efc6977b6'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/is_string.rb]/ensure: defined content as '{md5}028bac4d729e7b9990fbd5afb8cbc21b'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/join.rb]/ensure: defined content as '{md5}a285a05c015ae278608f6454aef211ea'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/join_keys_to_values.rb]/ensure: defined content as '{md5}f29da49531228f6ca5b3aa0df00a14c2'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/keys.rb]/ensure: defined content as '{md5}eb6ac815ea14fbf423580ed903ef7bad'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/load_module_metadata.rb]/ensure: defined content as '{md5}805c5476a6e7083d133e167129885924'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/loadjson.rb]/ensure: defined content as '{md5}ffecf61ba2ec8011915d37009b1a273e'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/loadyaml.rb]/ensure: defined content as '{md5}668265f14327cba1d1400f2078b7b26b'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/lstrip.rb]/ensure: defined content as '{md5}20a9b1fa077c16f34e0ef5448b895698'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/max.rb]/ensure: defined content as '{md5}f652fd0b46ef7d2fbdb42b141f8fdd1d'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/member.rb]/ensure: defined content as '{md5}2b5d7fb8f87f1c7d195933c57ca32e91'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/merge.rb]/ensure: defined content as '{md5}f3dcc5c83440cdda2036cce69b61a14b'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/min.rb]/ensure: defined content as '{md5}0d2a1b7e735ab251c5469e735fa3f4c6'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/noop.rb]/ensure: defined content as '{md5}3beb267e9bb2a1138d4593effc4691a8'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/nslookup.rb]/ensure: defined content as '{md5}976cfe36eec535d97a17139c7408f0bd'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/num2bool.rb]/ensure: defined content as '{md5}605c12fa518c87ed2c66ae153e0686ce'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/options_lookup.rb]/ensure: defined content as '{md5}5b5f8291e4b20c2aa31488b0ffe680b2'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/params_lookup.rb]/ensure: defined content as '{md5}a846d805db2a5fbb15b4ae8cfe060460'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/parsejson.rb]/ensure: defined content as '{md5}15165fd3807d9f3d657697fa854d643d'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/parseyaml.rb]/ensure: defined content as '{md5}db54578d9d798ced75952217cf11b737'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pick.rb]/ensure: defined content as '{md5}bf01f13bbfe2318e7f6a302ac7c4433f'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pick_default.rb]/ensure: defined content as '{md5}ad3ea60262de408767786d37a54d45dc'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pick_undef.rb]/ensure: defined content as '{md5}b9b8deabeaf0c12e5365132dedf668a1'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/prefix.rb]/ensure: defined content as '{md5}e377fd64bd63dde6c9660aa75aca4942'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/private.rb]/ensure: defined content as '{md5}1500a21d5cf19961c5b1d476df892d92'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/pw_hash.rb]/ensure: defined content as '{md5}d82221f667050026cd6d155432a31802'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/range.rb]/ensure: defined content as '{md5}2203172c91cc324e85433618597be3be'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/regexpescape.rb]/ensure: defined content as '{md5}f9cfb10f6acd1e318bf60bb7f561bde3'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/reject.rb]/ensure: defined content as '{md5}689f6a7c961a55fe9dcd240921f4c7f9'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/reverse.rb]/ensure: defined content as '{md5}b234b54b8cd62b2d67ccd70489ffdccf'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/rstrip.rb]/ensure: defined content as '{md5}b4e4ada41f7c1d2fcad073ce6344980f'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/seeded_rand.rb]/ensure: defined content as '{md5}2ad22e7613d894ae779c0c5b0e65dade'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/shell_escape.rb]/ensure: defined content as '{md5}b9298edaf48883d7b7d2dd8c76c25d2f'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/shell_join.rb]/ensure: defined content as '{md5}60817e59ed6eda2cc536d15c88d0d280'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/shell_split.rb]/ensure: defined content as '{md5}ed608feaf0f1c36a54a3a9459384d414'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/shuffle.rb]/ensure: defined content as '{md5}d50f72b0aeb921e64d2482f62488e2f3'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/size.rb]/ensure: defined content as '{md5}ab3b5b8cf2369d76969a7cb2564e018f'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/sort.rb]/ensure: defined content as '{md5}504b033b438461ca4f9764feeb017833'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/squeeze.rb]/ensure: defined content as '{md5}541f85b4203b55c9931d3d6ecd5c75f8'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/str2bool.rb]/ensure: defined content as '{md5}44b411fa76cd6713e37354280b102587'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/str2saltedsha512.rb]/ensure: defined content as '{md5}49afad7b386be38ce53deaefef326e85'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/strftime.rb]/ensure: defined content as '{md5}e02e01a598ca5d7d6eee0ba22440304a'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/strip.rb]/ensure: defined content as '{md5}85d70ab95492e3e4ca5f0b5ec3f284a9'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/suffix.rb]/ensure: defined content as '{md5}082519722ed6f237dd3a9a7e316ab2e4'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/swapcase.rb]/ensure: defined content as '{md5}b17a9f3cb0271451d309e4b4f52dd651'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/time.rb]/ensure: defined content as '{md5}8cb0b8320c60b4a21725634154a9f1db'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/to_bytes.rb]/ensure: defined content as '{md5}65437027687b6172173b3a211a799e37'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/tp_content.rb]/ensure: defined content as '{md5}d603e77ba87d717eb51687c8a31804bf'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/tp_install.rb]/ensure: defined content as '{md5}fcbf44805cb49c7cdc886c05a77dd2be'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/tp_lookup.rb]/ensure: defined content as '{md5}175f8e0ec508c134c0157c2b428163d7'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/tp_pick.rb]/ensure: defined content as '{md5}0310d496a69016fabaf65b1405c6c256'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/try_get_value.rb]/ensure: defined content as '{md5}09cd079ec5f0e5e2ac862c9ebe0f54fe'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/type.rb]/ensure: defined content as '{md5}4709f7ab8a8aad62d77a3c5d91a3aa08'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/type3x.rb]/ensure: defined content as '{md5}f9bf4de8341afb0c677c26b40ec8a2b2'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/union.rb]/ensure: defined content as '{md5}3cf57ea53f2522f586264feb67293cd6'
Notice: /File[/opt/puppetlabs/puppet/cache/lib/puppet/parser/functions/unique.rb]/ensure: defined content as '{md5}c1bb4a8aeebd09ba3e4c8bc3702cfd60'
Info: Loading facts
Info: Caching catalog for puppet.demo
Info: Applying configuration version 'c6be169 - Alessandro Franceschi, Thu Feb 2 20:57:56 2017 +0100 : Major realignment'
Notice: /Stage[main]/Profile::Repo::Generic/Tp::Repo[epel]/Yumrepo[epel]/ensure: created
Info: changing mode of /etc/yum.repos.d/epel.repo from 600 to 644
Notice: /Stage[main]/Profile::Sudo/File[/etc/sudoers]/content:
--- /etc/sudoers        2016-12-06 15:15:08.000000000 +0000
+++ /tmp/puppet-file20170202-17149-aauqo3       2017-02-02 22:50:46.626531832 +0000
@@ -1,111 +1,27 @@
-## Sudoers allows particular users to run various commands as
-## the root user, without needing the root password.
-##
-## Examples are provided at the bottom of the file for collections
-## of related commands, which can then be delegated out to particular
-## users or groups.
-##
-## This file must be edited with the 'visudo' command.
-
-## Host Aliases
-## Groups of machines. You may prefer to use hostnames (perhaps using
-## wildcards for entire domains) or IP addresses instead.
-# Host_Alias     FILESERVERS = fs1, fs2
-# Host_Alias     MAILSERVERS = smtp, smtp2
-
-## User Aliases
-## These aren't often necessary, as you can use regular groups
-## (ie, from files, LDAP, NIS, etc) in this file - just use %groupname
-## rather than USERALIAS
-# User_Alias ADMINS = jsmith, mikem
-
-
-## Command Aliases
-## These are groups of related commands...
-
-## Networking
-# Cmnd_Alias NETWORKING = /sbin/route, /sbin/ifconfig, /bin/ping, /sbin/dhclient, /usr/bin/net, /sbin/iptables, /usr/bin/rfcomm, /usr/bin/wvdial, /sbin/iwconfig, /sbin/mii-tool
-
-## Installation and management of software
-# Cmnd_Alias SOFTWARE = /bin/rpm, /usr/bin/up2date, /usr/bin/yum
-
-## Services
-# Cmnd_Alias SERVICES = /sbin/service, /sbin/chkconfig, /usr/bin/systemctl start, /usr/bin/systemctl stop, /usr/bin/systemctl reload, /usr/bin/systemctl restart, /usr/bin/systemctl status, /usr/bin/systemctl enable, /usr/bin/systemctl disable
-
-## Updating the locate database
-# Cmnd_Alias LOCATE = /usr/bin/updatedb
-
-## Storage
-# Cmnd_Alias STORAGE = /sbin/fdisk, /sbin/sfdisk, /sbin/parted, /sbin/partprobe, /bin/mount, /bin/umount
-
-## Delegating permissions
-# Cmnd_Alias DELEGATING = /usr/sbin/visudo, /bin/chown, /bin/chmod, /bin/chgrp
-
-## Processes
-# Cmnd_Alias PROCESSES = /bin/nice, /bin/kill, /usr/bin/kill, /usr/bin/killall
-
-## Drivers
-# Cmnd_Alias DRIVERS = /sbin/modprobe
-
-# Defaults specification
-
-#
-# Refuse to run if unable to disable echo on the tty.
-#
-Defaults   !visiblepw
-
-#
-# Preserving HOME has security implications since many programs
-# use it when searching for configuration files. Note that HOME
-# is already set when the the env_reset option is enabled, so
-# this option is only effective for configurations where either
-# env_reset is disabled or HOME is present in the env_keep list.
-#
+# File Managed by Puppet
+#
+Defaults    requiretty
 Defaults    always_set_home

 Defaults    env_reset
-Defaults    env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE KDEDIR LS_COLORS"
+Defaults    env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR LS_COLORS"
 Defaults    env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"
 Defaults    env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"
 Defaults    env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"
 Defaults    env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"

-#
-# Adding HOME to env_keep may enable a user to run unrestricted
-# commands via sudo.
-#
-# Defaults   env_keep += "HOME"
-
 Defaults    secure_path = /sbin:/bin:/usr/sbin:/usr/bin
+Defaults    log_year,logfile=/var/log/sudolog
+
+root    ALL=(ALL)       ALL
+
+Cmnd_Alias      SYSDOWN = /sbin/shutdown, /sbin/reboot, /sbin/init, /usr/sbin/pm-*
+Cmnd_Alias      PW = /usr/bin/passwd
+Cmnd_Alias      EDITORS = /usr/bin/vim,/*/vi
+Cmnd_Alias      SU = /bin/su
+Cmnd_Alias      SHELLS = /bin/ksh
+Cmnd_Alias      PASSWD = /usr/bin/passwd

-## Next comes the main part: which users can run what software on
-## which machines (the sudoers file can be shared between multiple
-## systems).
-## Syntax:
-##
-##     user    MACHINE=COMMANDS
-##
-## The COMMANDS section may have other options added to it.
-##
-## Allow root to run any commands anywhere
-root   ALL=(ALL)       ALL
-
-## Allows members of the 'sys' group to run networking, software,
-## service management apps and more.
-# %sys ALL = NETWORKING, SOFTWARE, SERVICES, STORAGE, DELEGATING, PROCESSES, LOCATE, DRIVERS
-
-## Allows people in group wheel to run all commands
-%wheel ALL=(ALL)       ALL
-
-## Same thing without a password
-# %wheel       ALL=(ALL)       NOPASSWD: ALL
-
-## Allows members of the users group to mount and unmount the
-## cdrom as root
-# %users  ALL=/sbin/mount /mnt/cdrom, /sbin/umount /mnt/cdrom

-## Allows members of the users group to shutdown this system
-# %users  localhost=/sbin/shutdown -h now

-## Read drop-in files from /etc/sudoers.d (the # here does not mean a comment)
 #includedir /etc/sudoers.d

Info: Computing checksum on file /etc/sudoers
Info: /Stage[main]/Profile::Sudo/File[/etc/sudoers]: Filebucketed /etc/sudoers to puppet with sum 93f8259808fc2832c31d81bbb571ead0
Notice: /Stage[main]/Profile::Sudo/File[/etc/sudoers]/content: content changed '{md5}93f8259808fc2832c31d81bbb571ead0' to '{md5}a0d13b2f1f2f3474510002e6b5f5992d'
Info: /Stage[main]/Profile::Sudo/File[/etc/sudoers]: Scheduling refresh of Exec[sudo_syntax_check]
Notice: /Stage[main]/Profile::Sudo/Exec[sudo_syntax_check]: Triggered 'refresh' from 1 events
Notice: /Stage[main]/Profile::Sudo/File[/etc/sudoers.d]/mode: mode changed '0750' to '0550'
Info: Computing checksum on file /etc/sudoers.d/vagrant
Info: /Stage[main]/Profile::Sudo/File[/etc/sudoers.d/vagrant]: Filebucketed /etc/sudoers.d/vagrant to puppet with sum 7589ececf72a42bc8b2d5d639b8d6839
Notice: /Stage[main]/Profile::Sudo/File[/etc/sudoers.d/vagrant]/ensure: removed
Notice: /Stage[main]/Profile::Time::Ntpdate/File[/etc/cron.d/ntpdate]/ensure: defined content as '{md5}677b2bacc46a2ef3d53d9c41830f4b13'
Notice: /Stage[main]/Profile::Timezone/File[timezone]/ensure: defined content as '{md5}4105d46bf09c111bab4117c694d89ceb'
Info: /Stage[main]/Profile::Timezone/File[timezone]: Scheduling refresh of Exec[set-timezone]
Notice: /Stage[main]/Profile::Timezone/Exec[set-timezone]: Triggered 'refresh' from 1 events
Notice: /Stage[main]/Profile::Dns::Resolver/File[/etc/resolv.conf]/content:
--- /etc/resolv.conf    2017-02-02 23:17:59.668645344 +0100
+++ /tmp/puppet-file20170202-17149-1ab52iw      2017-02-02 23:50:46.837538243 +0100
@@ -1,3 +1,3 @@
-# Generated by NetworkManager
-search hitronhub.home demo
-nameserver 10.0.2.3
+# File managed by Puppet
+nameserver 8.8.8.8
+nameserver 8.8.4.4

Info: Computing checksum on file /etc/resolv.conf
Info: /Stage[main]/Profile::Dns::Resolver/File[/etc/resolv.conf]: Filebucketed /etc/resolv.conf to puppet with sum 11c79c5d4d8d0b7a3fcf4eee67d6b396
Notice: /Stage[main]/Profile::Dns::Resolver/File[/etc/resolv.conf]/content: content changed '{md5}11c79c5d4d8d0b7a3fcf4eee67d6b396' to '{md5}3ccdb679ea166bdf52104b3ae3a4499d'
Notice: /Stage[main]/Profile::Hostname/Host[puppet]/ensure: created
Info: Computing checksum on file /etc/hosts
Notice: /Stage[main]/Profile::Hostname/File[/etc/sysconfig/network]/content:
--- /etc/sysconfig/network      2017-02-02 23:05:45.212065087 +0100
+++ /tmp/puppet-file20170202-17149-pxtvea       2017-02-02 23:50:46.867539154 +0100
@@ -1 +1,3 @@
-# Created by anaconda
+NETWORKING=yes
+NETWORKING_IPV6=no
+HOSTNAME=puppet.demo

Info: Computing checksum on file /etc/sysconfig/network
Info: /Stage[main]/Profile::Hostname/File[/etc/sysconfig/network]: Filebucketed /etc/sysconfig/network to puppet with sum 58bfe26480df2d26e2707741e0f0f08f
Notice: /Stage[main]/Profile::Hostname/File[/etc/sysconfig/network]/content: content changed '{md5}58bfe26480df2d26e2707741e0f0f08f' to '{md5}d8a8f06f0b5ea1e6614c9a0387c5d4fc'
Info: /Stage[main]/Profile::Hostname/File[/etc/sysconfig/network]: Scheduling refresh of Exec[apply_hostname]
Notice: /Stage[main]/Profile::Hostname/Exec[apply_hostname]: Triggered 'refresh' from 1 events
Notice: /Stage[main]/Tp/File[/etc/tp]/ensure: created
Notice: /Stage[main]/Tp/File[/etc/tp/app]/ensure: created
Notice: /Stage[main]/Profile::Mail::Postfix/Tp::Install[postfix]/File[/etc/tp/app/postfix]/ensure: defined content as '{md5}242ef1b7aaf61007004d520c02a7f43b'
Notice: /Stage[main]/Tp/File[/etc/tp/test]/ensure: created
Notice: /Stage[main]/Profile::Ssh::Openssh/Tp::Install[openssh]/File[/etc/tp/app/openssh]/ensure: defined content as '{md5}b352a3a76430d11ebdff74da12a10c79'
Notice: /Stage[main]/Profile::Logs::Rsyslog/Tp::Install[rsyslog]/File[/etc/tp/app/rsyslog]/ensure: defined content as '{md5}840fba105c2586ff542f4c173a4a329c'
Notice: /Stage[main]/Profile::Logs::Rsyslog/Tp::Conf[rsyslog]/File[/etc/rsyslog.conf]/content:
--- /etc/rsyslog.conf   2016-11-04 19:21:18.000000000 +0100
+++ /tmp/puppet-file20170202-17149-jeincg       2017-02-02 23:50:47.136547328 +0100
@@ -1,14 +1,13 @@
-# rsyslog configuration file
+# File Managed by Puppet
+# rsyslog v5 configuration file

 # For more information see /usr/share/doc/rsyslog-*/rsyslog_conf.html
 # If you experience problems, see http://www.rsyslog.com/doc/troubleshoot.html

 #### MODULES ####

-# The imjournal module bellow is now used as a message source instead of imuxsock.
 $ModLoad imuxsock # provides support for local system logging (e.g. via logger command)
-$ModLoad imjournal # provides access to the systemd journal
-#$ModLoad imklog # reads kernel messages (the same are read from journald)
+$ModLoad imklog   # provides kernel logging support (previously done by rklogd)
 #$ModLoad immark  # provides --MARK-- message capability

 # Provides UDP syslog reception
@@ -22,9 +21,6 @@

 #### GLOBAL DIRECTIVES ####

-# Where to place auxiliary files
-$WorkDirectory /var/lib/rsyslog
-
 # Use default timestamp format
 $ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat

@@ -35,13 +31,6 @@
 # Include all config files in /etc/rsyslog.d/
 $IncludeConfig /etc/rsyslog.d/*.conf

-# Turn off message reception via local log socket;
-# local messages are retrieved through imjournal now.
-$OmitLocalLogging on
-
-# File to store the position in the journal
-$IMJournalStateFile imjournal.state
-

 #### RULES ####

@@ -64,7 +53,7 @@
 cron.*                                                  /var/log/cron

 # Everybody gets emergency messages
-*.emerg                                                 :omusrmsg:*
+*.emerg                                                 *

 # Save news errors of level crit and higher in a special file.
 uucp,news.crit                                          /var/log/spooler
@@ -81,6 +70,7 @@
 #
 # An on-disk queue is created for this action. If the remote host is
 # down, messages are spooled to disk and sent when it is up again.
+#$WorkDirectory /var/lib/rsyslog # where to place spool files
 #$ActionQueueFileName fwdRule1 # unique name prefix for spool files
 #$ActionQueueMaxDiskSpace 1g   # 1gb space limit (use as much as possible)
 #$ActionQueueSaveOnShutdown on # save messages to disk on shutdown

Info: Computing checksum on file /etc/rsyslog.conf
Info: /Stage[main]/Profile::Logs::Rsyslog/Tp::Conf[rsyslog]/File[/etc/rsyslog.conf]: Filebucketed /etc/rsyslog.conf to puppet with sum 0dd94a0c285fb32f41fa5b226e83c26b
Notice: /Stage[main]/Profile::Logs::Rsyslog/Tp::Conf[rsyslog]/File[/etc/rsyslog.conf]/content: content changed '{md5}0dd94a0c285fb32f41fa5b226e83c26b' to '{md5}0d4a7c05e236ff134826e06b2054db71'
Info: /Stage[main]/Profile::Logs::Rsyslog/Tp::Conf[rsyslog]/File[/etc/rsyslog.conf]: Scheduling refresh of Service[rsyslog]
Notice: /Stage[main]/Profile::Logs::Rsyslog/Tp::Conf[rsyslog::20-default.conf]/File[/etc/rsyslog.d/20-default.conf]/ensure: defined content as '{md5}fe0d9feb97031a33a87da58c75bb1261'
Info: /Stage[main]/Profile::Logs::Rsyslog/Tp::Conf[rsyslog::20-default.conf]/File[/etc/rsyslog.d/20-default.conf]: Scheduling refresh of Service[rsyslog]
Notice: /Stage[main]/Profile::Logs::Rsyslog/Tp::Conf[rsyslog::50-default.conf]/File[/etc/rsyslog.d/50-default.conf]/ensure: defined content as '{md5}5aa052e3fa08f954c415be5b53e77b16'
Info: /Stage[main]/Profile::Logs::Rsyslog/Tp::Conf[rsyslog::50-default.conf]/File[/etc/rsyslog.d/50-default.conf]: Scheduling refresh of Service[rsyslog]
Notice: /Stage[main]/Profile::Logs::Rsyslog/Tp::Install[rsyslog]/Service[rsyslog]: Triggered 'refresh' from 3 events
Notice: /Stage[main]/Profile::Time::Ntpdate/Tp::Install[ntpdate]/Package[ntpdate]/ensure: created
Notice: /Stage[main]/Profile::Time::Ntpdate/Tp::Install[ntpdate]/File[/etc/tp/app/ntpdate]/ensure: defined content as '{md5}36523bbe51a352746224af21646f3258'
Info: Tp::Install[ntpdate]: Scheduling refresh of Exec[ntpdate -s pool.ntp.org]
Notice: /Stage[main]/Profile::Time::Ntpdate/Exec[ntpdate -s pool.ntp.org]: Triggered 'refresh' from 1 events
Notice: /Stage[main]/Profile::Sysctl/Tools::Sysctl[net.ipv4.conf.all.forwarding]/Sysctl[net.ipv4.conf.all.forwarding]/ensure: created
Info: Computing checksum on file /etc/sysctl.conf
Notice: /Stage[main]/Profile::Update/File[/usr/local/sbin/update.sh]/ensure: defined content as '{md5}78e7a2f40a85302c64cbc064744c62d5'
Notice: /Stage[main]/Tp/File[/usr/local/bin/tp]/ensure: defined content as '{md5}f4846ab759c1b3bfff5a9b1402b5635c'
Notice: Applied catalog in 45.22 seconds


[root@puppet ~]# **puppet agent -t --environment=host**
Info: Using configured environment 'host'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Loading facts
Info: Caching catalog for puppet.demo
Info: Applying configuration version 'c6be169 - Alessandro Franceschi, Thu Feb 2 20:57:56 2017 +0100 : Major realignment'
Notice: Applied catalog in 23.03 seconds
[root@puppet ~]#
