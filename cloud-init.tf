# 273.06 seconds
data "cloudinit_config" "instance_config" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      package_update  = true
      package_upgrade = false
      apt = {
        sources = {
          "docker.list" = {
            source = "deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable"
            keyid  = "9DC858229FC7DD38854AE2D88D81803C0EBFCD88"
          }
        }
      }
      groups = ["docker"]

      system_info = {
        default_user = {
          groups = ["docker"]
        }
      }

      packages = [
        "curl",
        "tar",
        "apt-transport-https",
        "ca-certificates",
        "jq",
        "gnupg-agent",
        "software-properties-common",
        "docker-ce",
        "docker-ce-cli",
        "containerd.io",
        "docker-buildx-plugin",
        "docker-compose-plugin"
      ]
      write_files = [
        {
          path    = "/etc/sysctl.d/enabled_ipv4_forwarding.conf"
          content = "net.ipv4.conf.all.forwarding=1\n"
        },
        {
          path        = "/home/ubuntu/created-by-cloud-init.txt"
          owner       = "ubuntu:ubuntu"
          permissions = "0770"
          defer       = true
          content     = "Lorem ipsum odor amet, consectetuer adipiscing elit.\n"
        },
        {
          path         = "/tmp/create-runner.sh"
          content_type = "text/x-shellscript"
          content = sensitive(
            templatefile("${path.module}/create-runner.sh", {
              gh_pat = var.gh_pat
          }))
          owner       = "ubuntu"
          permissions = "0777"
          defer       = true
        }
      ]

      runcmd = [
        "iptables -P INPUT ACCEPT",
        "iptables -P FORWARD ACCEPT",
        "iptables -P OUTPUT ACCEPT",
        "mkdir /actions-runner",
        ["chown", "ubuntu:ubuntu", "/actions-runner"],
        "sudo -u ubuntu bash /tmp/create-runner.sh",
        "cd /actions-runner",
        "./svc.sh install",
        "./svc.sh start",
        # Uncomment next line to launch github action and deploy actual application on the host
        # curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer <redacted>" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos//actions/workflows/140544536/dispatches -d '{"ref":"main"}'"
      ]
    })
  }
}

