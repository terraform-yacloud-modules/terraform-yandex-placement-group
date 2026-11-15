output "id" {
  description = "The unique identifier of the created placement group in Yandex Cloud."
  value       = module.placement_group.id
}

output "name" {
  description = "The name of the created placement group as specified in the configuration."
  value       = module.placement_group.name
}

output "description" {
  description = "The description of the placement group, if provided during creation."
  value       = module.placement_group.description
}

output "folder_id" {
  description = "The ID of the Yandex Cloud folder where the placement group is located."
  value       = module.placement_group.folder_id
}

output "labels" {
  description = "A map of labels (key-value pairs) applied to the placement group for organization and management purposes."
  value       = module.placement_group.labels
}

output "placement_strategy_spread" {
  description = "The spread placement strategy value of the placement group."
  value       = module.placement_group.placement_strategy_spread
}

output "placement_strategy_partitions" {
  description = "The number of partitions in the partition placement strategy of the placement group."
  value       = module.placement_group.placement_strategy_partitions
}

output "created_at" {
  description = "The timestamp when the placement group was created in Yandex Cloud."
  value       = module.placement_group.created_at
}
