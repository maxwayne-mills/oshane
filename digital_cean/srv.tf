resource "digitalocean_droplet" "srv-0" {
  image     = "${var.droplet_image}"
  name      = "${var.srv_name}"
  region    = "${var.region}"
  size      = "${var.droplet_memory_size}"
  ssh_keys  = ["${var.ssh_fingerprint}"]
  user_data = "${file("cloud_init/user_data.yml")}"

  # Create ansible configuration file
  provisioner "local-exec" {
    command = "sleep 20 && echo \"[srv-0]\n${digitalocean_droplet.srv-0.ipv4_address} ansible_connection=ssh ansible_ssh_user=deployuser\" > inventory"
  }
}

resource "digitalocean_floating_ip" "srv-0" {
  droplet_id = "${digitalocean_droplet.srv-0.id}"
  region     = "${var.region}"
}
