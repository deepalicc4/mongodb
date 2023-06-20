variable "private-cidr" {}
variable "mycidr" {}
variable "pubsubnet_cidr" {
  type = map(any)

}
//variable "vpclb" {}

variable "mydb" {}
variable "myengine" {}
variable "engineversion" {}
variable "instancetype" {}
variable "username" {}
variable "password" {}