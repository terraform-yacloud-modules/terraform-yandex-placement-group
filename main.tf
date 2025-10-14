data "yandex_client_config" "client" {}

resource "yandex_compute_placement_group" "placement_group" {
  name        = var.placement_group_name
  folder_id   = local.folder_id
  description = var.description
  labels      = var.labels

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = try(timeouts.value.create, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}
