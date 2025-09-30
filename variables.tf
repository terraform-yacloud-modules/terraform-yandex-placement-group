# variables.tf
variable "placement_group_name" {
  description = "The name of the placement group. Must be unique within the folder and helps identify the group in the Yandex Cloud console."
  type        = string
}

variable "folder_id" {
  description = "The ID of the Yandex Cloud folder where the placement group will be created."
  type        = string
}

variable "description" {
  description = "An optional description of the placement group. Helps document the purpose and usage of the group."
  type        = string
  default     = "Placement group created via Terraform"
}

variable "labels" {
  description = "A set of key-value pairs (labels) to apply to the placement group. Useful for organizing, filtering, and managing resources."
  type        = map(string)
  default     = {}
}
