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
  
  timeouts = {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

}
