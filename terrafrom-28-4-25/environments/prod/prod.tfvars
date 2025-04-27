
account_id = "296062546708"

Environment = "prod"

customer_name = "uipl-demo"

####VPC variables################################################
vpc_cidr = "10.0.0.0/16"
public_subnet_1_cidr = "10.0.0.0/24"
public_subnet_2_cidr = "10.0.1.0/24"
private_subnet_1_cidr = "10.0.2.0/24"
private_subnet_2_cidr = "10.0.3.0/24"
vpc_tags = {map-migrated: "mig3JL1ESW2OI"}

#############KMS###########################################
kms_tags = {map-migrated: "mig3JL1ESW2OI"}

#######EC2-Linux vairbales###################################

ami = "ami-07a6f770277670015"
ec2_instance_type = "t2.micro"
linux_tags = {map-migrated: "mig3JL1ESW2OI"}

###############EC2-MSSQL variables

mssql_ami = "ami-0ee0763aa195c298f"
mssql_ec2_instance_type = "r5.xlarge"
ec2_mssql_tags = {map-migrated: "mig3JL1ESW2OI"}

##############EKS vairbales#########################################

k8s_version = "1.31"
cluster-name =  "test-prod-eks-cluster"
eks_tags = {map-migrated: "mig3JL1ESW2OI"}

##############Nodegroups vairbales########################################

cloudwatch_logs = false
ec2_root_volume_size = "20"
node_groups_test = [
  {
    name           = "nginx-ondemand-new"
    instance_types = ["t3.medium"]
    ng_test_tags = {
      map-migrated: "mig3JL1ESW2OI"
    }
    labels = {
      vrt-cug-nginx = "true"
    }
    tolerations = {
      key    = "key"
      value  = "persistTool"
      effect = "NO_SCHEDULE"
    }
    minimum_size   = 1
    maximum_size   = 2
    desired_size   = 1
    capacity_type  = "ON_DEMAND"
  }
]

node_groups_test_tt = [
  {
    name           = "application-nodegroup-ondemand-new"
    instance_types = ["m6i.large", "t3.medium", "r6i.large"]
    ng_test_tags = {
      map-migrated: "mig3JL1ESW2OI"
    }
    labels = {
      prod = "true"
    }
    minimum_size   = 2
    maximum_size   = 6
    desired_size   = 2
    capacity_type  = "ON_DEMAND"
  }
]

###############RDS########################

rds_db_instance_identifier = "test-prod-db-tech"
rds_database_name = "test_prod_database"
database_user = "dbadmin"
major_version = "12"
engine_version = "12.18"
rds_db_instance_type = "db.m6g.large"
rds_db_allocated_storage = "20"
rds_port = 5432
rds_tags  = {map-migrated: "mig3JL1ESW2OI"}

#########################redis_variables######################

redis-cluster = "prod-redis-cluster"
redis-engine = "REDIS"
redis-engine-version = "7.0"
redis-node-type = "cache.t3.small"
num-cache-nodes = "1"
num-node-groups = "1"
replicas-per-node-group = "1"
parameter-group-family = "redis7"
replication-id = "test-prod-elasticache-replication"
redis-user-id = "redis-user"
redis-user-name = "default"
redis_port = 6379
redis_transit_encryption = true
redis_rest_encryption = true
elasticache_tags = {map-migrated: "mig3JL1ESW2OI"}

#########################ALB################################

load_balancer_name = "test-ALB"
internal = false
load_balancer_type = "application"
lb_security_group = "dev-load-balancer-sg"
target-group-name = "tg-dev-sg-lb"
target-group-port = 443
target-gorup-protocol = "HTTPS"
listener-protocol = "HTTP"
listener-port = 80
lb_tags = {map-migrated: "mig3JL1ESW2OI"}



###############RabbitMQ################

broker_name              = "my-rabbitmq-broker"
mq_engine_version           = "3.13"               # Use `aws mq describe-broker-engine-types` for available versions
host_instance_type       = "mq.t3.micro"
deployment_mode          = "SINGLE_INSTANCE"       # or "ACTIVE_STANDBY_MULTI_AZ"
publicly_accessible      = false
auto_minor_version_upgrade = true
apply_immediately        = true
storage_type             = "ebs"                   # or "ebs"

mq_subnet_ids               = ["subnet-0f4455b9624291255"]
mq_vpc_id                   = "vpc-09fe2a53f75bc319e"
mq_security_group_name      = "rabbitmq-sg"
mq_security_group_description = "Security group for RabbitMQ broker"
mq_port                  = 5671                     # AMQP TLS port
mq_allowed_cidrs            = ["10.0.0.0/16"]          # Change to allow only required CIDR ranges

mq_username                 = "admin"
console_access           = true
user_groups              = ["admins"]

maintenance_day          = "WEDNESDAY"
maintenance_time         = "02:00"
maintenance_timezone     = "UTC"

logs_general             = true

mq_tags = {Name: "dmeo-mq",Environment = "prod"}




















































