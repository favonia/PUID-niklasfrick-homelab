####################################################
# Terraform Configuration: 
# Create VM on Proxmox from a full clone
####################################################

# VM Name: im.local.zazen.li
# Description: Trusted Server VLAN Infrastructure Management Server
# IP Address: 10.96.10.3/24
# VLAN: 961 (Trusted Server VLAN)

resource "proxmox_vm_qemu" "infrastructure_manager" {
    
    # VM General Settings
    target_node = "pve"
    vmid = "100"
    name = "im.local.zazen.li"
    desc = "Trusted Server VLAN Infrastructure Management Server"
    pool = "pbs-backup"
    tags = "pbs-backup"
    qemu_os = "l26"

    # VM Advanced General Settings
    onboot = true 

    # VM OS Settings
    clone = "rhel9-server-template"

    # VM System Settings
    agent = 1
    
    # VM CPU Settings
    cores = 2
    sockets = 1
    cpu = "host"    
    
    # VM Memory Settings
    memory = 6144

    scsihw = "virtio-scsi-single"

    # VM Network Settings
    network {
        bridge = "vmbr0"
        model  = "virtio"
        tag = 961
        macaddr = "BC:24:11:EA:BA:17"
    }

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    ipconfig0 = "ip=10.96.10.3/24,gw=10.96.10.1"
    nameserver = "10.96.10.1"
    searchdomain ="local.zazen.li"
    ciuser = var.ci_user
    cipassword = var.ci_password
    
    sshkeys = <<EOF
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIveS+0VyQkUC+y/FECgIGPxphMoO+2/Khoy7vR4LzDn Niklas-MBP
    EOF
}

resource "unifi_user" "infrastructure_manager" {
  mac  = proxmox_vm_qemu.infrastructure_manager.network[0].macaddr
  name = proxmox_vm_qemu.infrastructure_manager.name
  note = proxmox_vm_qemu.infrastructure_manager.desc
  local_dns_record = proxmox_vm_qemu.infrastructure_manager.name

  fixed_ip   = proxmox_vm_qemu.infrastructure_manager.default_ipv4_address
  network_id = proxmox_vm_qemu.infrastructure_manager.network[0].tag
}

resource "ansible_host" "infrastructure_manager" {
  name = proxmox_vm_qemu.infrastructure_manager.name
  groups = ["rhel_hosts", "linux"]
}