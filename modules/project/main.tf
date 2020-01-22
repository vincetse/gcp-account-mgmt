resource "random_id" "project_id" {
  prefix = "${var.project_id_prefix}-"
  byte_length = 4
}

resource "google_project" "proj" {
  name       = var.project_name
  project_id = random_id.project_id.dec
  folder_id  = var.parent_id
}

resource "google_project_iam_binding" "readwrite" {
  project = google_project.proj.project_id
  role    = "roles/editor"
  members = var.readwrite_users
}

resource "google_project_iam_binding" "readonly" {
  project = google_project.proj.project_id
  role    = "roles/viewer"
  members = var.readonly_users
}
