provider "metal" {
  auth_token = var.auth_token
}

resource "metal_spot_market_request" "bastion" {
  project_id       = var.project_id
  max_bid_price    = 0.17
  facilities       = [var.facility]
  devices_min      = 1
  devices_max      = 1
  wait_for_devices = true

  instance_parameters {
    hostname         = "bastion.${var.cluster_name}.${var.cluster_basedomain}"
    billing_cycle    = var.billing_cycle
    operating_system = var.operating_system
    plan             = var.plan
  }
}

data "metal_spot_market_request" "dbastion" {
  request_id = metal_spot_market_request.bastion.id
}

data "metal_device" "devs" {
  count     = length(data.metal_spot_market_request.dbastion.device_ids)
  device_id = data.metal_spot_market_request.dbastion.device_ids[count.index]
}

resource "metal_vlan" "vlan" {
  description = "VLAN for OCP"
  metro       = "sy"
  project_id  = var.project_id
  vxlan       = 2000
}

resource "metal_port_vlan_attachment" "bastion" {
  count     = length(data.metal_spot_market_request.dbastion.device_ids)
  device_id = data.metal_spot_market_request.dbastion.device_ids[count.index]
  port_name = "bond0"
  vlan_vnid = 2000
}

##############################################

resource "metal_spot_market_request" "master0" {
  project_id       = var.project_id
  max_bid_price    = 0.36
  facilities       = [var.facility]
  devices_min      = 1
  devices_max      = 1
  wait_for_devices = true

  instance_parameters {
    hostname         = "master0.${var.cluster_name}.${var.cluster_basedomain}"
    billing_cycle    = var.billing_cycle
    operating_system = "custom_ipxe"
    ipxe_script_url  = "http://45.76.124.19:8080/ipxe"
    plan             = var.plan_controlplane
    #always_pxe       = true
  }
}

data "metal_spot_market_request" "dmaster0" {
  request_id = metal_spot_market_request.master0.id
}

data "metal_device" "master0" {
  count     = length(data.metal_spot_market_request.dmaster0.device_ids)
  device_id = data.metal_spot_market_request.dmaster0.device_ids[count.index]
}

resource "metal_device_network_type" "master0" {
  count     = length(data.metal_spot_market_request.dmaster0.device_ids)
  device_id = data.metal_spot_market_request.dmaster0.device_ids[count.index]
  type      = "hybrid"
}

resource "metal_port_vlan_attachment" "master0" {
  count      = length(data.metal_spot_market_request.dmaster0.device_ids)
  device_id  = data.metal_spot_market_request.dmaster0.device_ids[count.index]
  port_name  = "eth1"
  force_bond = true
  vlan_vnid  = 2000
}

##############################################

resource "metal_spot_market_request" "master1" {
  project_id       = var.project_id
  max_bid_price    = 0.36
  facilities       = [var.facility]
  devices_min      = 1
  devices_max      = 1
  wait_for_devices = true

  instance_parameters {
    hostname         = "master1.${var.cluster_name}.${var.cluster_basedomain}"
    billing_cycle    = var.billing_cycle
    operating_system = "custom_ipxe"
    ipxe_script_url  = "http://45.76.124.19:8080/ipxe"
    plan             = var.plan_controlplane
    #always_pxe       = true
  }
}

data "metal_spot_market_request" "dmaster1" {
  request_id = metal_spot_market_request.master1.id
}

data "metal_device" "master1" {
  count     = length(data.metal_spot_market_request.dmaster1.device_ids)
  device_id = data.metal_spot_market_request.dmaster1.device_ids[count.index]
}

resource "metal_device_network_type" "master1" {
  count     = length(data.metal_spot_market_request.dmaster1.device_ids)
  device_id = data.metal_spot_market_request.dmaster1.device_ids[count.index]
  type      = "hybrid"
}

resource "metal_port_vlan_attachment" "master1" {
  count      = length(data.metal_spot_market_request.dmaster1.device_ids)
  device_id  = data.metal_spot_market_request.dmaster1.device_ids[count.index]
  port_name  = "eth1"
  force_bond = true
  vlan_vnid  = 2000
}

##############################################

resource "metal_spot_market_request" "master2" {
  project_id       = var.project_id
  max_bid_price    = 0.36
  facilities       = [var.facility]
  devices_min      = 1
  devices_max      = 1
  wait_for_devices = true

  instance_parameters {
    hostname         = "master2.${var.cluster_name}.${var.cluster_basedomain}"
    billing_cycle    = var.billing_cycle
    operating_system = "custom_ipxe"
    ipxe_script_url  = "http://45.76.124.19:8080/ipxe"
    plan             = var.plan_controlplane
    #always_pxe       = true
  }
}

data "metal_spot_market_request" "dmaster2" {
  request_id = metal_spot_market_request.master2.id
}

data "metal_device" "master2" {
  count     = length(data.metal_spot_market_request.dmaster2.device_ids)
  device_id = data.metal_spot_market_request.dmaster2.device_ids[count.index]
}

resource "metal_device_network_type" "master2" {
  count     = length(data.metal_spot_market_request.dmaster2.device_ids)
  device_id = data.metal_spot_market_request.dmaster2.device_ids[count.index]
  type      = "hybrid"
}

resource "metal_port_vlan_attachment" "master2" {
  count      = length(data.metal_spot_market_request.dmaster2.device_ids)
  device_id  = data.metal_spot_market_request.dmaster2.device_ids[count.index]
  port_name  = "eth1"
  force_bond = true
  vlan_vnid  = 2000
}
