output "instance_id" {
  value = "${zipmap(var.azs,aws_instance.nat_instance.*.id)}"
}
