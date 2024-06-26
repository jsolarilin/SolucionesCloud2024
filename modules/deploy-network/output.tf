#Variable de output Network
output "vpc_id" {
  value = aws_vpc.vpc-obligatorio-soluciones-cloud.id
}
output "subnet1_id" {
  value = aws_subnet.obligatorio-soluciones-cloud-subnet1.id
}
output "subnet2_id" {
  value = aws_subnet.obligatorio-soluciones-cloud-subnet2.id
}

output "eks_security_group_id" {
  value = aws_security_group.terraform-eks-sg.id
}
output "terraform_rds_sg_id" {
  value = aws_security_group.terraform-rds-sg.id
}

output "terraform-subnet-group-db" {
  value = aws_db_subnet_group.terraform-subnet-group-db.name
}



