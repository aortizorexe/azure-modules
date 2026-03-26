locals {
  final_tags = merge(var.tags_mandatory, var.tags_additional)
}