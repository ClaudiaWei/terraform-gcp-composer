variable "project_id" {
  type        = string
  description = "GCP project name"
  default     = "<your-project-id>"
}

variable "env" {
  type        = string
  description = "GCP project environment"
  default     = "dev"
}

variable "slack_channel_name" {
  type        = string
  description = "composer environment variables"
  default     = "#notification-airflow-dev"
}

variable "region" {
  type        = string
  description = "Project region"
  default     = "us-west1"
}


variable "service_account" {
  type        = string
  description = "GCP service account"
  default     = "845143521555-compute@developer.gserviceaccount.com"
}
