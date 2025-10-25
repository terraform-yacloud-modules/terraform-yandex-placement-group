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

  # Стратегия размещения - раскидывать по разным хостам
  placement_strategy_spread = true

  # Альтернативно: стратегия разделения на партиции
  # placement_strategy_partitions = 3

  # Таймауты операций
  timeouts = {
    create = "10m"
    delete = "5m"
    update = "5m"
  }

}
