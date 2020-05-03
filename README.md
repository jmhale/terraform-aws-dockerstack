# terraform-aws-streamstack

Deploys resources for streaming stack

## Variables
| Variable Name | Type | Required |Description |
|---------------|-------------|-------------|-------------|
|`public_subnet_ids`|`list`|Yes|A list of subnets for the Autoscaling Group to use for launching instances. May be a single subnet, but it must be an element in a list.|
|`ssh_key_id`|`string`|Yes|A SSH public key ID to add to the VPN instance.|
|`vpc_id`|`string`|Yes|The VPC ID in which Terraform will launch the resources.|
|`ingress_security_group_id`|`string`|Yes|The ID of the Security Group to allow SSH access from.|
|`ami_id`|`string`|No. Defaults to Ubuntu 18.04 AMI in us-east-1|The AMI ID to use.|
|`env`|`string`|No. Defaults to `prod`|The name of environment. Used to differentiate multiple deployments|
|`project_name`|`string`|No. Defaults to `stream-stack`|The name of the project.|

## Usage

```
module "terraform-aws-streamstack" {
  source                    = "git@github.com:jmhale/terraform-aws-streamstack.git"
  ssh_key_id                = "my-ssh-key"
  vpc_id                    = "vpc-12345678"
  public_subnet_ids         = ["subnet-123456"]
  ingress_security_group_id = "sg-0123456789abcdef"
}

```
## Outputs
| Output Name | Description |
|---------------|-------------|
|`streamstack_eip`|The public IPv4 address of the AWS Elastic IP assigned to the instance.|


---
Copyright © 2020, James Hale
