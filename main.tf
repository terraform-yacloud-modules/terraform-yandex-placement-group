data "yandex_client_config" "client" {}

resource "yandex_compute_placement_group" "placement_group" {
  name        = var.placement_group_name
  folder_id   = local.folder_id
  description = var.description
  labels      = var.labels

  placement_strategy_spread     = var.placement_strategy_spread
  placement_strategy_partitions = var.placement_strategy_partitions

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [1] : []
    content {
      create = try(var.timeouts.create, null)
      delete = try(var.timeouts.delete, null)
      update = try(var.timeouts.update, null)
    }
  }
}

resource "yandex_compute_placement_group_iam_binding" "additional" {
  for_each = var.iam_bindings

  placement_group_id = yandex_compute_placement_group.placement_group.id
  role               = each.value.role
  members            = each.value.members
}
