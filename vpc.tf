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
  name        = "tf-${var.name}-sg"
  vpc_id      = "${var.vpc_id}"

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
  type              = "ingress"
  to_port           = 27017
  protocol          = "0"
  #prefix_list_ids   = [aws_vpc_endpoint.my_endpoint.prefix_list_id]
  from_port         = 0
  security_group_id = "${aws_security_group.service.id}"
  source_security_group_id= "${var.sg_id}"
  description= "Allow communication from de sg ${var.sg_id}"
 
  #  type= "ingress"
  #  to_port= 443
  #  cidr_blocks= []
  #  description= "Allow pods to communicate with the EKS cluster API."
  #  from_port= 443
  #  security_group_id= "sgrule-2719853536"
  #  ipv6_cidr_blocks= []
  #  prefix_list_ids= []
  #  protocol= "tcp"
  #  security_group_id= "sg-015c598c3c7504893"
  #  self= false
  #  source_security_group_id= "sg-01e27000528ada6be"
    
    
          
}

resource "aws_security_group_rule" "allow_all_sg_1" {
  type              = "ingress"
  to_port           = 27017
  protocol          = "0"
  #prefix_list_ids   = [aws_vpc_endpoint.my_endpoint.prefix_list_id]
  from_port         = 0
  security_group_id = "${aws_security_group.sg_id}"
  source_security_group_id= "${var.sg_id}"
  description= "Allow communication from de sg ${var.sg_id}"
  }
