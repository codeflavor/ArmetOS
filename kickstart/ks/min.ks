text
skipx
install

lang en_US.UTF-8
keyboard us
timezone Europe/Berlin

url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-27&arch=x86_64
repo --name=updates --baseurl=http://mirrorservice.org/sites/dl.fedoraproject.org/pub/fedora/linux/updates/27/x86_64/

auth --useshadow --enablemd5
authconfig --enableshadow --passalgo=sha512

selinux --enforcing
firewall --enabled --service=mdns
network --onboot=yes --device=eth0 --bootproto=dhcp --noipv6 --activate

rootpw --plaintext 123123
user --groups=wheel --name armet --password=123123


clearpart --all
autopart --noswap --nohome

%packages
@core
%end


reboot
