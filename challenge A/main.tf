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

resource "google_compute_address" "static" {
  name = "ipv4-address"
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

  metadata = {
    ssh-keys = "${var.metadata_user}:${var.gce_ssh_pub_key_file}"
  }

  network_interface {
    network = google_compute_network.koinworks-vpc.self_link
    subnetwork = google_compute_subnetwork.subnet1.self_link
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
}

resource "null_resource" "configuring" {
  depends_on = [ google_compute_instance.wordpress-vm ]

  triggers = {
    date = timestamp()
  }

  provisioner "file" {
    source = "ansible/"
    destination = "/home/ariyolo/"

    connection {
      host = google_compute_address.static.address
      type = "ssh"
      user = "ariyolo"
      private_key = file("id_rsa")
    }
  }

  #Provisioning with Ansible
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y ansible python3-pip",
      "ansible-playbook playbook.yml"
    ]
    
    connection {
      host = google_compute_address.static.address
      type = "ssh"
      user = "ariyolo"
      private_key = file("id_rsa")
    }
  }
}