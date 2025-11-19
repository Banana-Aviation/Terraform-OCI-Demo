provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.user_ocid
  fingerprint  = var.fingerprint
  private_key  = var.oci_api_key
  region       = var.region
}



resource "oci_core_instance" "my_instance" {
  count               = 1
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.display_name
  shape               = var.shape

  shape_config {
    ocpus         = 1
    memory_in_gbs = 1
  }

  create_vnic_details {
    subnet_id                 = var.subnet_id
    display_name              = var.vnic_display_name
    assign_public_ip          = true
    assign_private_dns_record = true
    hostname_label            = var.vnic_hostname_label
    assign_ipv6ip             = true
  }

  source_details {
    source_type             = var.instance_source_type
    source_id               = var.source_id
    boot_volume_size_in_gbs = 50
  }

  metadata = {
    ssh_authorized_keys = var.ssh_authorized_key
    # user_data = base64encode(file("cloud-init.yaml"))
    user_data = data.cloudinit_config.instance_config.rendered
  }

  timeouts {
    create = var.create_timeout
  }
}


# Retrieve the instance's VNIC
data "oci_core_vnic_attachments" "vnics" {
  count          = 1
  compartment_id = var.compartment_id
  instance_id    = oci_core_instance.my_instance[count.index].id
}
data "oci_core_vnic" "vnic" {
  count   = 1
  vnic_id = data.oci_core_vnic_attachments.vnics[count.index].vnic_attachments[0].vnic_id
}

# Output the IPv6 Address
output "public_ipv6_address" {

  value = [data.oci_core_vnic.vnic.*.ipv6addresses]
}
output "instance_private_ips" {
  value = [oci_core_instance.my_instance.*.private_ip]
}

output "instance_public_ips" {
  value = [oci_core_instance.my_instance.*.public_ip]
}

output "create_dispatch_event" {
  value = <<-EOT
          #!/usr/bin/env bash
          # create dispatch event for Github actions workflow 
          curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer <gh_pat>" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/Banana-Aviation/DemoProject/actions/workflows/208478659/dispatches -d '{"ref":"main"}'
          EOT
}