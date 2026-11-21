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

resource "yandex_compute_disk_placement_group" "disk" {
  count = var.create_disk_placement_group ? 1 : 0

  name        = local.disk_placement_group_name
  folder_id   = local.folder_id
  description = var.disk_placement_group_description
  labels      = var.disk_placement_group_labels
  zone        = var.disk_placement_group_zone

  dynamic "timeouts" {
    for_each = var.disk_placement_group_timeouts != null ? [1] : []
    content {
      create = try(var.disk_placement_group_timeouts.create, null)
      delete = try(var.disk_placement_group_timeouts.delete, null)
      read   = try(var.disk_placement_group_timeouts.read, null)
      update = try(var.disk_placement_group_timeouts.update, null)
    }
  }
}

resource "yandex_compute_disk_placement_group_iam_binding" "disk" {
  for_each = var.create_disk_placement_group ? var.disk_placement_group_iam_bindings : {}

  disk_placement_group_id = yandex_compute_disk_placement_group.disk[0].id
  role                    = each.value.role
  members                 = each.value.members
}
