resource "aws_instance" "pubserver1"{
ami="${var.ami}"
instance_type="${var.inst_type}"
subnet_id="${aws_subnet.public-sub.id}"
user_data = data.template_file.userdata_win.rendered
vpc_security_group_ids = ["${aws_security_group.sgrp2.id}"]
associate_public_ip_address = "true"
}

data "template_file" "userdata_win" {
  template = <<EOF
<script>
mkdir C:\setup-scripts
cd C:\setup-scripts
echo "" > _INIT_STARTED_
net user ${var.INSTANCE_USERNAME} /add /y
net user ${var.INSTANCE_USERNAME} ${var.INSTANCE_PASSWORD}
net localgroup administrators ${var.INSTANCE_USERNAME} /add
echo ${base64encode(file("C://Program Files (x86)//Jenkins//workspace//actimize2//install-script-chrome.ps1"))} > tmp1.b64 && certutil -decode tmp1.b64 install-script-chrome.ps1
echo ${base64encode(file("C://Program Files (x86)//Jenkins//workspace//actimize2//install-script-Java.ps1"))} > tmp1.b64 && certutil -decode tmp1.b64 install-script-Java.ps1
echo ${base64encode(file("C://Program Files (x86)//Jenkins//workspace//actimize2//install-script-npp.ps1"))} > tmp1.b64 && certutil -decode tmp1.b64 install-script-npp.ps1
powershell.exe -file "C:\setup-scripts\install-script-chrome.ps1"
powershell.exe -file "C:\setup-scripts\install-script-Java.ps1"
powershell.exe -file "C:\setup-scripts\install-script-npp.ps1"
echo "" > _INIT_COMPLETE_
</script>
<persist>false</persist>
EOF
}

/*resource "aws_instance" "pubserver2"{
ami="${var.ami}"
instance_type="${var.inst_type}"
subnet_id="${aws_subnet.public-sub.id}"
user_data = data.template_file.userdata_win.rendered
vpc_security_group_ids = ["${aws_security_group.sgrp2.id}"]
key_name="terrause"

associate_public_ip_address = "true"
}

resource "aws_instance" "appserver1"{
ami="${var.ami}"
instance_type="${var.inst_type}"
subnet_id="${aws_subnet.subnet1.id}"
user_data = data.template_file.userdata_win.rendered
vpc_security_group_ids = ["${aws_security_group.sgrp1.id}"]
iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
key_name="terrause"
tags = {
    name = "INSTNCE1"
 }
}

resource "aws_instance" "appserver2"{
ami="${var.ami}"
instance_type="${var.inst_type}"
subnet_id="${aws_subnet.subnet2.id}"
user_data = data.template_file.userdata_win.rendered 
vpc_security_group_ids = ["${aws_security_group.sgrp1.id}"]
iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
key_name="terrause"
tags = {
    name = "INSTANCE2"
  }
} */

