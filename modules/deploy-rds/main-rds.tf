resource "aws_db_instance" "teraform-obligatorio-soluciones-cloud-db" {
  db_name = var.rds_db_name
  allocated_storage    = var.rds_allocated_storage
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instace_class
  username             = var.rds_username
  password = var.rds_password
  parameter_group_name = var.rds_parameter_group_name
  skip_final_snapshot  = true
  vpc_security_group_ids = [var.terraform_rds_sg_id]
  backup_retention_period = 7
  final_snapshot_identifier = "db-snap"
  db_subnet_group_name = var.terraform-subnet-group-db

  depends_on = [var.subnet1_id, var.subnet2_id]
}




