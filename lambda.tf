module "endpoint_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 8.1"

  function_name = "${var.name}-endpoint"
  description   = "Endpoint Lambda function for ${var.name}"

  architectures         = local.architectures
  environment_variables = var.endpoint_lambda_environment_variables
  handler               = local.handler
  runtime               = local.runtime
  timeout               = var.endpoint_lambda_timeout
  tags                  = var.tags

  create_package         = false
  local_existing_package = "${path.module}/packages/endpoint.zip"

  # CloudWatch
  attach_cloudwatch_logs_policy      = true
  attach_create_log_group_permission = true
  cloudwatch_logs_log_group_class    = local.log_group_class
  cloudwatch_logs_retention_in_days  = var.cloudwatch_logs_retention_in_days
  cloudwatch_logs_tags               = var.tags
  logging_application_log_level      = var.cloudwatch_logs_application_log_level
  logging_log_format                 = local.logging_log_format
  logging_system_log_level           = var.lambda_system_log_level
  use_existing_cloudwatch_log_group  = false

  # IAM
  create_role = true
  role_name   = "${var.name}-endpoint-role"
  assume_role_policy_statements = {
    lambda_service = {
      effect  = "Allow",
      actions = ["sts:AssumeRole"],
      principals = {
        service_principal = {
          type        = "Service",
          identifiers = ["lambda.amazonaws.com"]
        }
      }
    }
  }
  attach_policy_statements = true
  policy_statements = {
    lambda = {
      effect    = "Allow"
      actions   = ["lambda:InvokeFunction"]
      resources = [module.task_lambda.lambda_function_arn]
    }
  }

  # Trigger
  allowed_triggers = {
    APIGatewayAny = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.api_execution_arn}/*/*"
    }
  }
}

module "task_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 8.1"

  function_name = "${var.name}-task"
  description   = "Task Lambda function for ${var.name}"

  architectures         = local.architectures
  environment_variables = var.task_lambda_environment_variables
  handler               = local.handler
  runtime               = local.runtime
  timeout               = var.task_lambda_timeout
  tags                  = var.tags

  create_package         = false
  local_existing_package = "${path.module}/packages/task.zip"

  # CloudWatch
  attach_cloudwatch_logs_policy      = true
  attach_create_log_group_permission = true
  cloudwatch_logs_log_group_class    = local.log_group_class
  cloudwatch_logs_retention_in_days  = var.cloudwatch_logs_retention_in_days
  cloudwatch_logs_tags               = var.tags
  logging_application_log_level      = var.cloudwatch_logs_application_log_level
  logging_log_format                 = local.logging_log_format
  logging_system_log_level           = var.lambda_system_log_level
  use_existing_cloudwatch_log_group  = false

  # IAM
  create_role = true
  role_name   = "${var.name}-task-role"
  assume_role_policy_statements = {
    lambda_service = {
      effect  = "Allow",
      actions = ["sts:AssumeRole"],
      principals = {
        service_principal = {
          type        = "Service",
          identifiers = ["lambda.amazonaws.com"]
        }
      }
    }
  }
  # attach_policy_statements = true
  # policy_statements = {}
}
