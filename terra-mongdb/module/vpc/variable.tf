variable "private-cidr" {}
variable "mycidr" {}
variable "pubsubnet_cidr" {
  type = map(object({

    cidr_block        = string
    availability_zone = string
  }))


}
