# variables.tf
variable "placement_group_name" {
  description = "The name of the placement group. Must be unique within the folder and helps identify the group in the Yandex Cloud console."
  type        = string
}

variable "folder_id" {
  description = <<EOF
    (Optional) The ID of the Yandex Cloud Folder that the resources belongs to.

    Allows to create bucket in different folder.
    It will try to create bucket using IAM-token in provider config, not using access_key.
    If omitted, folder_id specified in provider config and access_key is used.
  EOF
  type        = string
  default     = null
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

variable "timeouts" {
  description = "Timeout settings for cluster operations"
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}
