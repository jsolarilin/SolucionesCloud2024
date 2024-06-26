
#Variable de output RDS
output "rds_endpoint" {
  value = aws_db_instance.teraform-obligatorio-soluciones-cloud-db.address

}
output "rds_db_name" {
  value = var.rds_db_name
  
}

output "rds_username" {
  value = var.rds_username
}

output "rds_password" {
  value = var.rds_password
}

output "rds_db_database" {
  value = "obligatorio_db"
}

