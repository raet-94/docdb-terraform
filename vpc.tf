#module "vpc" {
#  source = "terraform-aws-modules/vpc/aws"
#
#  name = "tf-${var.name}"
#  cidr = "10.0.0.0/16"
#
#  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
#  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
#
#  enable_dns_hostnames = true
#  enable_dns_support = true
#  enable_nat_gateway = true
#  enable_vpn_gateway = true
#  single_nat_gateway = false
#}

resource "aws_security_group" "service" {
  name        = "tf-${var.name}"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  prefix_list_ids   = [aws_vpc_endpoint.my_endpoint.prefix_list_id]
  from_port         = 0
  security_group_id = "${module.aws_security_group.aws_security_group_id}"
}
