locals {
  folder_id = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)

  disk_placement_group_name = coalesce(
    var.disk_placement_group_name,
    "${substr(var.placement_group_name, 0, 58)}-disk",
  )
}
