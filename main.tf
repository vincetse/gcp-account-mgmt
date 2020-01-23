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
# project
#
# Create a project by product, and assign it to the relevant Billing Account.
module "project1" {
  source             = "./modules/project"
  project_name       = "My GAE"
  project_id_prefix  = "my-gae"
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

################################################################################
# webapp with postgresql
module "db1" {
  source = "./modules/sql-database"
  database_name = "db1"
  database_version = "MYSQL_5_7"
  region = "us-central1"
  project_id = module.project1.project_id
  tier = "db-f1-micro"
  readwrite_users = [
    "vincetse",
  ]
}

output "db1_public_ip_address" {
  value = module.db1.public_ip_address
}

output "db1_private_ip_address" {
  value = module.db1.private_ip_address
}
