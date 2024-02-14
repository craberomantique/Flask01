provider "google" {
  project = "pco-mo"
  region  = "europe-west9" # Change to your desired region
}

resource "google_compute_network" "my_network" {
  name = "my-network"
}

resource "google_compute_firewall" "allow_ssh_http" {
  name    = "allow-ssh-http"
  network = google_compute_network.my_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "my_instance" {
  name         = "my-instance"
  machine_type = "e2-medium" # Change to your desired machine type
  zone         = "europe-west9-a" # Change to your desired zone
  tags         = ["http", "ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.my_network.name
    access_config {}
  }
}
