resource "google_service_account" "prisma-defender-gke-wi" {
  project      = var.project_id
  account_id   = "prisma-defender-gke-wi"
  display_name = "GKE Workload Identity service account for Prisma Defender"
}

resource "google_service_account_iam_binding" "prisma-defender-gke-wi" {
  service_account_id = google_service_account.prisma-defender-gke-wi.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[${var.defender_namespace}/${var.defender_sa_name}]",
  ]
}
