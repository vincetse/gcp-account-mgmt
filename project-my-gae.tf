locals {
  gae_project_id_prefix = "my-gae"
}

resource "random_id" "project_id" {
  prefix = "${local.gae_project_id_prefix}-"
  byte_length = 4
}

resource "google_project" "appengine1" {
  name       = "My GAE"
  project_id = random_id.project_id.dec
  folder_id  = google_folder.sandbox.name
}

resource "google_project_iam_member" "project" {
  project = google_project.appengine1.project_id
  role    = "roles/editor"
  member  = "user:vincetse@thelazyenginerd.github.io"
}

resource "google_app_engine_application" "app" {
  project = google_project.appengine1.project_id
  location_id = "us-central"
}
