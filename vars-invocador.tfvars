#Asigno valores a variables de Networking
perfil_input        = "default"
region_input         = "us-east-1"
vpc_cidr_input       = "10.31.0.0/16"
vpc_aws_az_input     = "us-east-1a"
subnet1_input = "10.31.32.0/20"
subnet2_input = "10.31.48.0/20"
vpc_aws_az1_input     = "us-east-1b"
vpc_aws_az2_input     = "us-east-1a"
#Asigno valores a variables de EKS
cluster_name_input            = "terraform-obligatorio-soluciones-cloud"
cluster_version_input         = "1.21"
node_group_name_input         = "terraform-obligatorio-soluciones-cloud"
node_instance_type_input      = "t3.medium"
node_root_volume_size_input   = 20
node_desired_capacity_input   = 2
node_max_capacity_input       = 3
node_min_capacity_input       = 1
node_volume_size_input        = 20
eks_tags_input = {
  Environment = "test"
}
node_key_input = "vockey"

#Asigno valores a variables de RDS
rds_username_input = "admin"
#La contraseña debe ir como un secret dentro del ecommerce-db-secret.yaml
#rds_password_input  = "UGFzc3dvcmQwMS4="
rds_db_name_input = "obligatorio_db"
rds_parameter_group_name_input  = "default.mysql5.7"
rds_instace_class_input  = "db.t3.micro"
rds_engine_version_input  = "5.7"
rds_engine_input  = "mysql"
rds_allocated_storage_input  = 10



