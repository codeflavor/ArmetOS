lang en_US.UTF-8
keyboard us
timezone Europe/Berlin
auth --useshadow --enablemd5
selinux --enforcing
firewall --enabled --service=mdns
text
clearpart --all
autopart --noswap --nohome
skipx
repo --name=fedora --baseurl=http://mirrorservice.org/sites/dl.fedoraproject.org/pub/fedora/linux/releases/26/Everything/x86_64/os/
repo --name=updates --baseurl=http://mirrorservice.org/sites/dl.fedoraproject.org/pub/fedora/linux/updates/26/x86_64/
#repo --name=updates-testing --baseurl=http://mirrorservice.org/sites/dl.fedoraproject.org/pub/fedora/linux/updates/testing/26/x86_64/
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-26&arch=x86_64

rootpw --iscrypted s0ufrQlioP4xQ
%packages
@core
%end
reboot
