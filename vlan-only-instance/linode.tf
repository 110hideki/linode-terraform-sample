# Create a boot disk
resource "linode_instance_disk" "boot" {
	label = "boot"
	linode_id = linode_instance.my-instance.id
	size = linode_instance.my-instance.specs.0.disk - var.dmzhost.swapsize
	image = var.dmzhost.image
#	root_pass = "terr4form-test"
	root_pass = random_string.password.result
}

# Create a swap disk
resource "linode_instance_disk" "swap" {
	label = "swap"
	linode_id = linode_instance.my-instance.id
	size = var.dmzhost.swapsize
	filesystem = "swap"
}

# Create a Linode instance
resource "linode_instance" "my-instance" {
	label = var.dmzhost.label
	type = var.dmzhost.type
	region = var.region
	tags = var.dmzhost.tags
#	root_pass = "terr4form-test"
	root_pass = random_string.password.result
}

# Create a Linode instance Config
resource "linode_instance_config" "my-config" {
	label = "my-config"
	linode_id = linode_instance.my-instance.id

	devices {
		sda {
			disk_id = linode_instance_disk.boot.id
		}
		sdb {
			disk_id = linode_instance_disk.swap.id
		}
	}

	helpers {
		# Disable the updatedb helper
		#updatedb_disabled = false
	}

	interface {
		purpose = var.vlan.purpose
		ipam_address = var.vlan.ipam_address
		label = var.vlan.label
	}

	 booted = true
}
