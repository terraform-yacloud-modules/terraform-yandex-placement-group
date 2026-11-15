# Placement group — группа размещения ВМ для управления отказоустойчивостью.
# Документация: https://yandex.cloud/ru/docs/terraform/resources/compute_placement_group

data "yandex_client_config" "client" {}

provider "yandex" {
}

module "placement_group" {
  source = "../../"

  folder_id            = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)
  placement_group_name = "minimal-placement-group"

  # Стратегия spread — ВМ размещаются на разных стойках (рекомендуется для отказоустойчивости)
  placement_strategy_spread = true
}
