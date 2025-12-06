# chattingway-terraform

Terraform module to quickly spin up my chat bots.

To use this module, use the following as the source: `github.com/kn-lim/chattingway-terraform`

Make sure to build the binaries, name it `bootstrap` and compress them into .zip files in order for Terraform to create the resources. This will need to be done only when first applying the module.

<!-- BEGIN_TF_DOCS -->
## Examples

### slackingway-bot

```hcl
terraform {
  required_version = ">= 1.10"
}

locals {
  name                     = "slackingway-bot"
  account_id               = ""
  debug                    = "false"
  slack_signing_secret     = ""
  slack_oauth_token        = ""
  slack_history_channel_id = ""
  slack_output_channel_id  = ""
  admin_role_users         = ""

  # These non-empty .zip files are needed only when creating resources.
  # Run the build commands and zip the binary files.
  # The .zip file an be deleted/moved afterwards.
  endpoint_filename = "/path/to/endpoint.zip"
  task_filename     = "/path/to/task.zip"
}

module "slackingway-bot" {
  # https://github.com/kn-lim/chattingway-terraform
  source = "github.com/kn-lim/chattingway-terraform?ref=v1.2.0"

  # Required

  account_id        = local.account_id
  endpoint_filename = local.endpoint_filename
  task_filename     = local.task_filename
  endpoint_environment_variables = {
    ADMIN_ROLE_USERS         = local.admin_role_users
    DEBUG                    = local.debug
    SLACK_HISTORY_CHANNEL_ID = local.slack_history_channel_id
    SLACK_OAUTH_TOKEN        = local.slack_oauth_token
    SLACK_OUTPUT_CHANNEL_ID  = local.slack_output_channel_id
    SLACK_SIGNING_SECRET     = local.slack_signing_secret
    TASK_FUNCTION_NAME       = "${local.name}-task"
  }
  task_environment_variables = {
    DEBUG                    = local.debug
    SLACK_HISTORY_CHANNEL_ID = local.slack_history_channel_id
    SLACK_OAUTH_TOKEN        = local.slack_oauth_token
    SLACK_OUTPUT_CHANNEL_ID  = local.slack_output_channel_id
    SLACK_SIGNING_SECRET     = local.slack_signing_secret
  }

  # Optional

  # name              = local.name
  log_format = "Text"
  # region            = "us-west-2"
  # retention_in_days = 3
  # runtime           = "provided.al2023"
  # endpoint_timeout  = 3
  # task_timeout      = 300
  # ec2_instance_arns = []
  # tags = {
  #   App = local.name
  # }
}

output "api_endpoint" {
  description = "The endpoint for the API Gateway"
  value       = module.slackingway-bot.api_endpoint
}
```

### dreamingway-bot

```hcl
terraform {
  required_version = ">= 1.10"
}

locals {
  name                       = "dreamingway-bot"
  account_id                 = ""
  debug                      = "false"
  discord_api_version        = "10"
  discord_bot_application_id = ""
  discord_bot_public_key     = ""
  discord_bot_token          = ""

  # These non-empty .zip files are needed only when creating resources.
  # Run the build commands and zip the binary files.
  # The .zip file an be deleted/moved afterwards.
  endpoint_filename = "/path/to/endpoint.zip"
  task_filename     = "/path/to/task.zip"
}

module "dreamingway-bot" {
  # https://github.com/kn-lim/chattingway-terraform
  source = "github.com/kn-lim/chattingway-terraform?ref=v1.2.0"

  # Required

  account_id        = local.account_id
  endpoint_filename = local.endpoint_filename
  task_filename     = local.task_filename
  endpoint_environment_variables = {
    ADMIN_ROLE_USERS           = local.admin_role_users
    DEBUG                      = local.debug
    DISCORD_BOT_APPLICATION_ID = local.discord_bot_application_id
    DISCORD_BOT_PUBLIC_KEY     = local.discord_bot_public_key
    DISCORD_BOT_TOKEN          = local.discord_bot_token
    TASK_FUNCTION_NAME         = "${local.name}-task"
  }
  task_environment_variables = {
    DEBUG               = local.debug
    DISCORD_API_VERSION = local.discord_api_version
    DISCORD_BOT_TOKEN   = local.discord_bot_token
  }

  # Optional

  # name              = local.name
  # log_format        = "JSON"
  # region            = "us-west-2"
  # retention_in_days = 3
  # runtime           = "provided.al2023"
  # endpoint_timeout  = 3
  # task_timeout      = 300
  # ec2_instance_arns = []
  # tags = {
  #   App = local.name
  # }
}

output "api_endpoint" {
  description = "The endpoint for the API Gateway"
  value       = module.dreamingway-bot.api_endpoint
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | terraform-aws-modules/apigateway-v2/aws | ~> 6.0 |
| <a name="module_endpoint_lambda"></a> [endpoint\_lambda](#module\_endpoint\_lambda) | terraform-aws-modules/lambda/aws | ~> 8.1 |
| <a name="module_task_lambda"></a> [task\_lambda](#module\_task\_lambda) | terraform-aws-modules/lambda/aws | ~> 8.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_logs_application_log_level"></a> [cloudwatch\_logs\_application\_log\_level](#input\_cloudwatch\_logs\_application\_log\_level) | The application log level of the Lambda Function. Valid values are TRACE, DEBUG, INFO, WARN, ERROR, or FATAL. | `string` | `"INFO"` | no |
| <a name="input_cloudwatch_logs_retention_in_days"></a> [cloudwatch\_logs\_retention\_in\_days](#input\_cloudwatch\_logs\_retention\_in\_days) | The number of days to retain logs in CloudWatch. Valid values are 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. | `number` | `3` | no |
| <a name="input_endpoint_lambda_environment_variables"></a> [endpoint\_lambda\_environment\_variables](#input\_endpoint\_lambda\_environment\_variables) | A map of environment variables to apply to the Endpoint Lambda function. | `map(string)` | n/a | yes |
| <a name="input_endpoint_lambda_timeout"></a> [endpoint\_lambda\_timeout](#input\_endpoint\_lambda\_timeout) | The timeout for the Endpoint Lambda function in seconds. | `number` | `3` | no |
| <a name="input_lambda_system_log_level"></a> [lambda\_system\_log\_level](#input\_lambda\_system\_log\_level) | The system log level of the Lambda Function. Valid values are DEBUG, INFO, or WARN. | `string` | `"INFO"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the resources. | `string` | `"chattingway"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | <pre>{<br/>  "App": "chattingway"<br/>}</pre> | no |
| <a name="input_task_lambda_environment_variables"></a> [task\_lambda\_environment\_variables](#input\_task\_lambda\_environment\_variables) | A map of environment variables to apply to the Task Lambda function. | `map(string)` | n/a | yes |
| <a name="input_task_lambda_timeout"></a> [task\_lambda\_timeout](#input\_task\_lambda\_timeout) | The timeout for the Task Lambda function in seconds. | `number` | `300` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_endpoint"></a> [api\_endpoint](#output\_api\_endpoint) | The endpoint for the API Gateway |
| <a name="output_endpoint_function_arn"></a> [endpoint\_function\_arn](#output\_endpoint\_function\_arn) | The ARN of the Endpoint Lambda function |
| <a name="output_task_function_arn"></a> [task\_function\_arn](#output\_task\_function\_arn) | The ARN of the Task Lambda function |
<!-- END_TF_DOCS -->
