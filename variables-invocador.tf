##Declaro variables para deployment-network
variable "perfil_input" {
  type = string
}

variable "vpc_cidr_input" {
  type = string
  
}

variable "region_input" {
  type = string
  
}

variable "subnet1_input" {
  type = string
  
}
variable "subnet2_input" {
  type = string
  
}

variable "vpc_aws_az_input" {
  type = string
  
}

variable "vpc_aws_az1_input" {
  type = string
}
variable "vpc_aws_az2_input" {
  type = string
}

##Declaro variables para deployment-eks
variable "cluster_name_input" {
  type = string
}

variable "cluster_version_input" {
  type = string
}

variable "node_group_name_input" {
  type = string
}

variable "node_instance_type_input" {
  type = string
}

variable "node_root_volume_size_input" {
  type = number
}

variable "node_desired_capacity_input" {
  type = number
}

variable "node_max_capacity_input" {
  type = number
}

variable "node_min_capacity_input" {
  type = number
}

variable "node_volume_size_input" {
  type = number
}

variable "eks_tags_input" {
  type = map(string)
}
variable "node_key_input" {
  type = string
}
#Declaro variables para deployment-rds
variable "rds_username_input" {
  type = string
}
variable "rds_password_input" {
  sensitive = true
  description = "Contraseña de la base de datos"
  type        = string
}
variable "rds_db_name_input" {
  description = "Le paso el nombre de la base de datos que creo dentro de RDS"
  type = string
  
}
variable "rds_parameter_group_name_input" {
  type = string
}
variable "rds_instace_class_input" {
  type = string
}
variable "rds_engine_version_input" {
  type = string
}
variable "rds_engine_input" {
  type = string
}
variable "rds_allocated_storage_input" {
  type = number
}


