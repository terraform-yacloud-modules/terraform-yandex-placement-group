data "yandex_client_config" "client" {}

module "placement_group" {
  source = "../"

  placement_group_name = "prod-placement-group"
  folder_id            = data.yandex_client_config.client.folder_id

  # Опциональные параметры
  description = "Группа размещения для высокодоступных сервисов"
  labels = {
    environment = "production"
    project     = "my-awesome-project"
    department  = "infrastructure"
  }
}
