proxmox_storage_pool = local-lvm

.PHONY: rhel9 all

all: rhel9

rhel9:
	packer init rhel9/packer.pkr.hcl && \
	packer build -force rhel9/packer.pkr.hcl