provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_dns_record" "cat0" {
  count   = 1
  zone_id = var.zone_id
  name    = "cat0"
  ttl     = 60
  content = oci_core_instance.my_instance.*.public_ip[count.index]
  type    = "A"
  proxied = false
}