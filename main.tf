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
