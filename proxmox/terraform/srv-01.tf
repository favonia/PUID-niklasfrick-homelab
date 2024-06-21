####################################################
# Terraform Configuration: 
# Create VM on Proxmox from a full clone
####################################################

# VM Name: srv-01.home.balzers.xyz
# Description: Trusted Server VLAN Server 1
# IP Address: 10.96.10.20/24
# VLAN: 961 (Trusted Server VLAN)

# resource "proxmox_vm_qemu" "srv_01" {
    
#     # VM General Settings
#     target_node = "pve"
#     vmid = "102"
#     name = "srv-01.home.balzers.xyz"
#     desc = "Trusted Server VLAN Server 1"
#     pool = "pbs-backup"
#     tags = "pbs-backup"
#     qemu_os = "l26"

#     # VM Advanced General Settings
#     onboot = true 

#     # VM OS Settings
#     clone = "rhel9-server-template"

#     # VM System Settings
#     agent = 1
    
#     # VM CPU Settings
#     cores = 2
#     sockets = 1
#     cpu = "host"    
    
#     # VM Memory Settings
#     memory = 4096

#     scsihw = "virtio-scsi-single"

#     # VM Network Settings
#     network {
#         bridge = "vmbr0"
#         model  = "virtio"
#         tag = 961
#     }

#     # VM Cloud-Init Settings
#     os_type = "cloud-init"

#     ipconfig0 = "ip=10.96.10.20/24,gw=10.96.10.1"
#     nameserver = "10.96.10.1"
#     searchdomain ="local.zazen.li"
#     ciuser = var.ci_user
#     cipassword = var.ci_password
    
#     sshkeys = <<EOF
#     ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIveS+0VyQkUC+y/FECgIGPxphMoO+2/Khoy7vR4LzDn Niklas-MBP
#     ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINo56L/uj6myLZT+doLr6Be4n2r8zppgouLtV8gTECuh niklas@im.local.zazen.li
#     EOF
# }

# resource "unifi_user" "k8s_master_trusted_server_vlan" {
#   mac  = proxmox_vm_qemu.k8s_master.network[0].macaddr
#   name = proxmox_vm_qemu.k8s_master.name
#   note = proxmox_vm_qemu.k8s_master.desc
#   local_dns_record = proxmox_vm_qemu.k8s_master.name

#   fixed_ip   = proxmox_vm_qemu.k8s_master.default_ipv4_address
#   network_id = proxmox_vm_qemu.k8s_master.network[0].tag
# }

# resource "ansible_host" "k8s_master" {
#   name = proxmox_vm_qemu.k8s_master.name
#   groups = ["rhel_hosts", "linux", "k8s-trusted"]
# }