#Ejecuto el modulo deploy-network
module "deploy-network" {
    source = "./modules/deploy-network"
    perfil = var.perfil_input
    region = var.region_input
    vpc_cidr = var.vpc_cidr_input
    subnet1 = var.subnet1_input
    subnet2 = var.subnet2_input
    vpc_aws_az = var.vpc_aws_az_input
    vpc_aws_az1 = var.vpc_aws_az1_input
    vpc_aws_az2 = var.vpc_aws_az2_input

}

# #Ejecuto el modulo deploy-eks
module "deploy-eks" {
    source = "./modules/deploy-eks"
    cluster_name = var.cluster_name_input
    cluster_version = var.cluster_version_input
    node_group_name = var.node_group_name_input
    node_instance_type = var.node_instance_type_input
    node_root_volume_size = var.node_root_volume_size_input
    node_desired_capacity = var.node_desired_capacity_input
    node_max_capacity = var.node_max_capacity_input
    node_min_capacity = var.node_min_capacity_input
    node_volume_size = var.node_volume_size_input
    eks_tags = var.eks_tags_input
    node_key = var.node_key_input
    vpc_security_group_ids = [module.deploy-network.eks_security_group_id]
    # Paso los outputs del módulo deploy-network al módulo deploy-eks
    eks_security_group_id = module.deploy-network.eks_security_group_id
    subnet1-id = module.deploy-network.subnet1_id
    subnet2-id = module.deploy-network.subnet2_id

}
#Ejecuto el modulo deploy-rds
module "deploy-rds" {
    source = "./modules/deploy-rds"
    rds_username = var.rds_username_input
    rds_password = var.rds_password_input
    rds_db_name = var.rds_db_name_input
    rds_parameter_group_name = var.rds_parameter_group_name_input
    rds_instace_class = var.rds_instace_class_input
    rds_engine_version = var.rds_engine_version_input
    rds_engine = var.rds_engine_input
    rds_allocated_storage = var.rds_allocated_storage_input
    # Paso los outputs del módulo deploy-network al módulo deploy-rds
    terraform_rds_sg_id = module.deploy-network.terraform_rds_sg_id
    subnet1_id = module.deploy-network.subnet1_id
    subnet2_id = module.deploy-network.subnet2_id
    terraform-subnet-group-db = module.deploy-network.terraform-subnet-group-db

}
