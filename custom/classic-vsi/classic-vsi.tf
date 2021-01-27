variable "dc" {
  type = "string"
}

variable "public_ssh_key" {
  description = "Public SSH key used to connect to the virtual guest"
}

resource "ibm_compute_ssh_key" "cam_public_key" {
  label      = "CAM Public Key"
  public_key = "${var.public_ssh_key}"
}

resource "ibm_compute_vm_instance" "vm1" {
    hostname             = "vm1"
    domain               = "example.com"
    os_reference_code    = "UBUNTU_18_64"
    datacenter           = "${var.dc}"
    network_speed        = 10
    hourly_billing       = true
    private_network_only = false
    cores                = 1
    memory               = 1024
    disks                = [25]
    local_disk           = false
    ssh_key_ids          = ["${ibm_compute_ssh_key.cam_public_key.id}"]
}

# data "ibm_iam_users" "users_profiles"{
# }

# output "user" {
#   value = data.ibm_iam_users.users_profiles.users
# }  ##


