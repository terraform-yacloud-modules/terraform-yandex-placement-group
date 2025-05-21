data "yandex_client_config" "client" {}

resource "yandex_compute_placement_group" "placement_group" {
  name        = var.placement_group_name
  folder_id   = data.yandex_client_config.client.folder_id
  description = var.description
  labels      = var.labels
}
