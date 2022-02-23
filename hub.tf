resource "google_gke_hub_feature" "configmanagement_acm_feature" {
  provider = google-beta
  name     = "configmanagement"
  location = "global"
  project  = var.project_id
}

resource "google_gke_hub_membership" "membership" {
  provider = google-beta

  project       = var.project_id
  membership_id = "membership-hub-${module.gke.name}"
  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${module.gke.cluster_id}"
    }
  }
}

resource "google_gke_hub_feature_membership" "feature_member" {
  provider = google-beta

  project    = var.project_id
  location   = "global"
  feature    = "configmanagement"
  membership = google_gke_hub_membership.membership.membership_id
  configmanagement {
    version = "1.10.1"
    config_sync {
      source_format = "unstructured"
      git {
        sync_repo   = var.sync_repo
        # https_proxy = var.https_proxy # URL for the HTTPS proxy to be used when communicating with the Git repo.
        sync_branch = var.sync_branch
        # policy_dir  = var.policy_dir  # The path within the Git repository that represents the top level of the repo to sync. Default: the root directory of the repository.
        secret_type = "token"
      }
    }
  }
  depends_on = [
    google_gke_hub_feature.configmanagement_acm_feature
  ]
}