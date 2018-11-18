# Using Terraform, ansible and cloud-init to build a Digital Ocean Droplet.

## Add Digital Ocean Token to the environment

- ```export DO_PAT=""```

place your Digital Ocean token between the quotes above.

## Run setup.yml

```ansible-playbook setup.yml```

## Initialize terraform

- ```terraform init```

### modify user_data.yml file within cloudinit repository (directory)

- locate the ```ssh-authorized-keys:``` section and replace the ssh key with your ssh public key.

**Note** You can change the deployuser to any user you want. This script will create a user with your public key that allows you to ssh directly into your droplet.

## Validate Terraform code

```terraform validate```

## Run terrafrom format against the code

```terraform fmt```

## Create a terraform plan

```terraform plan -out=$(planfile) -var "do_token=${DO_PAT}"```

- ```$(planfile)``` should lead to a directory and file outside of your present directory.

The command above will create a terrafrom plan file which shows you what will happen without making any changes.

## Build the site (create the Droplet)

```terraform apply -var "do_token=${DO_PAT}"```

## Review your droplet

- execute command ```terraform show```

output should look like similiar to

```
 [cmills:~/github/oshane] $ terraform show
digitalocean_droplet.srv1: (tainted)
  id = 118778243
  backups = false
  disk = 30
  image = ubuntu-14-04-x64
  ipv4_address = 104.248.3.167
  ipv4_address_private = 
  ipv6 = false
  ipv6_address = 
  ipv6_address_private = 
  locked = false
  memory = 1024
  monitoring = false
  name = srv-0
  price_hourly = 0.01488
  price_monthly = 10
  private_networking = false
  region = nyc3
  resize_disk = true
  size = 1gb
  ssh_keys.# = 1
  ssh_keys.1380878416 = 6c:3c:f2:57:ed:b6:56:56:91:d2:84:e2:06:c7:43:d6
  status = active
  tags.# = 0
  user_data = 8051298ad7174744ba158e14790e8135df52f06a
  vcpus = 1
  volume_ids.# = 0
```

### SSH into your droplet

You should now be able to ssh into your Droplet using the "ipv4_address" obtainned by the resuls of executing the command above, substitute the "ipv4_address" from above int the command below.

```ssh deployuser@104.248.3.167```

- If you changed the user within the cloudinit/user_data.yml substitute that with the username above as well.

## Destroy the droplet

```terraform plan -destroy```

will create a plan file that shows you what will be destroyed without actually destroying anything.

once you are ready, run the command below to destroy the droplet.

```terraform destroy -var "do_token=${DO_PAT}"```




