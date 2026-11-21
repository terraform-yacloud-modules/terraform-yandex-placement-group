# Placement group — группа размещения ВМ для управления отказоустойчивостью.
# Документация: https://yandex.cloud/ru/docs/terraform/resources/compute_placement_group

data "yandex_client_config" "client" {}

provider "yandex" {
}

resource "yandex_iam_service_account" "viewer" {
  name = "complete-placement-group-viewer"
}

resource "yandex_iam_service_account" "editor" {
  name = "complete-placement-group-editor"
}

resource "yandex_iam_service_account" "disk_viewer" {
  name = "complete-disk-placement-group-viewer"
}

module "placement_group" {
  source = "../../"

  folder_id            = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)
  placement_group_name = "complete-placement-group"

  description = "Группа размещения для высокодоступных сервисов"
  labels = {
    environment = "test"
    project     = "my-awesome-project"
    department  = "infrastructure"
    example     = "complete"
  }

  # Стратегия partitions — ВМ распределяются по 3 партициям (2–5).
  # Альтернатива: placement_strategy_spread = true
  placement_strategy_partitions = 3

  timeouts = {
    create = "10m"
    delete = "5m"
    update = "5m"
  }

  # Дополнительные IAM-привязки: одной группе можно выдать несколько ролей
  iam_bindings = {
    viewer = {
      role    = "compute.viewer"
      members = ["serviceAccount:${yandex_iam_service_account.viewer.id}"]
    }
    editor = {
      role    = "compute.editor"
      members = ["serviceAccount:${yandex_iam_service_account.editor.id}"]
    }
  }

  # Группа размещения дисков (disk placement group) для нереплицируемых дисков.
  # Это отдельный тип группы размещения, он создаётся вместе с группой размещения ВМ.
  create_disk_placement_group      = true
  disk_placement_group_name        = "complete-disk-placement-group"
  disk_placement_group_zone        = "ru-central1-a"
  disk_placement_group_description = "Группа размещения дисков для нереплицируемых дисков"
  disk_placement_group_labels = {
    environment = "test"
    project     = "my-awesome-project"
    department  = "infrastructure"
    example     = "complete"
  }

  disk_placement_group_timeouts = {
    create = "10m"
    delete = "5m"
    read   = "5m"
    update = "5m"
  }

  disk_placement_group_iam_bindings = {
    viewer = {
      role    = "compute.viewer"
      members = ["serviceAccount:${yandex_iam_service_account.disk_viewer.id}"]
    }
  }
}
