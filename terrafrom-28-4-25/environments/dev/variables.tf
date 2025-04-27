####COMMON########

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "Environment" {
  type        = string
  description = "Environment"
}

variable "private_subnet1" {
  type        = string
  default = ""
}

variable "vpc_id" {
  type        = string
  default = ""
}

variable "vpc_cidr_block" {
  type        = string
  default = ""
}

variable "private_subnet_ids" {
  type        = list(string)
  default = []
}

variable "public_subnet_ids" {
  type        = list(string)
  default = []
}

variable "cmk_arn" {
  type        = string
  default = ""
}

variable "cluster-name" {
  description = "The name of the cluster"
  type        = string
}


####VPC#####

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)

}

variable "customer_name" {
  description = "Enter name of the customer"
  type        = string
}

############KMS############################################################

variable "kms_tags" {
  type = map(string)
  
}

####################KMS################################################
variable "ami" {
  type        = string
  description = "The ID of the Amazon Machine Image (AMI) used to launch the instance"
}

variable "ec2_instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}

variable "linux_tags" {
  type = map(string)
}


####################EC2_MSSQL###################################
variable "mssql_ami" {
  type        = string
  description = "The ID of the Amazon Machine Image (AMI) used to launch the instance"
}

variable "mssql_ec2_instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}

variable "ec2_mssql_tags" {
  type = map(string)
}

###################EKS-variable######################################
variable "k8s_version" {
  description = "Kubernetes version."
  type        = string
}

variable "eks_tags" {
  type = map(string)
}

##########################Nodegroups##########################

variable "cloudwatch_logs" {
  type        = bool
  description = "Setup full CloudWatch logging."
}

variable "ec2_root_volume_size" {
  type        = string
}

variable "eks_cluster_sg_id" {
  type        = string
  default = ""
}

variable "eks_cluster_id" {
  type        = string
  default = ""
}



variable "node_groups_test" {
  description = "List of node groups with specific ingress and egress rules"
  type = list(object({
    name            = string
    instance_types  = list(string)
    ng_test_tags = map(string)
    labels          = map(string)
    tolerations     = object({
      key    = string
      value  = string
      effect = string
    })
    minimum_size    = number
    maximum_size    = number
    desired_size    = number
    capacity_type   = string
  }))
}

variable "node_groups_test_tt" {
  description = "List of node groups with specific ingress and egress rules"
  type = list(object({
    name            = string
    instance_types  = list(string)
    ng_test_tags = map(string)
    labels          = map(string)
    minimum_size    = number
    maximum_size    = number
    desired_size    = number
    capacity_type   = string

  }))
}

#######################RDS######################
variable "rds_db_instance_identifier" {
  type        = string
  description = "Please mention the Database Instance Identifier"
}

variable "rds_database_name" {
  type        = string
  description = "rds Database Name"
}

variable "database_user" {
  type        = string
  description = "rds Database Username"
}

variable "major_version" {
  type        = string
  description = "rds Database Parameter Group Major Version"
}

variable "engine_version" {
  type        = string
  description = "rds Database Engine Version"
}

variable "rds_db_instance_type" {
  type        = string
  description = "rds Database Instance Type"
}

variable "rds_db_allocated_storage" {
  type        = string
  description = "rds Database Storage Size"
}

variable "rds_port" {
  type        = string
  description = "rds CIDR Range"
}
variable "rds_tags" {
  type = map(string)
}

#########################REDIS#################################
variable "redis-cluster" {
  type        = string
  description = "The ID of the ElastiCache cluster"
}

variable "redis-engine" {
  type        = string
  description = "The name of the cache engine to be used for the clusters in this replication group"
}

variable "redis-engine-version" {
  type        = string
  description = "The version number of the cache engine to be used for the cache clusters in this replication group"
}

variable "redis-node-type" {
  type        = string
  description = "The compute and memory capacity of the nodes in the node group"
}

variable "num-node-groups" {
  description = "The number of node groups (shards) for this Redis replication group"
  type        = number
}

variable "replicas-per-node-group" {
  description = "The number of replica nodes in each node group (shard)"
  type        = number
}

variable "parameter-group-family" {
  description = "The initial number of cache nodes that the cache cluster has"
  type        = string
}

variable "replication-id" {
  type        = string
  description = "(optional) describe your variable"
}

variable "elasticache_tags" {
  type = map(string)
}

variable "redis-user-id" {
  type = string
}

variable "redis-user-name" {
  type = string
}

variable "redis_port" {
  type        = string
  description = "VRT CIDR Range"
}

variable "redis_rest_encryption" {
  type        = string
}

variable "redis_transit_encryption" {
  type        = string
}


#########################ALB#################################

variable "internal" {
  description = "Whether the load balancer is internal or not"
  type        = bool
}

variable "target-gorup-protocol" {
  type        = string
  description = "protocol for target group"
}

variable "target-group-port" {
  type        = string
  description = "port for target group"
}

variable "listener-protocol" {
  type        = string
  description = "protocol type"
}

variable "listener-port" {
  type        = number
  description = "ports"
}

variable "lb_tags" {
  type = map(string)
}


######################RabbitMQ########################

variable "mq_engine_version" {
  description = "RabbitMQ engine version"
  type        = string
}

variable "host_instance_type" {
  description = "Instance type for the broker"
  type        = string
}

variable "deployment_mode" {
  description = "Deployment mode - SINGLE_INSTANCE or ACTIVE_STANDBY_MULTI_AZ"
  type        = string
}

variable "publicly_accessible" {
  description = "Whether the broker is publicly accessible"
  type        = bool
}

variable "auto_minor_version_upgrade" {
  description = "Enable automatic minor version upgrades"
  type        = bool
}

variable "apply_immediately" {
  description = "Apply changes immediately"
  type        = bool
}

variable "logs_general" {
  description = "Enable general logging"
  type        = bool
}

variable "maintenance_day" {
  description = "Preferred maintenance day"
  type        = string
}

variable "maintenance_time" {
  description = "Preferred maintenance start time"
  type        = string
}

variable "maintenance_timezone" {
  description = "Timezone for maintenance window"
  type        = string
}

variable "mq_username" {
  description = "Username for RabbitMQ broker access"
  type        = string
}

variable "console_access" {
  description = "Allow user console access"
  type        = bool
}

variable "user_groups" {
  description = "Groups to which the user belongs"
  type        = list(string)
}

variable "mq_tags" {
  description = "Tags to assign to resources"
  type        = map(string)
}
