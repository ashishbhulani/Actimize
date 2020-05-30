resource "aws_lb" "loadblncer" {
name="loadblncr"
internal=true
load_balancer_type="application"
security_groups=["${aws_security_group.sgrp1.id}"]
subnets=["${aws_subnet.subnet1.id}","${aws_subnet.subnet2.id}"]
enable_deletion_protection=false
}
