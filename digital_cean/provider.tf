# export Digital ocean token into environment variables (export DO_PAT="")
# Apply instances  "terraform apply -var "do_token=${DO_PAT}" "
# destroy instances "terraform destroy -var "do_token=${DO_PAT}" ""

provider "digitalocean" {
  token = "${var.do_token}"
}
