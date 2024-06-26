data "aws_iam_role" "labrole-arn" {
    name = "LabRole"
 }
 
resource "aws_eks_cluster" "terraform-eks-cluster-obligatorio-soluciones-cloud" {
  name     = var.cluster_name
  role_arn = data.aws_iam_role.labrole-arn.arn

  vpc_config {
    subnet_ids = [
      var.subnet1-id,
      var.subnet2-id
    ]
    security_group_ids = [
      var.eks_security_group_id
    ]
  }
}
#Creo los nodos/workers del cluster
resource "aws_eks_node_group" "terraform-eks-node-obligatorio-soluciones-cloud" {
  cluster_name    = aws_eks_cluster.terraform-eks-cluster-obligatorio-soluciones-cloud.name
  node_group_name = var.node_group_name
  node_role_arn   = data.aws_iam_role.labrole-arn.arn
  subnet_ids      = [var.subnet1-id, var.subnet2-id]
  
  
  remote_access {
    ec2_ssh_key = var.node_key
  }

  scaling_config {
    desired_size = var.node_desired_capacity
    max_size     = var.node_max_capacity
    min_size     = var.node_min_capacity
  }

  update_config {
    max_unavailable = 1
  }
}

