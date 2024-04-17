#VPC
resource "google_compute_network" "koinworks-vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

#Subnet
resource "google_compute_subnetwork" "subnet1" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.koinworks-vpc.self_link
  region        = var.region
}

#Firewall
resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = google_compute_network.koinworks-vpc.self_link
  allow {
    protocol  = "tcp"
    ports     = ["22", "80", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
}

#VM
resource "google_compute_instance" "wordpress-vm" {
  name          = "wordpress-vm"
  machine_type  = "e2-medium"
  zone          = "asia-southeast2-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size = 30
    }
  }

  network_interface {
    network = google_compute_network.koinworks-vpc.self_link
    subnetwork = google_compute_subnetwork.subnet1.self_link
    access_config {
      
    }
  }

  # Provisioning with Ansible
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y python3-pip",
      "pip3 install ansible"
    ]
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.network_interface.0.access_config.0.nat_ip},' -u ariyolo --private-key=~/.ssh/id_rsa ./ansible/playbook.yml"
  }
}