output sg-output{
    value = {for k,v in aws_security_group.sg-ec2:k=>v}  
}

output "lbsg1" {
    value = {for k,v in aws_security_group.SG-LB:k=>v}  
}
