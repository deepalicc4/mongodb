output instanceid1 {

value = aws_instance.webservers

}

output "keyname" {

value = aws_key_pair.deployer.id

}