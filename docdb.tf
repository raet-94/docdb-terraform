#resource "aws_key_pair" "mykey" {
#  key_name   = "mykey"
#  public_key = file(var.PATH_TO_PUBLIC_KEY)
#}

resource "aws_docdb_cluster" "default" {
  cluster_identifier      = "tf-${var.name}-cluster"
  engine                  = "docdb"
  master_username         = "foo"
  master_password         = "mustbeeightchars"
  #availability_zones = ["${var.AWS_REGION}a", "${var.AWS_REGION}b", "${var.AWS_REGION}c"]
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  tags          = {
    Name        = "terraform-test-docdb"
    Environment = "development"
  }
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = "docdb-cluster-demo-${count.index}"
  cluster_identifier = aws_docdb_cluster.default.id
  instance_class     = "db.t3.medium"
}


