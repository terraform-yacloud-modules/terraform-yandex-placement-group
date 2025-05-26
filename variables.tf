# variables.tf
variable "placement_group_name" {
  description = "Название группы размещения"
  type        = string
}

variable "description" {
  description = "Описание группы размещения"
  type        = string
  default     = "Группа размещения, созданная через Terraform"
}

variable "labels" {
  description = "Метки для группы размещения"
  type        = map(string)
  default     = {}
}
