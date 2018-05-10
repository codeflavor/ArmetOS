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
authconfig --enableshadow --passalgo=sha512

selinux --permissive
firewall --disabled

bootloader --timeout=1 --append="no_timer_check console=tty1 console=ttyS0,115200n8"

network --onboot=yes --device=ens3 --bootproto=dhcp --noipv6 --activate --hostname armet


rootpw --plaintext 123123
user --groups=wheel --name armet --password=123123

zerombr
clearpart --all
autopart --noswap --nohome
#services --enabled=sshd,acpid,cloud-init

%packages --excludedocs --instLangs=en
>>>>>>> armetos: enable qcow2 image
@core
-@conflicts
openssh-server
cloud-init
cloud-utils
acpid
cloud-utils-growpart
%end

reboot

%post
echo "armet ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/armet
%end
