resource "google_compute_network" "airflow_vpc" {
  name                    = "airflow-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "airflow_subnet" {
  name          = "airflow-subnet"
  ip_cidr_range = "<your-ip-cidr-range>"
  region        = var.region
  network       = google_compute_network.airflow_vpc.id
}

locals {
  requirements = [
    for line in split("\n", file("./requirements.txt")):
    split("==", trimspace(line))
  ]
  pypi_packages = {for line in local.requirements : line[0] => format("==%s",line[1])}
}

resource "google_composer_environment" "airflow" {
  name   = "airflow"
  region = var.region
  config {
    software_config {
      image_version = "composer-2-airflow-2"
      pypi_packages = local.pypi_packages
      env_variables = {
        ENV           = var.env
        SLACK_CHANNEL = var.slack_channel_name
      }
      airflow_config_overrides = {
        operators-allow_illegal_arguments = "True"
        core-dags_are_paused_at_creation  = "True"
        webserver-dag_default_view        = "graph"
      }
    }
    private_environment_config {
      cloud_composer_connection_subnetwork = google_compute_subnetwork.airflow_subnet.id
      enable_privately_used_public_ips     = false
      enable_private_endpoint              = false
    }
    workloads_config {
      scheduler {
        cpu        = 2
        memory_gb  = 4
        storage_gb = 2
        count      = 2
      }
      web_server {
        cpu        = 2
        memory_gb  = 4
        storage_gb = 2
      }
      worker {
        cpu        = 2
        memory_gb  = 4
        storage_gb = 2
        min_count  = 1
        max_count  = 3
      }
    }
    environment_size = "ENVIRONMENT_SIZE_SMALL"

    node_config {
      network         = google_compute_network.airflow_vpc.id
      subnetwork      = google_compute_subnetwork.airflow_subnet.id
      service_account = var.service_account
    }
  }
}
