resource "google_compute_network" "test" {
  name                    = var.gke_config["network"]
  project                 = var.gke_config["project"]
  auto_create_subnetworks = var.gke_config["auto_create_subnetworks"]
}
resource "google_compute_subnetwork" "testgkesubnet" {
  name          = var.gke_config["subnetwork"]
  project       = var.gke_config["project"]
  ip_cidr_range = "10.2.0.0/27"
  region        = var.gke_config["region"]
  network       = google_compute_network.test.id
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "192.168.1.0/24"
  }
  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "192.168.64.0/22"
  }
}
