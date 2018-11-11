resource "digitalocean_droplet" "srv1" {
  image     = "${var.droplet_image}"
  name      = "${var.srv_name}"
  region    = "${var.region}"
  size      = "${var.droplet_memory_size}"
  ssh_keys  = ["${var.ssh_fingerprint}"]
  user_data = "${file("cloud_init/user_data.yml")}"

  # Create ansible configuration file
  provisioner "local-exec" {
    command = "sleep 20 && echo \"[srv1]\n${digitalocean_droplet.srv1.ipv4_address} ansible_connection=ssh ansible_ssh_user=deployuser\" > inventory"
  }

  # Run shell script to install apache and deploy domain(s)
  provisioner "local-exec" {
    command = "sleep 120 && shell_scripts/execute_roles.sh"
  }
}

resource "digitalocean_floating_ip" "srv1" {
  droplet_id = "${digitalocean_droplet.srv1.id}"
  region     = "${var.region}"
}

/*
# Create A record for domain.
resource "digitalocean_domain" "site" {
  name       = "www.fixyourip.com"
  ip_address = "${digitalocean_droplet.srv1.ipv4_address}"
}
*/

