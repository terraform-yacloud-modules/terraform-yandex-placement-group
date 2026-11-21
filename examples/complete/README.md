# Complete example

Creates a compute placement group with the partition placement strategy and a disk placement group,
plus additional IAM bindings for both.

## Usage

```bash
export YC_FOLDER_ID='folder_id'
terraform init
terraform plan
terraform apply
```

This example demonstrates all module features:

- compute placement group with description, labels, explicit folder and timeouts;
- partition placement strategy (`placement_strategy_partitions`);
- additional IAM bindings for several roles (`iam_bindings`);
- disk placement group for non-replicated disks (`create_disk_placement_group`) in `ru-central1-a`
  with description, labels, timeouts and its own IAM bindings;
- module outputs for the placement strategies, disk placement group and IAM binding identifiers.

Note that this example creates service accounts. Run `terraform destroy` when you don't need these resources.
