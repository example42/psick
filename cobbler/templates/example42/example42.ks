key --skip
auth  --useshadow  --enablemd5
bootloader --location=mbr
text
firewall --disable
selinux --permissive
firstboot --disable
keyboard it
lang en_US
timezone  Europe/Rome
url --url=$tree
$yum_repo_stanza
network --bootproto=static --ip=$ip_address --netmask=$subnet --hostname=$hostname --gateway=$gateway --device=eth0 --onboot=on
rootpw --iscrypted $1$i/FKPUYn$feFVmvGMk5YJ/bpm3XfvW.
reboot

bootloader --location=mbr --driveorder=xvda --append="rhgb quiet"

clearpart --all --initlabel --drives=xvda
part /boot --fstype ext3 --size=100 --ondisk=xvda
part pv.2 --size=0 --grow --ondisk=xvda
volgroup system --pesize=32768 pv.2
logvol / --fstype ext3 --name=lv00 --vgname=system --size=1024 --grow
logvol swap --fstype swap --name=lv01 --vgname=system --size=512 --grow --maxsize=544

%packages --nobase
crontabs
puppet
nfs-utils
openssh-clients
openssh-server
yum
wget

%post
$yum_config_stanza
hostname $hostname
# Uncomment for puppet run 
# puppetd --server <%= puppet_server %> -v -o --no-daemonize --tags repo,puppet,hosts,resolver --logdest /var/log/firstpuppetrun.log
# puppetd --server <%= puppet_server %> -v -o --no-daemonize --logdest /var/log/firstpuppetrun.log

$kickstart_done
%end

