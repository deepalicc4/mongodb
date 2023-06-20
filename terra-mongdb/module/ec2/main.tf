resource "aws_instance" "webservers" { 
    
    ami = "ami-0f5ee92e2d63afc18"
    instance_type = "t2.micro" 
    security_groups = [var.mysecurity] 
    
    subnet_id = var.sub1
    key_name = aws_key_pair.deployer.key_name
    associate_public_ip_address = true
    user_data = "${file("./module/ec2/mongoscript.sh")}"
    
   
    
    
    tags = { 
    Name = "mongodb" 
     
    } 
}

resource "aws_key_pair" "deployer" {
  key_name   = "win-server"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxfcet1AqpLiZo0mwxi6jlmvr6J1o5Vbq6COW6G+CDKw1BR5Ji2ILvDjUQPETHE7245PNkd83jiW6bouysxSUri07OAQQ6LrN4mS11AJ3QN60S4L/AzchA5V3e9+OBbnV4aeB5pDW6sD6KOizpGKsNV956OOjPJ5G7AcaM5Lq1EekURz8afkthK89tIgLX8AihIV6E1eMdKBEbXRdzOD3intZXyv+l6bjufaqWH7RKkRFh8zG/sB7wfkPx6u6YzdTtiJN87WkI1HdatAM6of1OE1VpQVet8Y+L+iGUHEEniXgRsiXFqiNPQZXsrEFZIQGEtD/2QrQ1gvnOdcfh/DvX"
}


