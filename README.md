# Yandex Cloud Placement Group Terraform module

Terraform module that creates [Yandex Compute placement groups](https://yandex.cloud/docs/compute/concepts/placement-groups)
for virtual machines and [disk placement groups](https://yandex.cloud/docs/compute/concepts/disk#disk-placement-group) for
non-replicated disks.
Terraform resources: [yandex_compute_placement_group](https://yandex.cloud/ru/docs/terraform/resources/compute_placement_group),
[yandex_compute_disk_placement_group](https://yandex.cloud/ru/docs/terraform/resources/compute_disk_placement_group).

## Описание

Модуль создаёт группы размещения Yandex Compute и управляет ими:

- **Группа размещения ВМ** (`yandex_compute_placement_group`) создаётся всегда. Поддерживаются обе стратегии
  размещения: `placement_strategy_spread` (ВМ на разном оборудовании) и `placement_strategy_partitions`
  (от 2 до 5 партиций). Дополнительно можно задать описание, метки (labels), таймауты и IAM-привязки.
- **Группа размещения дисков** (`yandex_compute_disk_placement_group`) создаётся, только если включён параметр
  `create_disk_placement_group = true`. Такие группы нужны для нереплицируемых дисков. Для группы размещения
  дисков обязательна зона доступности (`disk_placement_group_zone`); также поддерживаются описание, метки,
  таймауты и IAM-привязки.

Модуль возвращает идентификаторы, имена, зоны, статусы и идентификаторы IAM-привязок созданных групп, чтобы их
можно было передать в модули виртуальных машин и дисков.

### Пример использования

```hcl
module "placement_group" {
  source = "terraform-yacloud-modules/placement-group/yandex"

  placement_group_name          = "web"
  placement_strategy_partitions = 3

  create_disk_placement_group = true
  disk_placement_group_zone   = "ru-central1-a"

  iam_bindings = {
    viewer = {
      role    = "compute.viewer"
      members = ["serviceAccount:${yandex_iam_service_account.viewer.id}"]
    }
  }
}
```

Для IAM-привязок требуется провайдер `yandex-cloud/yandex` версии 0.123.0 или новее.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-placement-group/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.123.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.123.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [yandex_compute_disk_placement_group.disk](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_disk_placement_group) | resource |
| [yandex_compute_disk_placement_group_iam_binding.disk](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_disk_placement_group_iam_binding) | resource |
| [yandex_compute_placement_group.placement_group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_placement_group) | resource |
| [yandex_compute_placement_group_iam_binding.additional](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_placement_group_iam_binding) | resource |
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create_disk_placement_group"></a> [create\_disk\_placement\_group](#input\_create\_disk\_placement\_group) | Whether to create a disk placement group in addition to the compute placement group. Disk placement groups are used by non-replicated disks. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | An optional description of the placement group. Helps document the purpose and usage of the group. | `string` | `"Placement group created via Terraform"` | no |
| <a name="input_disk_placement_group_description"></a> [disk\_placement\_group\_description](#input\_disk\_placement\_group\_description) | An optional description of the disk placement group. | `string` | `"Disk placement group created via Terraform"` | no |
| <a name="input_disk_placement_group_iam_bindings"></a> [disk\_placement\_group\_iam\_bindings](#input\_disk\_placement\_group\_iam\_bindings) | Additional IAM bindings for the disk placement group as a map of binding name to role and members. Each binding grants one role to a list of members (users, groups or service accounts). Ignored when create\_disk\_placement\_group is false. | <pre>map(object({<br/>    role    = string<br/>    members = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_disk_placement_group_labels"></a> [disk\_placement\_group\_labels](#input\_disk\_placement\_group\_labels) | A set of key-value pairs (labels) to apply to the disk placement group. | `map(string)` | `{}` | no |
| <a name="input_disk_placement_group_name"></a> [disk\_placement\_group\_name](#input\_disk\_placement\_group\_name) | The name of the disk placement group. If omitted, it is derived from placement\_group\_name with the `-disk` suffix. Must be unique within the folder. | `string` | `null` | no |
| <a name="input_disk_placement_group_timeouts"></a> [disk\_placement\_group\_timeouts](#input\_disk\_placement\_group\_timeouts) | Timeout configuration for disk placement group operations. Supports create, delete, read and update timeouts. | <pre>object({<br/>    create = optional(string)<br/>    delete = optional(string)<br/>    read   = optional(string)<br/>    update = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_disk_placement_group_zone"></a> [disk\_placement\_group\_zone](#input\_disk\_placement\_group\_zone) | The availability zone of the disk placement group, for example `ru-central1-a`. Required when create\_disk\_placement\_group is true. | `string` | `null` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | (Optional) The ID of the Yandex Cloud Folder for the placement group. If omitted, the folder from the provider configuration is used. | `string` | `null` | no |
| <a name="input_iam_bindings"></a> [iam\_bindings](#input\_iam\_bindings) | Additional IAM bindings for the placement group as a map of binding name to role and members. Each binding grants one role to a list of members (users, groups or service accounts). | <pre>map(object({<br/>    role    = string<br/>    members = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key-value pairs (labels) to apply to the placement group. Useful for organizing, filtering, and managing resources. | `map(string)` | `{}` | no |
| <a name="input_placement_group_name"></a> [placement\_group\_name](#input\_placement\_group\_name) | The name of the placement group. Must be unique within the folder and helps identify the group in the Yandex Cloud console. | `string` | n/a | yes |
| <a name="input_placement_strategy_partitions"></a> [placement\_strategy\_partitions](#input\_placement\_strategy\_partitions) | Number of partitions in the partition placement strategy for the placement group (2-5). Conflicts with placement\_strategy\_spread. Exactly one of placement\_strategy\_spread or placement\_strategy\_partitions must be set. | `number` | `null` | no |
| <a name="input_placement_strategy_spread"></a> [placement\_strategy\_spread](#input\_placement\_strategy\_spread) | Spread placement strategy: VMs are placed on different hardware. Set to true or leave unset (conflicts with placement\_strategy\_partitions). Exactly one of placement\_strategy\_spread or placement\_strategy\_partitions must be set. | `bool` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeout configuration for placement group operations | <pre>object({<br/>    create = optional(string)<br/>    delete = optional(string)<br/>    update = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The timestamp when the placement group was created in Yandex Cloud. |
| <a name="output_description"></a> [description](#output\_description) | The description of the placement group, if provided during creation. |
| <a name="output_disk_placement_group_iam_binding_ids"></a> [disk\_placement\_group\_iam\_binding\_ids](#output\_disk\_placement\_group\_iam\_binding\_ids) | A map of additional disk placement group IAM binding names to the identifiers of the created IAM bindings. |
| <a name="output_disk_placement_group_id"></a> [disk\_placement\_group\_id](#output\_disk\_placement\_group\_id) | The unique identifier of the created disk placement group in Yandex Cloud, or null when create\_disk\_placement\_group is false. |
| <a name="output_disk_placement_group_name"></a> [disk\_placement\_group\_name](#output\_disk\_placement\_group\_name) | The name of the created disk placement group, or null when create\_disk\_placement\_group is false. |
| <a name="output_disk_placement_group_status"></a> [disk\_placement\_group\_status](#output\_disk\_placement\_group\_status) | The current status of the created disk placement group, or null when create\_disk\_placement\_group is false. |
| <a name="output_disk_placement_group_zone"></a> [disk\_placement\_group\_zone](#output\_disk\_placement\_group\_zone) | The availability zone of the created disk placement group, or null when create\_disk\_placement\_group is false. |
| <a name="output_folder_id"></a> [folder\_id](#output\_folder\_id) | The ID of the Yandex Cloud folder where the placement group is located. |
| <a name="output_iam_binding_ids"></a> [iam\_binding\_ids](#output\_iam\_binding\_ids) | A map of additional IAM binding names to the identifiers of the created placement group IAM bindings. |
| <a name="output_id"></a> [id](#output\_id) | The unique identifier of the created placement group in Yandex Cloud. |
| <a name="output_labels"></a> [labels](#output\_labels) | A map of labels (key-value pairs) applied to the placement group for organization and management purposes. |
| <a name="output_name"></a> [name](#output\_name) | The name of the created placement group as specified in the configuration. |
| <a name="output_placement_strategy_partitions"></a> [placement\_strategy\_partitions](#output\_placement\_strategy\_partitions) | The number of partitions in the partition placement strategy of the placement group, or null when the spread strategy is used. |
| <a name="output_placement_strategy_spread"></a> [placement\_strategy\_spread](#output\_placement\_strategy\_spread) | The spread placement strategy value of the placement group: true when virtual machines are spread across different hardware, otherwise null. |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-placement-group/blob/main/LICENSE).
