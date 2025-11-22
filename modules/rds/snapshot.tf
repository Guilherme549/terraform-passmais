# data "aws_db_snapshot" "latest" {
#   db_instance_identifier = var.db_instance_identifier_for_snapshot
#   most_recent            = true
#   snapshot_type          = "manual"
#   region                 = "us-east-1"
# }
