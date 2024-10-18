provider "google" {
  project     = "eighth-upgrade-436909-e3"
  region      = "us-central1"
}

# Create a VPC network
resource "google_compute_network" "my_vpc" {
  name                    = "satya-vpc-network"
  auto_create_subnetworks = false  # Disable auto subnets
}

# Create a subnet within the VPC
resource "google_compute_subnetwork" "my_subnet" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/24"  # Specify your desired CIDR range
  region       = "us-central1"
  network      = google_compute_network.my_vpc.name
}

# Optional: Create a firewall rule to allow HTTP traffic
resource "google_compute_firewall" "http_allow" {
  name    = "allow-http"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allow traffic from anywhere
}
