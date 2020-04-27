provider "openstack" {
  cloud = "skyhigh"
}

resource "openstack_compute_instance_v2" "tftest" {
  name            = "tftest"
  image_id        = "ede97ce4-3ff9-443a-a164-edde60af0498"
  flavor_name     = "m1.tiny"
  key_pair        = "larserik-helene"
  security_groups = ["default", "linux"]

  network {
    name = "larsep-net"
  }
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool     = "ntnu-internal"
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.tftest.id}"
}
