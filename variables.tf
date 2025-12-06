######################
# Required Variables #
######################
variable "endpoint_lambda_environment_variables" {
  description = "A map of environment variables to apply to the Endpoint Lambda function."
  type        = map(string)
  sensitive   = true
}

variable "task_lambda_environment_variables" {
  description = "A map of environment variables to apply to the Task Lambda function."
  type        = map(string)
  sensitive   = true
}

######################
# Optional Variables #
######################
variable "cloudwatch_logs_application_log_level" {
  description = "The application log level of the Lambda Function. Valid values are TRACE, DEBUG, INFO, WARN, ERROR, or FATAL."
  type        = string
  default     = "INFO"
  validation {
    condition     = contains(["TRACE", "DEBUG", "INFO", "WARN", "ERROR", "FATAL"], var.cloudwatch_logs_application_log_level)
    error_message = "Valid values are TRACE, DEBUG, INFO, WARN, ERROR, or FATAL."
  }
}

variable "cloudwatch_logs_retention_in_days" {
  description = "The number of days to retain logs in CloudWatch. Valid values are 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653."
  type        = number
  default     = 3
  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653], var.cloudwatch_logs_retention_in_days)
    error_message = "Valid values are 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653."
  }
}

variable "endpoint_lambda_timeout" {
  description = "The timeout for the Endpoint Lambda function in seconds."
  type        = number
  default     = 3
}

variable "lambda_system_log_level" {
  description = "The system log level of the Lambda Function. Valid values are DEBUG, INFO, or WARN."
  type        = string
  default     = "INFO"
  validation {
    condition     = contains(["DEBUG", "INFO", "WARN"], var.lambda_system_log_level)
    error_message = "Valid values are DEBUG, INFO, or WARN."
  }
}

variable "name" {
  description = "The name of the resources."
  type        = string
  default     = "chattingway"
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default = {
    App = "chattingway"
  }
}

variable "task_lambda_timeout" {
  description = "The timeout for the Task Lambda function in seconds."
  type        = number
  default     = 300
}
