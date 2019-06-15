resource "aws_security_group" "nat_sg" {
  name_prefix = "${var.nat_sg_name}-nat-sg-"
  description = "Security Group for NAT Instance"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  tags = "${var.tags}"
}

resource "aws_security_group_rule" "egress_443_rule" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.nat_sg.id}"
  to_port           = 443
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "egress_80_rule" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.nat_sg.id}"
  to_port           = 80
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_443_rule" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.nat_sg.id}"
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = ["${var.private_subnets}"]
}

resource "aws_security_group_rule" "ingress_80_rule" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.nat_sg.id}"
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["${var.private_subnets}"]
}

resource "aws_security_group_rule" "ingress_ssh_rule" {
  count             = "${var.allow_ssh ? 1 : 0}"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.nat_sg.id}"
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["${var.ssh_ingress_range}"]
}
