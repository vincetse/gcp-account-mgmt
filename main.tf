provider "google-beta" {
  region  = "us-central1"
  zone    = "us-central1-c"
}

provider "google" {
  region  = "us-central1"
  zone    = "us-central1-c"
}

data "google_organization" "org" {
  domain = "thelazyenginerd.github.io"
}

################################################################################
# Billing
#
# Create multiple Billing Accounts by department so that we can track spend
# by department, or even by product.  Projects then get assigned a billing
# account so that spend isn't conflated into one big bucket.
data "google_billing_account" "free_trial" {
  display_name = "Free Trial"
  open         = true
}

output "billing_account_id" {
  value = data.google_billing_account.free_trial.id
}


################################################################################
# Folders
resource "google_folder" "se" {
  display_name = "Solutions Engineering"
  parent       = data.google_organization.org.name
}

resource "google_folder" "dev" {
  display_name = "Product Development"
  parent       = data.google_organization.org.name
}

resource "google_folder" "sandbox" {
  display_name = "GCloud Sandbox"
  parent       = data.google_organization.org.name
}


################################################################################
# Common infrastructure project
module "project_common_infra" {
  source             = "./modules/project"
  project_name       = "common-infra"
  project_id_prefix  = "common-infra"
  parent_id          = google_folder.sandbox.name
  billing_account_id = data.google_billing_account.free_trial.id
  readonly_users = [
    "user:vincetse@thelazyenginerd.github.io",
  ]
  readwrite_users = [
  ]
}

output "project_common_infra_id" {
  value = module.project_common_infra.project_id
}


################################################################################
# project
#
# Create a project by product, and assign it to the relevant Billing Account.
module "project1" {
  source             = "./modules/project"
  project_name       = "User Portal"
  project_id_prefix  = "user-portal"
  parent_id          = google_folder.sandbox.name
  billing_account_id = data.google_billing_account.free_trial.id
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
