variable "credentials_file" {
  description = "path to the GCP service account JSON key file"
}

variable "project_id" {
  description = "project ID at GCP"
}

variable "region" {
  default = "asia-southeast2"
}

variable "network_name" {
  default = "my-vpc"
}

variable "subnet_name" {
  default = "my-subnet"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}