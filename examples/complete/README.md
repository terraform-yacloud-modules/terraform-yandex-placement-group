# Complete example

Creates a placement group with the partition placement strategy plus additional IAM bindings.

## Usage

```bash
export YC_FOLDER_ID='folder_id'
terraform init
terraform plan
terraform apply
```

This example demonstrates all module features:

- placement group with description, labels, explicit folder and timeouts;
- partition placement strategy (`placement_strategy_partitions`);
- additional IAM bindings for several roles (`iam_bindings`);
- module outputs for the placement strategy and IAM binding identifiers.

Note that this example creates service accounts. Run `terraform destroy` when you don't need these resources.
