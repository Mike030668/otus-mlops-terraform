# https://registry.terraform.io/providers/yandex-cloud/yandex/0.148.0/docs/resources/compute_instance

// Create a new Compute Disk.
resource "yandex_compute_disk" "disk" {
  name     = var.disk_name
  type     = var.disk_type
  zone     = var.zone
  image_id = var.image_id
}

// Create a new Compute Instance
resource "yandex_compute_instance" "vm" {
  name        = var.vm_name
  platform_id = var.platform_id
  zone        = var.zone

  resources {
    cores  = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    disk_id = yandex_compute_disk.disk.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key)}"
  }
}

// Auxiliary resources for Compute Instance
resource "yandex_vpc_network" "network" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "subnet" {
  zone           = var.zone
  name           = var.subnet_name
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}

// Simple Private Bucket With Static Access Keys.
// Create SA
resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = var.sa_name
}

// Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Use keys to create bucket
resource "yandex_storage_bucket" "bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = var.bucket_name
}
