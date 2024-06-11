# Terraform-aws

Terraform is IaC to build Infrastructure as Code. This project build Demo AWS Landing Zone with terraform by 3 region.

# Install setup Before Start

- Install Terraform

  [Terraform](https://www.terraform.io/) for run command. Create Infrastructure.

- Install AWS CLI & Config credentials

  [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) for run command. To remote build aws resource.

# After clone repo

    ```bash
    terraform init
    ```

- 3 Step for Build and Clean Up

  ```bash
  terraform plan
  ```

  ```bash
  terraform appply
  ```

  ```bash
  terraform destroy
  ```
