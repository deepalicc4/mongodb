mycidr       = "10.0.0.0/16"
private-cidr = "10.0.4.0/24"

pubsubnet_cidr = {

  sub-1 = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
  }
  sub-2 = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
  }
}



mydb = "mysql1"
myengine = "mysql"
engineversion = "5.7"
instancetype = "db.t3.micro"
username = "mysql1"
password = "mysql1"