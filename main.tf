provider "aws" {
  alias  = "us-west-1"
  #region = "us-west-1"
  region = "ap-east-1"
}


resource "aws_rds_cluster" "default" {
  provider            = aws.us-west-1
  cluster_identifier  = "wp-demo"
  engine              = "aurora-mysql"
  engine_version      = "5.7.mysql_aurora.2.03.2"
  availability_zones  = ["us-west-1b", "us-west-1c"]
  database_name       = "wpdb"
  master_username     = "admin"
  master_password     = "chip2020"
  skip_final_snapshot = true
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  provider           = aws.us-west-1
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  engine             = "aurora-mysql"
  engine_version     = "5.7.mysql_aurora.2.03.2"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "db.t2.small"
}
