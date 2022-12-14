module "postgresql_rds" {
  source = "../../modules/rds"
  vpc_id = "data.terraform_remote_state.vpc.outputs.vpc_id"
  allocated_storage = "32"
  engine_version = "9.4.4"
  instance_type = "db.t2.micro"
  storage_type = "gp2"
  database_identifier = "jl23kj32sdf"
  database_name = "hector"
  database_username = "hector"
  database_password = "secret"
  database_port = "5432"
  backup_retention_period = "30"
  backup_window = "04:00-04:30"
  maintenance_window = "sun:04:30-sun:05:30"
  auto_minor_version_upgrade = false
  multi_availability_zone = true
  storage_encrypted = false
  subnet_group = aws_db_subnet_group.default.name
  parameter_group = aws_db_parameter_group.default.name
  monitoring_interval = "60"
  deletion_protection = true
  cloudwatch_logs_exports = ["postgresql"]

  alarm_cpu_threshold = "75"
  alarm_disk_queue_threshold = "10"
  alarm_free_disk_threshold = "5000000000"
  alarm_free_memory_threshold = "128000000"
  alarm_actions = ["arn:aws:sns..."]
  ok_actions = ["arn:aws:sns..."]
  insufficient_data_actions = ["arn:aws:sns..."]

  project = "Something"
  environment = "Staging"
}
