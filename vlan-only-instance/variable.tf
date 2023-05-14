variable "token" {}

variable "region" {
        default = "ap-south"
}

variable "dmzhost" {
	default = {
		label = "linode-ap-south-05-dmz-tf"
		image = "linode/ubuntu22.04"
		type = "g6-nanode-1"
		tags = ["vlan"]
		swapsize = 512
	}
}

variable "vlan" {
	default = {
		label = "myVLAN"
		purpose = "vlan"
		ipam_address = "10.0.0.5/24"
	}
}

resource "random_string" "password" {
#	length = 32
	length = 11
	special = true
	upper = true
	lower = true
	numeric = true
}
