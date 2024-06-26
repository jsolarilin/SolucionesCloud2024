variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "node_group_name" {
  type = string
}

variable "node_instance_type" {
  type = string
}

variable "node_root_volume_size" {
  type = number
}

variable "node_desired_capacity" {
  type = number
}

variable "node_max_capacity" {
  type = number
}

variable "node_min_capacity" {
  type = number
}

variable "node_volume_size" {
  type = number
}

variable "eks_tags" {
  type = map(string)
}
variable "node_key" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}
variable "eks_security_group_id" {
  type = string
}

variable "subnet1-id" {
  type = string
}
variable "subnet2-id" {
  type = string
  
}

 
   