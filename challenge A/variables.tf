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

variable "gce_ssh_pub_key_file" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCZKpkc9kNMN8JX5j+kN4pEkpgYU3l8v77tXhaKfJYy71MnS74o9FDLETlCejwkZ7UwKnANoGUSlivwTcqbJVQqw2NkcIBWM/65VBiYzFkGOK+BE++oEdsVExw7GmbUK7SCvWsuqru8qhx8BMpasbYLRrmBOfDlTMwn2KMTtmeGnWaYmhqD7l/lbUtg5ADGi+eEC0eJ/c6zyrR3lg1MD75lADBBa3FGyTwZ3v/pO7lMjFbIzawveK7t41anJcxjDs/dzIS2bbZk3oJcxcofk8qTK2PkNYQSmfv7hBjreE5mfYJS9keJZEfw9EbRlrPJnP/LGM6RTQbR61leo6O3RD2TBOCQ2fz90AnkM7KtGBe0S/bsiJPsykDbnmKD6cMtUtFz2fPFIlFpHDtQhLXoPm3U960Ybe1jfEIELgOkfpnLiBt0UgRD4r29Osoqyea+mLYCqp14GhW2tDGQ8G4NxEtnkVYUiSnpcN2X0TktrHQdtkFrVBzhNpsmkhBFZ34NF10= ariyolo@mjolnir"
}

variable "metadata_user" {
  default = "ariyolo"
}