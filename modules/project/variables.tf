variable "project_name" {
  type = string
  description = "Name of the project, which is then used as a prefix"
}

variable "project_id_prefix" {
  type = string
  description = "Project ID prefix, which is then used as a prefix"
}

variable "parent_id" {
  type = string
  description = "Parent organization or folder ID"
}

variable "readwrite_users" {
  type = list(string)
  description = "Users who have read/write access"
  default = []
}

variable "readonly_users" {
  type = list(string)
  description = "Users who have read-only access"
  default = []
}
