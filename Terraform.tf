#how to use aws to terraform
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.32.0"
    }
  }
}

# auth to aws cloud go to aws cloud and create  go to iam and create a role for access the aws crete a access key and secrte_key


provider "aws"{
	region = "ap-south-1"
	access_key = "AKIASYDD5CFZ3WU6VOHR"
	secret_key = "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"
}


# manage use Resources resouces like ec2,s3,vpc,

variable "amiId" {
		default = "ami-01216e7612243e0ef"
}
 variable "osName" {
default = "my_os1_terraform_1"
}
 
resource "aws_instance" "os1"{
	ami = var.amiId
	subnet_id = "subnet-01fa311342c6fc8c2"	
	vpc_security_group_ids = ["sg-098a10eed5b7e0e1e"]
	key_name = "mykey_don't delete_key"
	instance_type = "t2.micro"
	 private_ip ="172.31.1.10"	  
	associate_public_ip_address = "true"
		tags ={
		Name ="var.osName"
	}

 connection{
	type = "ssh"
	user = "ec2-user"
	private_key = file( "C:/Users/Ratan/Downloads/mykey_dontdelete_key.pem" )
	host = "3.110.160.191"
}

provisioner "remote-exec"{
	inline = ["sudo yum install httpd -y",
		   "sudo touch /var/www/html/index.html",
		   "sudo systemctl enable httpd --now"
		]
  }
}

