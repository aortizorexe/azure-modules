variable "tags_mandatory" {
  description = "Mandatory tags dictated by standard cloud governance and FinOps policies."
  type = object({
    Environment = string
    Project     = string
    Owner       = string
    ManagedBy   = string
    CostCenter  = string
  })
}

variable "tags_additional" {
  description = "Additional optional tags for specific resources."
  type        = map(string)
  default     = {}
}