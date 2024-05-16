####################################################
# Terraform Configuration: 
# Create VM on Proxmox from a full clone
####################################################

# VM Name: plex.local.zazen.li
# Description: Plex Media Server (Untrusted Server VLAN)
# IP Address: 10.96.20.10/24
# VLAN: 962 (Untrusted Server VLAN)

resource "unifi_user" "plex" {
  mac  = "BC:24:11:9D:E6:B1"
  name = "plex.local.zazen.li"
  note = "Plex Media Server (Untrusted Server VLAN)"
  local_dns_record = "plex.local.zazen.li"

  fixed_ip   = "10.96.20.10"
  network_id = "962"
}

resource "ansible_host" "plex" {
  name = "plex.local.zazen.li"
  groups = ["rhel_hosts", "linux"]
}