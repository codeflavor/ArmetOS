IMAGE_URI=https://download.fedoraproject.org/pub/fedora/linux/releases/26/CloudImages/x86_64/images/Fedora-Cloud-Base-26-1.5.x86_64.qcow2

.PHONY: clean
clean:
	@rm -rf base

get:
	@mkdir -p base
	@wget -P base ${IMAGE_URI}
