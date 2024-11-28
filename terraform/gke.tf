resource "google_container_cluster" "myapp-infra" {
  name               = "myapp-infra"
  location           = "asia-northeast1-a"

  node_pool {
    name       = "default-pool"
    node_count = 1

    node_config {
      machine_type = "e2-medium"
      disk_size_gb = 30
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
    ]
    }
  }
}


output "gke_endpoint" {
  value = google_container_cluster.myapp-infra.endpoint
}

output "gke_ca_certificate" {
  value = google_container_cluster.myapp-infra.master_auth.0.cluster_ca_certificate
}

