IMAGE_URI=https://download.fedoraproject.org/pub/fedora/linux/releases/26/Server/x86_64/iso/Fedora-Server-netinst-x86_64-26-1.5.iso

.PHONY: clean
clean:
	@rm -rf base

get:
	@mkdir -p base
	@wget -P base ${IMAGE_URI}
