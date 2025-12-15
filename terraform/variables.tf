variable "primary_region" {
  description = "Primary AWS region"
  type        = string
}

variable "secondary_region" {
  description = "Secondary AWS region"
  type        = string
}

variable "fis_role" {
  description = "IAM role ARN for FIS"
  type        = string
}
