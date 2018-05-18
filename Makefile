OS_VERSION=0.1.0-alpha.3
OS_CODENAME=Soggy-Sock
PACKER_LOG=1

export OS_VERSION OS_CODENAME PACKER_LOG

.PHONY: clean
clean:
	@rm -rf armetos

build: clean
	@packer build ArmetOS-qcow2.json

compress:
	@rm -rf ArmetOS-${OS_CODENAME}-${OS_VERSION}.x86_64.tar.gz.xz || true
	@tar -czvf ArmetOS-${OS_CODENAME}-${OS_VERSION}.x86_64.tar.gz ./armetos/qemu/x86_64/soggy-sock/ArmetOS-Soggy-Sock-${OS_VERSION}.x86_64.qcow2
	@xz ArmetOS-${OS_CODENAME}-${OS_VERSION}.x86_64.tar.gz
