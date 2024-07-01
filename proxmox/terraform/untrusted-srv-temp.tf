####################################################
# Terraform Configuration: 
# Create VM on Proxmox from a full clone
####################################################

# VM Name: untrusted-srv-temp.home.balzers.xyz
# Description: Untrusted Server VLAN temporary server
# IP Address: 10.96.20.15/24
# VLAN: 962 (Untrusted Server VLAN)

# resource "proxmox_vm_qemu" "untrusted_srv_temp" {
    
#     # VM General Settings
#     target_node = "pve-01"
#     vmid = "205"
#     name = "untrusted-srv-temp.home.balzers.xyz"
#     desc = "Untrusted Server VLAN k3s Cluster Node 1"
#     pool = "pbs-backup"
#     tags = "pbs-backup, untrusted-server-vlan"
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
#         tag = 962
#     }

#     # VM Cloud-Init Settings
#     os_type = "cloud-init"

#     ipconfig0 = "ip=10.96.20.15/24,gw=10.96.20.1"
#     nameserver = "10.96.20.1"
#     searchdomain ="home.balzers.xyz"
#     ciuser = var.ci_user
#     cipassword = var.ci_password
    
#     sshkeys = <<EOF
#     ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIveS+0VyQkUC+y/FECgIGPxphMoO+2/Khoy7vR4LzDn Niklas-MBP
#     ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINo56L/uj6myLZT+doLr6Be4n2r8zppgouLtV8gTECuh niklas@im.local.zazen.li
#     EOF
# }