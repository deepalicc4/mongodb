variable sg_details {

type = map(object({
name = string                     
description = string


ingress_rules = list(object({       
                                    
description = string
from_port = number
to_port = number
protocol = string
cidr_blocks = list(string)


}))



}))

}

variable "sg_vpc" {}