resource "google_container_cluster" "kiwicomsummercamp_gke_cluster" {
  name     = "${var.project}-cluster-${terraform.workspace}"
  location = "${var.gcp_cluster_location}"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count = 1

  addons_config {
    kubernetes_dashboard {
      disabled = false
    }
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "kiwicomsummercamp_gke_node_pool" {
  name       = "${var.project}-cluster-pool-${terraform.workspace}"
  location   = "${var.gcp_cluster_location}"
  cluster    = "${google_container_cluster.kiwicomsummercamp_gke_cluster.name}"
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]

    labels = {
      node_kind = "worker-node-custom-pool"
    }

    tags = ["worker-node", "worker-node-custom-pool"]
  }
}

data "google_container_registry_image" "debian" {
  name = "debian"
}

output "gcr_location" {
  value = "${data.google_container_registry_image.debian.image_url}"
}
