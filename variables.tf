# variables.tf
variable "placement_group_name" {
  description = "The name of the placement group. Must be unique within the folder and helps identify the group in the Yandex Cloud console."
  type        = string

  validation {
    condition     = var.placement_group_name != null && length(var.placement_group_name) > 0
    error_message = "Placement group name cannot be empty."
  }

  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]{0,61}[a-z0-9])?$", var.placement_group_name))
    error_message = "Placement group name must start with a letter, contain only lowercase letters, numbers, and hyphens, and be 1-63 characters long."
  }
}

variable "folder_id" {
  description = "(Optional) The ID of the Yandex Cloud Folder for the placement group. If omitted, the folder from the provider configuration is used."
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

variable "placement_strategy_spread" {
  description = "Spread placement strategy: VMs are placed on different hardware. Set to true or leave unset (conflicts with placement_strategy_partitions). Exactly one of placement_strategy_spread or placement_strategy_partitions must be set."
  type        = bool
  default     = null

  validation {
    condition     = var.placement_strategy_spread == null || var.placement_strategy_spread == true
    error_message = "Placement strategy spread must be either null or true."
  }
}

variable "placement_strategy_partitions" {
  description = "Number of partitions in the partition placement strategy for the placement group (2-5). Conflicts with placement_strategy_spread. Exactly one of placement_strategy_spread or placement_strategy_partitions must be set."
  type        = number
  default     = null

  validation {
    condition     = var.placement_strategy_partitions == null ? true : (var.placement_strategy_partitions >= 2 && var.placement_strategy_partitions <= 5)
    error_message = "Placement strategy partitions must be between 2 and 5, or null."
  }
}

variable "iam_bindings" {
  description = "Additional IAM bindings for the placement group as a map of binding name to role and members. Each binding grants one role to a list of members (users, groups or service accounts)."
  type = map(object({
    role    = string
    members = list(string)
  }))
  default = {}

  validation {
    condition = alltrue([
      for binding in values(var.iam_bindings) :
      can(regex("^[a-z][a-z0-9]*(\\.[a-z][a-zA-Z0-9]*)+$", binding.role))
    ])
    error_message = "IAM binding role must be a valid Yandex Cloud role identifier, for example `compute.viewer`."
  }

  validation {
    condition = alltrue([
      for binding in values(var.iam_bindings) :
      length(binding.members) > 0 && alltrue([
        for member in binding.members :
        can(regex("^(system:allUsers|system:allAuthenticatedUsers|system:group:|userAccount:|serviceAccount:|federatedUser:|group:)", member))
      ])
    ])
    error_message = "IAM binding members must be a non-empty list in valid format: system:allUsers, system:allAuthenticatedUsers, userAccount:{user_id}, serviceAccount:{service_account_id}, federatedUser:{federated_user_id} or group:{group_id}."
  }
}

variable "timeouts" {
  description = "Timeout configuration for placement group operations"
  type = object({
    create = optional(string)
    delete = optional(string)
    update = optional(string)
  })
  default = null

  validation {
    condition = var.timeouts == null ? true : alltrue([
      for k, v in var.timeouts : v == null || can(regex("^\\d+[smh]$", v))
    ])
    error_message = "Timeout values must be in format like '10m', '30s', '1h' or be null."
  }
}

variable "create_disk_placement_group" {
  description = "Whether to create a disk placement group in addition to the compute placement group. Disk placement groups are used by non-replicated disks."
  type        = bool
  default     = false
}

variable "disk_placement_group_name" {
  description = "The name of the disk placement group. If omitted, it is derived from placement_group_name with the `-disk` suffix. Must be unique within the folder."
  type        = string
  default     = null

  validation {
    condition     = var.disk_placement_group_name == null ? true : can(regex("^[a-z]([-a-z0-9]{0,61}[a-z0-9])?$", var.disk_placement_group_name))
    error_message = "Disk placement group name must start with a letter, contain only lowercase letters, numbers, and hyphens, and be 1-63 characters long."
  }
}

variable "disk_placement_group_zone" {
  description = "The availability zone of the disk placement group, for example `ru-central1-a`. Required when create_disk_placement_group is true."
  type        = string
  default     = null

  validation {
    condition     = var.disk_placement_group_zone == null ? !var.create_disk_placement_group : can(regex("^[a-z][a-z0-9-]*[a-z0-9]$", var.disk_placement_group_zone))
    error_message = "Disk placement group zone must be set when create_disk_placement_group is true and must be a valid Yandex Cloud availability zone, for example `ru-central1-a`."
  }
}

variable "disk_placement_group_description" {
  description = "An optional description of the disk placement group."
  type        = string
  default     = "Disk placement group created via Terraform"
}

variable "disk_placement_group_labels" {
  description = "A set of key-value pairs (labels) to apply to the disk placement group."
  type        = map(string)
  default     = {}
}

variable "disk_placement_group_iam_bindings" {
  description = "Additional IAM bindings for the disk placement group as a map of binding name to role and members. Each binding grants one role to a list of members (users, groups or service accounts). Ignored when create_disk_placement_group is false."
  type = map(object({
    role    = string
    members = list(string)
  }))
  default = {}

  validation {
    condition = alltrue([
      for binding in values(var.disk_placement_group_iam_bindings) :
      can(regex("^[a-z][a-z0-9]*(\\.[a-z][a-zA-Z0-9]*)+$", binding.role))
    ])
    error_message = "Disk placement group IAM binding role must be a valid Yandex Cloud role identifier, for example `compute.viewer`."
  }

  validation {
    condition = alltrue([
      for binding in values(var.disk_placement_group_iam_bindings) :
      length(binding.members) > 0 && alltrue([
        for member in binding.members :
        can(regex("^(system:allUsers|system:allAuthenticatedUsers|system:group:|userAccount:|serviceAccount:|federatedUser:|group:)", member))
      ])
    ])
    error_message = "Disk placement group IAM binding members must be a non-empty list in valid format: system:allUsers, system:allAuthenticatedUsers, userAccount:{user_id}, serviceAccount:{service_account_id}, federatedUser:{federated_user_id} or group:{group_id}."
  }
}

variable "disk_placement_group_timeouts" {
  description = "Timeout configuration for disk placement group operations. Supports create, delete, read and update timeouts."
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default = null

  validation {
    condition = var.disk_placement_group_timeouts == null ? true : alltrue([
      for k, v in var.disk_placement_group_timeouts : v == null || can(regex("^\\d+[smh]$", v))
    ])
    error_message = "Disk placement group timeout values must be in format like '10m', '30s', '1h' or be null."
  }
}
