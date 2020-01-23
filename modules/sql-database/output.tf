output "public_ip_address" {
  value = google_sql_database_instance.instance.public_ip_address
  description = "IP address of database instance"
}

output "private_ip_address" {
  value = google_sql_database_instance.instance.private_ip_address
  description = "IP address of database instance"
}
