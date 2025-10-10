module "placement_group" {
  source = "../"

  placement_group_name = "prod-placement-group"

  # Опциональные параметры
  description = "Группа размещения для высокодоступных сервисов"
  labels = {
    environment = "production"
    project     = "my-awesome-project"
    department  = "infrastructure"
  }
}
