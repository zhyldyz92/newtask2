resource "google_container_cluster" "primary" {
  name                      = var.gke_config["cluster_name"]
  project                   = var.gke_config["project"]
  location                  = var.gke_config["region"]
  initial_node_count        = var.gke_config["node_count"]
  network                   = google_compute_network.test.id
  subnetwork                = google_compute_subnetwork.testgkesubnet.id
  default_max_pods_per_node = var.gke_config["default_max_pods_per_node"]
  remove_default_node_pool  = true
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.3.0/28"
      display_name = "net1"
    }
  }
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "10.0.3.0/28"
  }
  ip_allocation_policy {
    cluster_secondary_range_name  = var.gke_config["cluster_range_name"]
    services_secondary_range_name = var.gke_config["services_range_name"]
  }
  master_auth {
    username = ""
    password = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.gke_config["node_pool1_name"]
  location   = var.gke_config["region"]
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_config["node_count"]
  node_config {
    preemptible  = var.gke_config["preemptible"]
    machine_type = var.gke_config["machine_type"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
resource "google_container_node_pool" "secondary_preemptible_nodes" {
  name       = var.gke_config["node_pool2_name"]
  location   = var.gke_config["region"]
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_config["node_count"]
  node_config {
    preemptible  = var.gke_config["preemptible"]
    machine_type = var.gke_config["machine_type"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
