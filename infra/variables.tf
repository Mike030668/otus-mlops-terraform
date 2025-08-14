variable "zone" {
  description = "The availability zone to use for resources"
  type        = string
  default     = "ru-central1-a"
}

variable "cloud_id" {
  description = "The ID of the Yandex Cloud"
  type        = string
}

variable "folder_id" {
  description = "The ID of the Yandex Cloud folder"
  type        = string
}

variable "token" {
  description = "The OAuth token for Yandex Cloud"
  type        = string
}

variable "image_id" {
  description = "The ID of the Yandex Cloud image to use for the VM"
  type        = string
}

variable "disk_name" {
  description = "The name of the disk to create"
  type        = string
  default     = "mike-disk"
}

variable "disk_type" {
  description = "The type of disk to create"
  type        = string
  default     = "network-ssd"
}

variable "vm_name" {
  description = "The name of the VM to create"
  type        = string
  default     = "mike-vm"
}

variable "vm_cores" {
  description = "The number of CPU cores for the VM"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "The amount of memory (in GB) for the VM"
  type        = number
  default     = 4
}

variable "platform_id" {
  description = "The platform ID for the VM"
  type        = string
  default     = "standard-v3"  
}

variable "ssh_public_key" {
  description = "The path to the SSH public key file"
  type        = string
  default     = "~/.ssh/yd_edu.pub"
}

variable "network_name" {
  description = "The name of the VPC network to create"
  type        = string
  default     = "mike-network"
}

variable "subnet_name" {
  description = "The name of the VPC subnet to create"
  type        = string
  default     = "mike-subnet"
}

variable "sa_name" {
  description = "The name of the service account to create"
  type        = string
  default     = "mike-sa"
}

variable "bucket_name" {
  description = "The name of the storage bucket to create"
  type        = string
  default     = "mike-bucket-3668"
}

