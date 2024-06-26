output "subnet1_id" {
  value = module.deploy-network.subnet1_id
}
output "subnet2_id" {
  value = module.deploy-network.subnet2_id
}
output "eks_security_group_id" {
  value = module.deploy-network.eks_security_group_id
}
output "terraform_rds_sg_id" {
  value = module.deploy-network.terraform_rds_sg_id
}
output "terraform-subnet-group-db" {
  value = module.deploy-network.terraform-subnet-group-db
  
}

#Variable de output RDS
output "rds_endpoint" {
  value = module.deploy-rds.rds_endpoint
}

output "rds_username" {
  value = module.deploy-rds.rds_username
}
output "rds_password" {
  sensitive = true
  value = module.deploy-rds.rds_password
  
}
output "rds_db_name" {
  value = module.deploy-rds.rds_db_name
  
}
