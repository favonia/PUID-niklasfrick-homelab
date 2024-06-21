####################################################
# Terraform Configuration: 
# Create VM on Proxmox from a full clone
####################################################

# VM Name: k3s-01.local.zazen.li
# Description: Untrusted Server VLAN k3s Cluster Node 4
# IP Address: 10.96.20.14/24
# VLAN: 962 (Untrusted Server VLAN)

resource "proxmox_vm_qemu" "k3s_04" {
    
    # VM General Settings
    target_node = "pve"
    vmid = "204"
    name = "k3s-04.local.zazen.li"
    desc = "Untrusted Server VLAN k3s Cluster Node 4"
    pool = "pbs-backup"
    tags = "pbs-backup, untrusted-server-vlan"
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
    memory = 4096

    scsihw = "virtio-scsi-single"

    # VM Network Settings
    network {
        bridge = "vmbr0"
        model  = "virtio"
        tag = 962
    }

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    ipconfig0 = "ip=10.96.20.14/24,gw=10.96.20.1"
    nameserver = "10.96.20.1"
    searchdomain ="local.zazen.li"
    ciuser = var.TF_VAR_ci_user
    cipassword = var.TF_VAR_ci_password
    
    sshkeys = <<EOF
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIveS+0VyQkUC+y/FECgIGPxphMoO+2/Khoy7vR4LzDn Niklas-MBP
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINo56L/uj6myLZT+doLr6Be4n2r8zppgouLtV8gTECuh niklas@im.local.zazen.li
    EOF
}

resource "unifi_user" "k3s_04_trusted_server_vlan" {
  mac  = proxmox_vm_qemu.k3s_04.network[0].macaddr
  name = proxmox_vm_qemu.k3s_04.name
  note = proxmox_vm_qemu.k3s_04.desc
  local_dns_record = proxmox_vm_qemu.k3s_04.name

  fixed_ip   = proxmox_vm_qemu.k3s_04.default_ipv4_address
  network_id = proxmox_vm_qemu.k3s_04.network[0].tag
}

resource "ansible_host" "k3s_04" {
  name = proxmox_vm_qemu.k3s_04.name
  groups = ["rhel_hosts", "linux", "k3s-untrusted"]
}