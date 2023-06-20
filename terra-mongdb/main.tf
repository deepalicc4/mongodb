provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA6GGOQB2JPOC57DEC"
  secret_key = "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"
}
module "loadbalancer" {
  
  source = "./module/loadbalancer"
  vpclb = module.vpc.vpc-id.id
  //ami-id = module.ec2.instanceid1.id
  sub1= lookup(module.vpc.mysubid , "sub-1" ,null).id
  sub2= lookup(module.vpc.mysubid, "sub-2" ,null).id
  lbsg1 = module.security-group.lbsg1.id
  //lbsg = lookup(module.security-group.sg-output,"sg-1",null).id
}
module "autoscaling" {
  source = "./module/autoscaling"
  mykey = module.ec2.keyname
  image_id = "ami-0f5ee92e2d63afc18"
  mytgarn = [module.loadbalancer.mytgarm1.arn]
  mytgarn2 = [module.loadbalancer.tg2.arn]
  mysub1 = lookup(module.vpc.mysubid , "sub-1" ,null).id
  mysub2 = lookup(module.vpc.mysubid, "sub-2" ,null).id



}

module "rds" {
source = "./module/rds"

mydb = var.mydb
myengine = var.myengine
engineversion = var.engineversion
instancetype = var.instancetype
username = var.username
password = var.password

}


module "vpc" {
  source         = "./module/vpc"
  pubsubnet_cidr = var.pubsubnet_cidr
  private-cidr   = var.private-cidr
  mycidr         = var.mycidr

}



module "security-group" {
  source = "./module/security-group"
  sg_vpc = module.vpc.vpc-id.id
  sg_details = {

    sg-1 = {
      name        = "my sg1"
      description = "rules for ssh"
      egress = {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
      }
      ingress_rules = [
        {
          description = "rules for ssh"
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]

        },
        {
          description = "rules for web"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]

        },
        {
          description = "rules for mongodb"
          from_port   = 27071
          to_port     = 27071
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]

        },
        {
          description = "rules for app"
          from_port   = 8080
          to_port     = 8080
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]

        },
        {
          description = "rules for ssh"
          from_port   = 3000
          to_port     = 3000
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]

        }


      ]


    }
   


  }
}
# module "security-group-2" {
#   source = "./module/security-group"
#   sg_vpc = module.vpc.vpc-id.id
#   sg_details = {

#     sg-1 = {
#       name        = "ec2 sg"
#       description = "rules for ssh"
#       egress = {
#         from_port        = 0
#         to_port          = 0
#         protocol         = "-1"
#         cidr_blocks      = ["0.0.0.0/0"]
#         ipv6_cidr_blocks = ["::/0"]
        
#       }
#       ingress_rules = [
#         {
#           description = "rules for web"
#           from_port   = 80
#           to_port     = 80
#           protocol    = "tcp"
#           cidr_blocks = ["0.0.0.0/0"]

#         },
#         {
#           description = "rules for ssh"
#           from_port   = 3000
#           to_port     = 3000
#           protocol    = "tcp"
#           cidr_blocks = ["0.0.0.0/0"]
#         }


#       ]


#     }
   


#   }



# }
module "ec2" {
  source     = "./module/ec2"
  sub1       = lookup(module.vpc.mysubid, "sub-1", null).id
  mysecurity = lookup(module.security-group.sg-output, "sg-1", null).id
}