resource "random_string" "rw_user" {
  length = 14
  special = false
  number = false
  upper = false
  lower = true
}

resource "random_string" "rw_pass" {
  length = 128
  special = false
  number = true
  upper = true
  lower = true
}

resource "random_string" "ro_user" {
  length = 14
  special = false
  number = false
  upper = false
  lower = true
}

resource "random_string" "ro_pass" {
  length = 128
  special = false
  number = true
  upper = true
  lower = true
}

module "db" {
  source = "../../modules/sql-database"
  database_name = "${var.app_name}-db"
  database_version = var.database_version
  region = var.region
  project_id = var.project_id
  tier = var.database_tier
  readwrite_users = [
    "urw${random_string.rw_user.result}",
  ]
  readonly_users = [
    "uro${random_string.ro_user.result}",
  ]
}

resource "google_app_engine_application" "app" {
  project = var.project_id
  location_id = var.region
}
