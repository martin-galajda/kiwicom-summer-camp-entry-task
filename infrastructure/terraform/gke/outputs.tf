output "gke_cluster_info" {
  description = "Information about the GKE cluster."

  value = {
    id = "${google_container_cluster.kiwicomsummercamp_gke_cluster.id}"
    name = "${google_container_cluster.kiwicomsummercamp_gke_cluster.name}"
    endpoint = "${google_container_cluster.kiwicomsummercamp_gke_cluster.endpoint}"
    cluster_autoscaling = "${google_container_cluster.kiwicomsummercamp_gke_cluster.cluster_autoscaling}"
    cluster_ipv4_cidr = "${google_container_cluster.kiwicomsummercamp_gke_cluster.cluster_ipv4_cidr}"
    zone = "${google_container_cluster.kiwicomsummercamp_gke_cluster.zone}"
    subnetwork = "${google_container_cluster.kiwicomsummercamp_gke_cluster.subnetwork}"
  }
}

output "gke_node_pool_info" {
  description = "Information about the GKE worker pool."

  value = {
    id = "${google_container_node_pool.kiwicomsummercamp_gke_node_pool.id}"
    cluster = "${google_container_node_pool.kiwicomsummercamp_gke_node_pool.cluster}"
    max_pods_per_node = "${google_container_node_pool.kiwicomsummercamp_gke_node_pool.max_pods_per_node}"
  }
}

output "gke_node_pool_node_config_info" {
  description = "Information about nodes in custom GKE worker pool."

  value = "${google_container_node_pool.kiwicomsummercamp_gke_node_pool.node_config}"
}
