output "id" {
  description = "The unique identifier of the created placement group in Yandex Cloud."
  value       = yandex_compute_placement_group.placement_group.id
}

output "name" {
  description = "The name of the created placement group as specified in the configuration."
  value       = yandex_compute_placement_group.placement_group.name
}

output "description" {
  description = "The description of the placement group, if provided during creation."
  value       = yandex_compute_placement_group.placement_group.description
}

output "folder_id" {
  description = "The ID of the Yandex Cloud folder where the placement group is located."
  value       = yandex_compute_placement_group.placement_group.folder_id
}

output "labels" {
  description = "A map of labels (key-value pairs) applied to the placement group for organization and management purposes."
  value       = yandex_compute_placement_group.placement_group.labels
}

output "created_at" {
  description = "The timestamp when the placement group was created in Yandex Cloud."
  value       = yandex_compute_placement_group.placement_group.created_at
}

output "placement_strategy_spread" {
  description = "The spread placement strategy value of the placement group: true when virtual machines are spread across different hardware, otherwise null."
  value       = yandex_compute_placement_group.placement_group.placement_strategy_spread
}

output "placement_strategy_partitions" {
  description = "The number of partitions in the partition placement strategy of the placement group, or null when the spread strategy is used."
  value       = yandex_compute_placement_group.placement_group.placement_strategy_partitions
}

output "iam_binding_ids" {
  description = "A map of additional IAM binding names to the identifiers of the created placement group IAM bindings."
  value       = { for name, binding in yandex_compute_placement_group_iam_binding.additional : name => binding.id }
}
