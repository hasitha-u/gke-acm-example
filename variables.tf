variable "cluster_prefix" {
  default = "test"
}

variable "gke_num_nodes" {
  default     = 3
  description = "number of gke nodes"
}

variable "gke_machine_type" {
  default     = "e2-standard-4"
  description = "Machine type"
}

variable "master_authorized_networks" {}

variable "vpc_name" {
  description = "Name of GKE cluster vpc"
}

variable "subnet_name" {
  description = "Name of GKE cluster subnet"
}

variable "pods_ip_range" {
  description = "GKE pods ip range"
}

variable "servies_ip_range" {
  description = "GKE services ip range"
}

variable "sync_repo" {
  type        = string
  description = "git URL for the repo which will be sync'ed into the cluster via Config Management"
}

variable "sync_branch" {
  type        = string
  default     = "main"
  description = "the git branch in the repo to sync"
}

variable "policy_dir" {
  type        = string
  default     = ""
  description = "the root directory in the repo branch that contains the resources."
}

variable "defender_namespace" {
  type        = string
  default     = "prisma-cloud-defender"
  description = "Namespace of the Prisma Cloud Defender"
}

variable "defender_sa_name" {
  type        = string
  default     = "twistlock-service"
  description = "Prisma Defender k8s service account name"
}
