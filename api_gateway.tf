module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 6.0"

  name          = "${var.name}-http"
  description   = "HTTP API Gateway for ${var.name}"
  protocol_type = "HTTP"

  # Routes
  routes = {
    "ANY /" = {
      integration = {
        uri                    = module.endpoint_lambda.lambda_function_invoke_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = var.endpoint_lambda_timeout * 1000 # seconds
      }
    }
  }

  tags = var.tags
}
