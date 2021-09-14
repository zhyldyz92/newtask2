variable "gke_config" {
  type = map(any)
  default = {
    project                   = "peak-argon-326019"
    region                    = "us-central1"
    zone                      = "us-central1-c"
    cluster_name              = "cluster-2"
    cluster_range_name        = "pod-ranges"
    services_range_name       = "services-range"
    default_max_pods_per_node = 16
    machine_type              = "e2-medium"
    node_count                = 1
    node_pool1_name           = "node-pool1"
    node_pool2_name           = "node-pool2"
    preemptible               = true
    network                   = "test"
    subnetwork                = "testgkesubnet"
    auto_create_subnetworks   = false
  }
}
