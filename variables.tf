variable "vpc_cidr"{
default="10.0.0.0/24"
}

variable "inst_type"{
default="t2.micro"
}

variable "inst_class"{
default="db.t2.micro"
}

variable "eng"{
default="sqlserver-ex"
}

variable "sqlver"{
default="14.00.3223.3.v1"
}


variable "prvt_subnet1_cidr"{
default="10.0.0.0/26"
}

variable "prvt_subnet2_cidr"{
default="10.0.0.64/26"
}

variable "prvt_subnet3_cidr"{
default="10.0.0.128/26"
}

/*variable "prvt_subnet4_cidr"{
default="10.192.0.0/11"
}*/


variable "ami"{
default="ami-0f7122ac3de6f22b2"
}

variable "dbusername"{
default="rose"
}

variable "pswrd"{
default="lavender1"
}

variable "INSTANCE_USERNAME" { default = "admin" } 
variable "INSTANCE_PASSWORD" { }
