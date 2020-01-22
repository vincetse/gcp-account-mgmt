provider "google-beta" {
  project = "focus-beacon-265714"
  region  = "us-central1"
  zone    = "us-central1-c"
}

provider "google" {
  project = "focus-beacon-265714"
  region  = "us-central1"
  zone    = "us-central1-c"
}

data "google_organization" "org" {
  domain = "thelazyenginerd.github.io"
}

################################################################################
# Folders
resource "google_folder" "se" {
  display_name = "Solutions Engineering"
  parent = data.google_organization.org.name
}

resource "google_folder" "dev" {
  display_name = "Product Development"
  parent = data.google_organization.org.name
}

resource "google_folder" "sandbox" {
  display_name = "GCloud Sandbox"
  parent = data.google_organization.org.name
}


################################################################################
# project
module "project1" {
  source = "./modules/project"
  project_name = "My GAE"
  project_id_prefix = "my-gae"
  parent_id = google_folder.sandbox.name
  readonly_users = [
    "user:oranchirapuntu@thelazyenginerd.github.io",
  ]
  readwrite_users = [
    "user:vincetse@thelazyenginerd.github.io",
  ]
}

output "project1_id" {
  value = module.project1.project_id
}
