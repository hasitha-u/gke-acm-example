module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = var.project_id
  name                       = "${var.cluster_prefix}-gke"
  region                     = var.region
  zones                      = ["europe-west2-a", "europe-west2-b"]
  network                    = var.vpc_name
  subnetwork                 = var.subnet_name
  ip_range_pods              = var.pods_ip_range
  ip_range_services          = var.servies_ip_range
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true
  enable_private_endpoint    = false
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "172.16.0.0/28"
  master_authorized_networks = var.master_authorized_networks
  kubernetes_version         = "1.21.6-gke.1500"

  node_pools = [
    {
      name            = "${var.cluster_prefix}-node-pool"
      machine_type    = var.gke_machine_type
      node_locations  = "europe-west2-a"
      min_count       = 3
      max_count       = 3
      local_ssd_count = 0
      disk_size_gb    = 50
      disk_type       = "pd-standard"
      image_type      = "COS_CONTAINERD"
      auto_repair     = true
      auto_upgrade    = true
      preemptible        = false
      initial_node_count = 3
    },
  ]

  node_pools_oauth_scopes = {
    #all = []
    all = ["https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring"]

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}
