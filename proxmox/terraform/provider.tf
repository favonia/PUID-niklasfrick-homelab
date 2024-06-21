# Proxmox Provider
# ---
# Initial Provider Configuration for Proxmox

terraform {

    required_version = ">= 0.13.0"

    required_providers {
        proxmox = {
            source = "TheGameProfi/proxmox"
            version = "2.9.15"
        }
        unifi = {
            source = "paultyng/unifi"
            version = "0.41.0"
            }
        ansible = {
            source = "ansible/ansible"
            version = ">=1.2.0"
        }
    }
}

variable "TF_VAR_proxmox_api_url" {
    type = string
}

variable "TF_VAR_proxmox_api_token_id" {
    type = string
    sensitive = true
}

variable "TF_VAR_proxmox_api_token_secret" {
    type = string
    sensitive = true
}

variable "TF_VAR_ci_user" {
    type = string
    sensitive = true
}

variable "TF_VAR_ci_password" {
    type = string
    sensitive = true
}

variable "unifi_username" {
    type = string
    sensitive = true
}

variable "unifi_password" {
    type = string
    sensitive = true
}

variable "unifi_api_url" {
    type = string
}

variable "unifi_insecure" {
    type = string
}

provider "proxmox" {

    pm_api_url = var.TF_VAR_proxmox_api_url
    pm_api_token_id = var.TF_VAR_proxmox_api_token_id
    pm_api_token_secret = var.TF_VAR_proxmox_api_token_secret
}

provider "unifi" {
    username = var.unifi_username
    password = var.unifi_password
    api_url  = var.unifi_api_url
    allow_insecure = var.unifi_insecure
}