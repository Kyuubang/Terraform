terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

provider "virtualbox" {
  # Configuration options
}

resource "virtualbox_vm" "pod" {
  count     = 3
  name      = format("pod-%02d", count.index + 1)
  image = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-vagrant.box"
  cpus      = 2
  memory    = "1024 mib"

  network_adapter {
    type           = "bridged"
    host_interface = "wlan0"
  }
}

output "IPAddr" {
  value = element(virtualbox_vm.pod.*.network_adapter.0.ipv4_address, 1)
}

output "IPAddr_2" {
  value = element(virtualbox_vm.pod.*.network_adapter.0.ipv4_address, 2)
}
