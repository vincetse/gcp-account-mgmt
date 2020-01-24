module "db1" {
  source = "../../modules/sql-database"
  database_name = "db1"
  database_version = "MYSQL_5_7"
  region = "us-central1"
  project_id = module.project1.project_id
  tier = "db-f1-micro"
  readwrite_users = [
    "vincetse",
  ]
}
