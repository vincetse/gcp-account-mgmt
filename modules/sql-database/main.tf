resource "random_id" "db_instance_suffix" {
  byte_length = 2
}

resource "google_sql_database_instance" "instance" {
  name = "${var.database_name}-${random_id.db_instance_suffix.dec}"
  database_version = var.database_version
  region = var.region
  project = var.project_id
  settings {
    tier = var.tier
    disk_type = "PD_HDD"
    maintenance_window {
      day = 7 # Sunday
      hour = 7
      update_track = "stable"
    }
  }
}

resource "google_sql_database" "db" {
  name = var.database_name
  instance = google_sql_database_instance.instance.name
  project = var.project_id
}

resource "google_sql_user" "readwrite_users" {
  count = length(var.readwrite_users)

  instance = google_sql_database_instance.instance.name
  name = var.readwrite_users[count.index]
  project = var.project_id
}

resource "google_sql_user" "readonly_users" {
  count = length(var.readonly_users)

  instance = google_sql_database_instance.instance.name
  name = var.readonly_users[count.index]
  project = var.project_id
}
