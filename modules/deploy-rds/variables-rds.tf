variable "rds_username" {
  type = string
}
variable "rds_password" {
  description = "The base64 encoded password for RDS"
  type        = string
}
variable "rds_db_name" {
  description = "Variable para recibir el valor de invocador tfvars"
  type = string
  
}

variable "rds_parameter_group_name" {
  type = string
}
variable "rds_instace_class" {
  type = string
}
variable "rds_engine_version" {
  type = string
}
variable "rds_engine" {
  type = string
}
variable "rds_allocated_storage" {
  type = number
}

variable "terraform_rds_sg_id" {
  description = "ID del Security Group del RDS"
  type        = string
}

variable "subnet1_id" {
  description = "ID de la primera Subnet privada"
  type        = string
}
variable "subnet2_id" {
  description = "ID de la segunda Subnet privada"
  type        = string
}
variable "terraform-subnet-group-db" {
  description = "ID del grupo de Subnets"
  type        = string
}

