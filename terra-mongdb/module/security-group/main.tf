resource "aws_security_group" "sg-ec2" {
  for_each = var.sg_details          
  name        = each.value["name"]
  description = each.value["description"]
  vpc_id      = var.sg_vpc 

dynamic "ingress" {                             
    for_each = lookup(each.value, "ingress_rules", [])
    content{
    description      = lookup(ingress.value, "description",null)  
    from_port        = lookup(ingress.value, "from_port",null)
    to_port          = lookup(ingress.value, "to_port",null)
    protocol         = lookup(ingress.value, "protocol",null)
    cidr_blocks      = lookup(ingress.value, "cidr_blocks",null)
    
  }
  }
   egress {
    from_port        = 0
     to_port          = 0
     protocol         = "-1"
     cidr_blocks      = ["0.0.0.0/0"]
     ipv6_cidr_blocks = ["::/0"]
   }
  tags = {
    Name = "sg-ec2"
  }
}


resource "aws_security_group" "SG-LB" {
  name        = "nginx-sg"
  description = "Allow 80 inbound traffic"
  vpc_id      = var.sg_vpc

  ingress {
    description      = "port for nginx"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "nginx-sg"
  }
}