text
skipx
install
logging --level=info

lang en_US.UTF-8
keyboard us
timezone Europe/Berlin

url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-28&arch=x86_64 
repo --name=updates --baseurl=http://mirrorservice.org/sites/dl.fedoraproject.org/pub/fedora/linux/updates/28/Modular/x86_64/

auth --useshadow --enablemd5
authconfig 

selinux --permissive
firewall --disabled

bootloader --timeout=1 --append="no_timer_check console=tty1 console=ttyS0,115200n8"
network --bootproto=dhcp --activate --onboot=on --hostname ArmetOS

rootpw --plaintext 123123
user --groups=wheel --name armet --password=123123

zerombr
clearpart --all
part /boot --size 300 --fstype=xfs
part pv.01 --grow
volgroup armet-vg pv.01
logvol / --vgname=armet-vg --size=3000 --name=armet-rootvol --fstype=xfs
logvol /var --vgname=armet-vg --size=500 --name=armet-varvol --fstype=xfs


services --enabled=sshd,acpid

reboot

# Package list.
# FIXME: instLangs does not work, so there's a hack below
# (see https://bugzilla.redhat.com/show_bug.cgi?id=1051816)
%packages --instLangs=en --excludedocs 
acpid
kernel-core
@^cloud-server-environment

# rescue mode generally isn't useful in the cloud context
-dracut-config-rescue

# Some things from @core we can do without in a minimal install
-biosdevname
-plymouth
-iprutils
-kbd
-uboot-tools
-kernel

%end


%post
# setup systemd to boot to the right runlevel
echo -n "Setting default runlevel to multiuser text mode"
rm -f /etc/systemd/system/default.target
ln -s /lib/systemd/system/multi-user.target /etc/systemd/system/default.target
echo .

# this is installed by default but we don't need it in virt
echo "Removing linux-firmware package."
dnf -C -y erase linux-firmware

# Remove firewalld; was supposed to be optional in F18+, but is pulled in
# in install/image building.
echo "Removing firewalld."
# FIXME! clean_requirements_on_remove is the default with DNF, but may
# not work when package was installed by Anaconda instead of command line.
# Also -- check if this is still even needed with new anaconda -- disabled
# firewall should _not_ pull in this package.
# yum -C -y remove "firewalld*" --setopt="clean_requirements_on_remove=1"
dnf -C -y erase "firewalld*"

# Another one needed at install time but not after that, and it pulls
# in some unneeded deps (like, newt and slang)
echo "Removing authconfig."
dnf -C -y erase authconfig


echo -n "Getty fixes"
# although we want console output going to the serial console, we don't
# actually have the opportunity to login there. FIX.
# we don't really need to auto-spawn _any_ gettys.
sed -i '/^#NAutoVTs=.*/ a\
NAutoVTs=0' /etc/systemd/logind.conf

echo -n "Network fixes"
# initscripts don't like this file to be missing.
cat > /etc/sysconfig/network << EOF
NETWORKING=yes
NOZEROCONF=yes
EOF

# For cloud images, 'eth0' _is_ the predictable device name, since
# we don't want to be tied to specific virtual (!) hardware
rm -f /etc/udev/rules.d/70*
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules

# simple eth0 config, again not hard-coded to the build hardware
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
DEVICE="eth0"
BOOTPROTO="dhcp"
ONBOOT="yes"
TYPE="Ethernet"
PERSISTENT_DHCLIENT="yes"
EOF

# generic localhost names
cat > /etc/hosts << EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

EOF
echo .

systemctl mask tmp.mount

echo "armet ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/armet

rm -f /var/lib/rpm/__db*
rm -rf /etc/sysconfig/network-scripts/ifcg-ens3

echo "Zeroing out empty space."
# This forces the filesystem to reclaim space from deleted files
dd bs=1M if=/dev/zero of=/var/tmp/zeros || :
rm -f /var/tmp/zeros

echo "(Don't worry -- that out-of-space error was expected.)"

%end
