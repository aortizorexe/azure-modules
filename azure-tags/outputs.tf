output "tags_mandatory" {
  description = "The final merged map of tags to apply to all deployed resources."
  value       = local.final_tags
}