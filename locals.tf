locals {
  # Lambda
  architectures = ["x86_64"]
  handler       = "bootstrap"
  runtime       = "provided.al2023"

  # CloudWatch
  log_group_class    = "STANDARD"
  logging_log_format = "JSON"
}
