# Yandex Cloud <RESOURCE> Terraform module

Terraform module which creates Yandex Cloud <RESOURCE> resources.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_compute_placement_group.placement_group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_placement_group) | resource |
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | An optional description of the placement group. Helps document the purpose and usage of the group. | `string` | `"Placement group created via Terraform"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The ID of the Yandex Cloud folder where the placement group will be created. | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key-value pairs (labels) to apply to the placement group. Useful for organizing, filtering, and managing resources. | `map(string)` | `{}` | no |
| <a name="input_placement_group_name"></a> [placement\_group\_name](#input\_placement\_group\_name) | The name of the placement group. Must be unique within the folder and helps identify the group in the Yandex Cloud console. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The timestamp when the placement group was created in Yandex Cloud. |
| <a name="output_description"></a> [description](#output\_description) | The description of the placement group, if provided during creation. |
| <a name="output_folder_id"></a> [folder\_id](#output\_folder\_id) | The ID of the Yandex Cloud folder where the placement group is located. |
| <a name="output_id"></a> [id](#output\_id) | The unique identifier of the created placement group in Yandex Cloud. |
| <a name="output_labels"></a> [labels](#output\_labels) | A map of labels (key-value pairs) applied to the placement group for organization and management purposes. |
| <a name="output_name"></a> [name](#output\_name) | The name of the created placement group as specified in the configuration. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
