text
skipx
install
logging --level=info

lang en_US.UTF-8
keyboard us
timezone Europe/Berlin

url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-27&arch=x86_64
repo --name=updates --baseurl=http://mirrorservice.org/sites/dl.fedoraproject.org/pub/fedora/linux/updates/27/x86_64/

services --enabled=sshd,acpid

auth --useshadow --enablemd5
authconfig --enableshadow --passalgo=sha512

selinux --enforcing
firewall --disabled

network --onboot=yes --device=ens3 --bootproto=dhcp --noipv6 --activate

rootpw --plaintext 123123
user --groups=wheel --name armet --password=123123

clearpart --all
autopart --noswap --nohome

%packages
@core
-@conflicts
openssh-server
cloud-init
acpid
cloud-utils-growpart
%end


reboot
