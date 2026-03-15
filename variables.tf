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

variable "timeouts" {
  description = "Timeout configuration for placement group operations"
  type = object({
    create = optional(string)
    delete = optional(string)
    update = optional(string)
  })
  default = null

  validation {
    condition = var.timeouts == null || alltrue([
      for k, v in var.timeouts : v == null || can(regex("^\\d+[smh]$", v))
    ])
    error_message = "Timeout values must be in format like '10m', '30s', '1h' or be null."
  }
}
