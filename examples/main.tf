# Placement group — группа размещения ВМ для управления отказоустойчивостью.
# Документация: https://yandex.cloud/ru/docs/terraform/resources/compute_placement_group

module "placement_group" {
  source = "../"

  placement_group_name = "prod-placement-group"

  description = "Группа размещения для высокодоступных сервисов"
  labels = {
    environment = "production"
    project     = "my-awesome-project"
    department  = "infrastructure"
  }

  # Стратегия spread — ВМ размещаются на разных стойках (рекомендуется для отказоустойчивости)
  placement_strategy_spread = true

  # Альтернатива: стратегия partitions (2–5 партиций)
  # placement_strategy_partitions = 3

  timeouts = {
    create = "10m"
    delete = "5m"
    update = "5m"
  }
}
