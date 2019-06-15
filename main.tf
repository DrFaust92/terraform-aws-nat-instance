data "aws_ami" "nat_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat*"]
  }

  owners = ["amazon"]
}

data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}

resource "aws_instance" "nat_instance" {
  count = "${length(var.azs)}"

  vpc_security_group_ids      = "${concat(var.nat_security_groups,aws_security_group.nat_sg.id)}"
  ami                         = "${data.aws_ami.nat_ami.id}"
  availability_zone           = "${element(var.azs, count.index)}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  iam_instance_profile        = "${var.instance_profile_id}"
  subnet_id                   = "${element(var.public_subnets, count.index)}"
  source_dest_check           = false
  associate_public_ip_address = "${var.associate_public_ip_address}"

  tags = "${merge(map("Name",format("NAT Instance-%03d", count.index + 1)),var.tags)}"
}
