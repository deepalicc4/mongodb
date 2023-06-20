resource "aws_launch_template" "sample-lt" {
  name = "test-lt"

  image_id = var.image_id
  instance_type = "t2.micro"
  key_name = var.mykey

}

resource "aws_launch_template" "tomcat-template" {
  name = "tomcat-template"

  image_id = var.image_id
  instance_type = "t2.micro"
  key_name = var.mykey

}

resource "aws_autoscaling_group" "sample-asg" {
  name = "terra-ASG"
  target_group_arns =  var.mytgarn
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  
  vpc_zone_identifier = [var.mysub1 , var.mysub2]
  launch_template {
    id      = aws_launch_template.sample-lt.id
    
  }
}

resource "aws_autoscaling_group" "asg-tomcat" {
  name = "tomcat-asg"
  target_group_arns =  var.mytgarn2
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  
  vpc_zone_identifier = [var.mysub1 , var.mysub2]
  launch_template {
    id      = aws_launch_template.tomcat-template.id
    
  }
}


