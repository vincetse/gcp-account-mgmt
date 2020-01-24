variable "app_name" {
  type = string
  description = "Application name"
}

variable "project_id" {
  type = string
  description = "GCP project ID"
}

variable "region" {
  type = string
  description = "GCP region"
}

variable "database_version" {
  type = string
  description = "GCP database version"
  default = "MYSQL_5_7"
}

variable "database_tier" {
  type = string
  description = "Database tier"
  default = "db-f1-micro"
}
