output "vpc-id" {
 value = aws_vpc.main
}

output  "mysubid" {
    value = {for k,v in aws_subnet.pubsubnet_cidr:k=>v} 
}


